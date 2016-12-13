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
#import "KViewController.h"
@interface ViewController ()<HQVCDelegate,JYDElegate,KViewVCDelegate>

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
    UINavigationController *TuBiaoNAvc = self.viewControllers[1];
    KViewController *KVC = TuBiaoNAvc.viewControllers.firstObject;
    KVC.delegate = self;
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
    [self ToNewJiaoyiWithSymbol:symbol];
}
- (void)openTubiaoWithVC:(UIViewController *)VC withSymbol:(NSString *)symbol{
    [self ToTubiaoWithSymbol:symbol];
}
#pragma JYDELEGATE<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
- (void)openTubiao:(UIViewController *)VC withSymbol:(NSString *)symbol{
    [self ToTubiaoWithSymbol:symbol];
}
- (void)opennewJiaoyi:(UIViewController *)VC withSymbol:(NSString *)symbol{
    [self ToNewJiaoyiWithSymbol:symbol];
}
#pragma KVIEWDELEGATE<<<<<<<新交易<<<<<<<<<<<<<<<<<<<
-(void)KViewVC:(UIViewController *)KViewController withSymbol:(NSString *)symbol{
    [self ToNewJiaoyiWithSymbol:symbol];
}

//打开图表对应商品
- (void)ToTubiaoWithSymbol:(NSString *)symbol{
    [self setSelectedIndex:1];
//    UINavigationController *jiaoyiNAvc = self.viewControllers[1];
//    KViewController *VIEWVC = jiaoyiNAvc.viewControllers.firstObject;
//    [VIEWVC openAndSelectedSymbol:symbol];
}
//打开新交易对应商品
- (void)ToNewJiaoyiWithSymbol:(NSString *)symbol{
    [self setSelectedIndex:2];
    NewJiaoyiViewController *newVC = [NewJiaoyiViewController new];
    newVC.symbol = symbol;
    [self.viewControllers[2] pushViewController:newVC animated:YES];

}
- (BOOL)shouldAutorotate
{
    return NO;
}
@end
