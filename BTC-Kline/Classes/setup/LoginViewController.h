//
//  LoginViewController.h
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/17.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (nonatomic, copy) void (^block)(BOOL);
- (IBAction)login:(UIBarButtonItem *)sender;
-(void)loginWithceshi:(void(^)(BOOL success))success;
@end
