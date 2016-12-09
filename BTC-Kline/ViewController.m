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
@interface ViewController ()<HQVCDelegate,JYDElegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    UINavigationController *Navc = self.viewControllers[0];
    HQViewController *HQVC = Navc.viewControllers.firstObject;
    HQVC.HQdelegate = self;
    UINavigationController *jiaoyiNAvc = self.viewControllers[2];
    JYViewController *JYVC = jiaoyiNAvc.viewControllers.firstObject;
    JYVC.delegate = self;
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
#pragma HqDelegate>>>>>>>>>>>>>>>>>>>>>>>

- (void)openJiaoyiWithVC:(UIViewController *)VC withSymbol:(NSString *)symbol{
    [self setSelectedIndex:2];
    NewJiaoyiViewController *newVC = [NewJiaoyiViewController new];
    newVC.symbol = symbol;
    [self.viewControllers[2] pushViewController:newVC animated:YES];
}
- (void)openTubiaoWithVC:(UIViewController *)VC withSymbol:(NSString *)symbol{
    [self setSelectedIndex:1];

}
- (void)openTubiao{
     [self setSelectedIndex:1];
}
- (void)opennewJiaoyi{
    [self setSelectedIndex:2];
    [self.viewControllers[2] pushViewController:[NewJiaoyiViewController new] animated:YES];
}
- (BOOL)shouldAutorotate
{
    return NO;
}
@end
