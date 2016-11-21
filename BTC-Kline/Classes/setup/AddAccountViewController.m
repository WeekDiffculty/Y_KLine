//
//  AddAccountViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/17.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "AddAccountViewController.h"
#import "LoginViewController.h"
@interface AddAccountViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *xuni;
@property (weak, nonatomic) IBOutlet UITableViewCell *zhenshi;

@end

@implementation AddAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDefaultSetting];
}

- (void)loadDefaultSetting{
    self.title = @"新账户";
    self.xuni.textLabel.text = @"无需注册，自动生成测试账户登录";
    self.xuni.detailTextLabel.text = @"测试账号";
    self.zhenshi.textLabel.text = @"使用交易商获取的账号密码登录";
    self.zhenshi.detailTextLabel.text = @"交易账号";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        [[LoginViewController new] loginWithceshi];
        
    }else if(indexPath.row ==1){
        
    }
}
@end
