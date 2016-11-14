//
//  HangQing.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/14.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "HangQing.h"

@implementation HangQing
+ (instancetype)hangqingModelWith:(NSArray *)array{
    if (!array||array==nil)return nil;
    HangQing *model = [[HangQing alloc]init];
    model.symble = array[0];
    model.price = array[1];
    model.time = array.lastObject;
    return model;
}
@end
