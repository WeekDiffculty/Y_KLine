//
//  jioayiModel.h
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/23.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface jioayiModel : NSObject
@property (nonatomic, copy) NSString *order;
@property (nonatomic, copy) NSString *symbol;
@property (nonatomic, copy) NSString *cmd;
@property (nonatomic, copy) NSString *volume;
@property (nonatomic, copy) NSString *sl;
@property (nonatomic, copy) NSString *tp;
@property (nonatomic, copy) NSString *open_price;
@property (nonatomic, copy) NSString *open_time;
@property (nonatomic, copy) NSString *close_time;
@property (nonatomic, copy) NSString *close_price;
@property (nonatomic, copy) NSString *profit;
@property (nonatomic, copy) NSString *value_date;
@property (nonatomic, copy) NSString *expiration;
@property (nonatomic, copy) NSString *commisson;
@property (nonatomic, copy) NSString *swap;
+ (instancetype)returnJiaoyiModelWithDictionary:(NSDictionary *)dict;
@end
