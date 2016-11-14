//
//  AccountViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/14.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "AccountViewController.h"
#import "Glob.h"
@interface AccountViewController ()

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDefaultSetting];
}

- (void)viewWillAppear:(BOOL)animated{
     self.navigationController.toolbarHidden = NO;
}
- (void)loadDefaultSetting{
    self.title = @"账户";
    UIButton *online = [[UIButton alloc]init];
    [self.navigationController setToolbarItems:@[online]];
    online.titleLabel.text = @"上线";
    online.titleLabel.textColor = [UIColor redColor];
    [online addTarget:self action:@selector(login ) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)login{
    
}
- (void)viewWillDisappear:(BOOL)animated{
     self.navigationController.toolbarHidden = YES;
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

@end
