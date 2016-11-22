//
//  KViewController.m
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "KViewController.h"
#import "Glob.h"
#import "Y_StockChartViewController.h"
@interface KViewController ()

@end

@implementation KViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDefaultSetting];
}
- (void)loadDefaultSetting{
    Y_StockChartViewController *srockChartViewController = [[Y_StockChartViewController alloc]init];
    [self addChildViewController:srockChartViewController];
    srockChartViewController.view.frame = CGRectMake(0, 64,Width , Height-(110));
    [self.view addSubview: srockChartViewController.view];
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
