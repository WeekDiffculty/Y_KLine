//
//  AddAccountViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/17.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "AddAccountViewController.h"
#import "LoginViewController.h"
#define WeakObj(obj) __weak typeof(obj) weak##obj = obj
@interface AddAccountViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *xuni;
@property (weak, nonatomic) IBOutlet UITableViewCell *zhenshi;

@end

@implementation AddAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}
- (void)loadDefaultSetting{
    self.title = @"新账户";
    self.xuni.textLabel.text = @"无需注册，自动生成模拟账户登录";
    self.xuni.detailTextLabel.text = @"模拟账号";
    self.zhenshi.textLabel.text = @"使用交易商获取的账号密码登录";
    self.zhenshi.detailTextLabel.text = @"交易账号";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {//生成模拟账户
        [[LoginViewController new] loginWithceshi:^(BOOL success) {
            if (success) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [self tip:@"获取失败，检查网络"];
            }
        }];
    }else if(indexPath.row ==1){//使用账户密码登录
        UIStoryboard *stroBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *logVC = [stroBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        WeakObj(self);
        [logVC setBlock:^(BOOL issuccess) {
            if (issuccess) {
        [weakself.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
        [self presentViewController:logVC animated:YES completion:nil];
    }
}
- (void)tip:(NSString *)str{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"知道了" style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVC addAction:yes];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
