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
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    userinfo.login = [formatter stringFromNumber: dict[@"login"]];
   userinfo.agent_account = [formatter stringFromNumber: dict[@"agent_account"]];
   userinfo.balance = [formatter stringFromNumber: dict[@"balance"]];
    userinfo.group = dict[@"group"];
    userinfo.profit = [formatter stringFromNumber: dict[@"profit"]];
    return  userinfo;
}
@end
