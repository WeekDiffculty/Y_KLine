//
//  Tool.m
//  StringToDict
//
//  Created by yfwl on 16/11/21.
//  Copyright © 2016年 Yfwl_LCL. All rights reserved.
//

#import "Tool.h"
#define KeyPattern @"\"[^\"]+\":"// " 非\ + ":
#define ValuePattern @":[^:,]*," //: 非：，的任意个
#define KeyAndDictPattern @"\"[^\"]+\":\\{[^\\{\\}]*\\}"
#define LastValuePattern @":[^:]*\\}"
#define DictKeyPattern @"\"[^\"]+\":\\{"

@interface Tool ()
@property (nonatomic,copy)NSString *string;
@property (nonatomic,strong)NSMutableDictionary *dictTemp;
@end

@implementation Tool

+ (instancetype)toolWithString:(NSString *)string{
    Tool *tool = [[self alloc]init];
    tool.string = string;
    return tool;
}

- (NSMutableDictionary *)dictTemp{
    if(!_dictTemp){
        _dictTemp = [NSMutableDictionary dictionary];
    }
    return _dictTemp;
}

- (NSDictionary *)dict{
    if (self.string.length == 0) return nil;
    do {
        NSArray *dict = [self resultArrayWithPattern:KeyAndDictPattern andString:self.string];
        if (dict.count > 0) {
            NSString *dictStr = [self.string substringWithRange:((NSTextCheckingResult *)(dict.firstObject)).range];
            [self replaceDictStringToStringWithDictString:dictStr];
        }else{
            return [self stringToDictWithStr:self.string];
        }
    } while (YES);
    return nil;
}

- (void)replaceDictStringToStringWithDictString:(NSString *)dict{
    NSRange range = ((NSTextCheckingResult *)[self resultArrayWithPattern:DictKeyPattern andString:dict].lastObject).range;
    NSString *dictKey = [self disposeString: [dict substringWithRange:range]];
    self.string = [self.string stringByReplacingOccurrencesOfString:dict withString:[NSString stringWithFormat:@"\"%@\":\"dict\"",dictKey]];
    dict = [dict stringByReplacingOccurrencesOfString:[dict substringWithRange:range] withString:@""];
    [self.dictTemp setValue:[self stringToDictWithStr:dict] forKey:dictKey];
    NSLog(@"1");
}

- (NSDictionary *)stringToDictWithStr:(NSString *)str{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *keyRanges = [self resultArrayWithPattern:KeyPattern andString:str];
    if (keyRanges.count > 0) {
        NSArray *valueRanges = [self resultArrayWithPattern:ValuePattern andString:str];
        NSArray *keys = [self stringFromRangeArr:keyRanges andString:str isValue:NO];
        NSArray *values = [self stringFromRangeArr:valueRanges andString:str isValue:YES];
        for (NSInteger index = 0; index < keyRanges.count; index ++ ) {
            NSString *key = keys[index];
            NSString *value = values[index];
            if ([value isEqualToString:@"dict"]) {
                [dict setValue:self.dictTemp[key] forKey:key];
            }else{
                [dict setValue:value forKey:key];
            }
        }
    }
    return dict;
}

- (NSArray<NSString *> *)stringFromRangeArr:(NSArray *)arr andString:(NSString *)str isValue:(BOOL)isValue{
    NSMutableArray *arrTemp = [NSMutableArray arrayWithCapacity:isValue ? arr.count + 1 : arr.count];
    for (NSTextCheckingResult *result in arr) {
        [arrTemp addObject:[self disposeString:[self stringArrWithRange:result.range andString:str]]];
    }
    if (isValue) {
        [arrTemp addObject:[self disposeString:[self lastValueWithStr:str]]];
    }
    return arrTemp;
}

- (NSArray *)resultArrayWithPattern:(NSString *)pattern andString:(NSString *)str{
    NSError* errorx = NULL;
    NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionDotMatchesLineSeparators error:&errorx];
    if (!exp) NSLog(@"出现错误,error:%@",errorx);
    if ([pattern isEqualToString: KeyAndDictPattern]) {
        NSTextCheckingResult *result = [exp firstMatchInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
        return result ? @[result] : [NSArray array];
    }
    return [exp matchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
}

- (NSString *)stringArrWithRange:(NSRange)range andString:(NSString *)str{
    NSString *strTemp = [str substringWithRange:range];
    if (!strTemp) {
        strTemp = @"";
    }
    return strTemp;
}

- (NSString *)disposeString:(NSString *)str{
    return [[[[[str stringByReplacingOccurrencesOfString:@":" withString:@""] stringByReplacingOccurrencesOfString:@"," withString:@""]stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""];
}

- (NSString *)lastValueWithStr:(NSString *)str{
    NSArray *lastValue = [self resultArrayWithPattern:LastValuePattern andString:str];
    return [str substringWithRange:((NSTextCheckingResult *)(lastValue.firstObject)).range];
}

@end
