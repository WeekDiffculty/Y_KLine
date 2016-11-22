//
//  Tool.h
//  StringToDict
//
//  Created by yfwl on 16/11/21.
//  Copyright © 2016年 Yfwl_LCL. All rights reserved.
//  正则，将字符串转换为字典

#import <Foundation/Foundation.h>

@interface Tool : NSObject
+ (instancetype)toolWithString:(NSString *)string;
- (NSDictionary *)dict;
@end
