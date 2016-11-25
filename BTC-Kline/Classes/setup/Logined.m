//
//  Logined.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/21.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Logined.h"
@interface Logined ()

@end
@implementation Logined

+ (instancetype)logined{
    Logined *logined = [[[NSBundle mainBundle]loadNibNamed:@"Logined" owner:nil options:nil] firstObject];
    return logined;
}

- (void)setModel:(userInfo *)model{
        _model = model;
        self.account.text = model.login;
        self.group.text = model.group;
        self.balance.text =model.balance;
        self.agent_account.text = model.agent_account;
        self.profit.text = model.profit;
}
@end
