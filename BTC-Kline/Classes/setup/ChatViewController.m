//
//  ChatViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/28.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "ChatViewController.h"
#import "Glob.h"
#import "ViewController.h"
@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDefaultSetting];
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
}
- (void) loadDefaultSetting{
    
}
@end
