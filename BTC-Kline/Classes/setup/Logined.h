//
//  Logined.h
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/21.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Logined : UIView
@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UILabel *group;
@property (weak, nonatomic) IBOutlet UILabel *balance;
@property (weak, nonatomic) IBOutlet UILabel *agent_account;
@property (weak, nonatomic) IBOutlet UILabel *profit;

+(instancetype)logined;
@end
