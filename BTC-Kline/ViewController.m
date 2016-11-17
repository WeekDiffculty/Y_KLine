//
//  ViewController.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/27.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "ViewController.h"
#import "Y_KLineGroupModel.h"
#import "NetWorking.h"
#import "Y_StockChartViewController.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import "HQViewController.h"
#import "JYViewController.h"
#import "NewJiaoyiViewController.h"
@interface ViewController ()<HQVCDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    UINavigationController *Navc = self.viewControllers[0];
    HQViewController *HQVC = Navc.viewControllers.firstObject;
    HQVC.HQdelegate = self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
}
//- (IBAction)present:(id)sender {
//    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
//    appdelegate.isEable = YES;
//    Y_StockChartViewController *stockChartVC = [Y_StockChartViewController new];
//    stockChartVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:stockChartVC animated:YES completion:nil];
//}
#pragma HqDelegate>>>>>>>>>>>>>>>>>>>>>>>

- (void)openJiaoyiWithVC:(UIViewController *)VC{
    [self setSelectedIndex:2];
    [self.viewControllers[2] pushViewController:[NewJiaoyiViewController new] animated:YES];
}
- (void)openTubiaoWithVC:(UIViewController *)VC{
    [self setSelectedIndex:1];

}
- (BOOL)shouldAutorotate
{
    return NO;
}
@end
