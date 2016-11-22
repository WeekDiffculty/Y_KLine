//
//  Account.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/17.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Account.h"
@interface Account ()<NSCoding>

@end
@implementation Account

+(instancetype)shareAccount{
    static Account *account;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        account = [[Account alloc]init];
    });
    return account;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.account = [aDecoder decodeObjectForKey:@"account"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.account forKey:@"account"];
    [aCoder encodeObject:self.password forKey:@"password"];
    
}
@end
