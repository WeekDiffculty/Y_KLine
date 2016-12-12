//
//  LoginViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/17.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "LoginViewController.h"
#import "Glob.h"
#import "ViewController.h"
#import "AddAccountViewController.h"
#import <RongIMKit/RongIMKit.h>
@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.password.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self login:nil];
    return YES;
}

- (IBAction)login:(UIBarButtonItem *)sender {
    [self.account resignFirstResponder];
    [self.password resignFirstResponder];
    if (![self.account.text isEqualToString:@""]&&![self.password.text isEqualToString:@""]) {
        [NetWorking checkAccountWithApi:ACCOUNT_PASSWORD account:self.account.text password:self.password.text success:^(BOOL responseObject) {
            if(responseObject){
                [self loginSucessBack:nil];
            }
        } fail:^(NSError *error) {
            [self tip:@"登陆失败，检查网络或联系交易服务商"];
        }];
    }else{
        [self tip:@"用户名密码不能为空"];
    }
}

-(void)loginWithceshi:(void(^)(BOOL success))success{
    [NetWorking checkAccountWithApi:ACCOUNT_PASSWORD account:@"999666" password:@"sst123456" success:^(BOOL responseObject) {
        if(responseObject){
            [self loginSucessBack:^(BOOL ceshi) {
                success(ceshi);
            }];
        }
    } fail:^(NSError *error) {
        success(NO);
    }];
}

- (void)loginSucessBack:(void (^)(BOOL ceshi))ceshi{
    Account *count =  [Account shareAccount];
    if (self.account&&self.password) {
        count.account = self.account.text;
        count.password = self.password.text;
    }else{
        count.account = @"999666";
        count.password = @"sst123456";
        
    }
   
    BOOL ret = [NSKeyedArchiver archiveRootObject:count toFile:[GoodsPath sharePath].account];
    NSLog(@"%@",ret?@2:@0);
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"token"] isEqualToString:@""]||![[NSUserDefaults standardUserDefaults]objectForKey:@"token"]) {
        [NetWorking getTokenWithApi:TOKEN withUserId:count.account name:count.account portraitUri:nil success:^(NSString *token) {
            [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
                NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
            } error:^(RCConnectErrorCode status) {
                NSLog(@"登陆的错误码为:%ld", status);
            } tokenIncorrect:^{
                //token过期或者不正确。
                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                NSLog(@"token错误");
            }];

        }];
    }
       WeakObj(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakself.account && weakself.password) {
            [weakself.navigationController popToRootViewControllerAnimated:YES];
        }else{
            ceshi(YES);
        }
        
    });
    
}
- (void)tip:(NSString *)str{

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"知道了" style:0 handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    [alertVC addAction:yes];
        [self presentViewController:alertVC animated:YES completion:nil];
}
@end
