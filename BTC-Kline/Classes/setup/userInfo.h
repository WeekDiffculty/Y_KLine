//
//  userInfo.h
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/22.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userInfo : NSObject
@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *agent_account;
@property (nonatomic, copy) NSString *balance;
@property (nonatomic, copy) NSString *group;
@property (nonatomic, copy) NSString *profit;
+ (instancetype) userInfoWith:(NSDictionary *)dict;
@end
