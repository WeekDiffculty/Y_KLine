//
//  SymbolModel.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/15.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "SymbolModel.h"

@implementation SymbolModel

+ (instancetype)returnModelWithDictionry:(NSDictionary *)dict{
    if (!dict)     return nil;
    SymbolModel *model = [[SymbolModel alloc]init];
    model.symbolName = dict[@"symbol"];
    model.descriptions = dict[@"description"];
    return model;
}
@end
