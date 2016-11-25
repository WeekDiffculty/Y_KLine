//
//  jioayiModel.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/23.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "jioayiModel.h"

@implementation jioayiModel

+ (instancetype)returnJiaoyiModelWithDictionary:(NSDictionary *)dict{
    jioayiModel *model = [[jioayiModel alloc]init];
    model.order = dict[@"order"];
    model.symbol = dict[@"symbol"];
    model.cmd = dict[@"cmd"];
    model.volume = dict[@"volume"];
    model.sl = dict[@"sl"];
    model.tp = dict[@"tp"];
    model.open_price = dict[@"open_price"];
    model.open_time = dict[@"open_time"];
    model.close_time = dict[@"close_time"];
    model.close_price = dict[@"close_price"];
    model.profit = dict[@"profit"];
    model.value_date = dict[@"value_date"];
    model.expiration = dict[@"expiration"];
    model.commisson = dict[@"commisson"];
    model.swap = dict[@"swap"];
    return model ;
}

@end
