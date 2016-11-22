//
//  userInfo.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/22.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "userInfo.h"

@implementation userInfo
+ (instancetype)userInfoWith:(NSDictionary *)dict{
    if(dict==nil)return nil;
    userInfo *userinfo = [[userInfo alloc]init];
    userinfo.login = dict[@"login"];
    userinfo.agent_account = dict[@"agent_account"];
    userinfo.balance = dict[@"balance"];
    userinfo.group = dict[@"group"];
    userinfo.profit = dict[@"profit"];
    return  userinfo;
}
@end
