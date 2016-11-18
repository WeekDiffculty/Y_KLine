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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self login:nil];
    return YES;
}


- (IBAction)login:(UIBarButtonItem *)sender {
    [self.account resignFirstResponder];
    [self.password resignFirstResponder];
    if (![self.account.text isEqualToString:@""]&&![self.password.text isEqualToString:@""]) {
        [NetWorking checkAccountWithApi:ACCOUNT_PASSWORD account:self.account.text password:self.password.text success:^(NSDictionary *responseObject) {
            [self loginSucessBack];
        } fail:^(NSError *error) {
            [self tip:@"登陆失败，检查网络或联系交易服务商"];
        }];
    }else{
        [self tip:@"用户名密码不能为空"];
    }
}

-(void)loginWithceshi{
    [NetWorking checkAccountWithApi:ACCOUNT_PASSWORD account:@"8888666" password:@"abc123456" success:^(NSDictionary *responseObject) {
        [self loginSucessBack];
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)loginSucessBack{
    [[ViewController new]setSelectedIndex:0];
    WeakObj(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself.navigationController popToRootViewControllerAnimated:YES];
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
