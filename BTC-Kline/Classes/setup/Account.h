//
//  Account.h
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/17.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject
@property (nonatomic, strong)NSString *account;
@property (nonatomic, strong)NSString *password;
+ (instancetype)shareAccount;
@end
