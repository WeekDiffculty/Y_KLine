//
//  JSViewController.m
//  BTC-Kline
//
//  Created by apple on 2016/11/11.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "JSViewController.h"
#import "Glob.h"
#import "GoodsDetail.h"
@interface JSViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dianCha;
@property (weak, nonatomic) IBOutlet UILabel *xioaSHUwei;
@property (weak, nonatomic) IBOutlet UILabel *zhisunSHuiping;
@property (weak, nonatomic) IBOutlet UILabel *guadanTOquxiao;
@property (weak, nonatomic) IBOutlet UILabel *heyueSHU;
@property (weak, nonatomic) IBOutlet UILabel *lirunJisuanMOshi;
@property (weak, nonatomic) IBOutlet UILabel *kucunFeileixing;
@property (weak, nonatomic) IBOutlet UILabel *mairuKUcunfei;
@property (weak, nonatomic) IBOutlet UILabel *maichuKucunfei;
@property (weak, nonatomic) IBOutlet UILabel *yufukuanJisuan;
@property (weak, nonatomic) IBOutlet UILabel *yufukuanDuichong;

@end

@implementation JSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    NSString *str = [NSString stringWithFormat:@"%@%@",GOODSDETAIl,self.symbol];
    [NetWorking goodsDetailWithApi:str success:^(GoodsDetail *model) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //  self.dianCha.text ;
            self.xioaSHUwei.text = model.digits;
            self.zhisunSHuiping.text = model.stops_level;
            // self.guadanTOquxiao;
            self.heyueSHU.text = model.contract_size;
            // self.lirunJisuanMOshi;
            // self.kucunFeileixing;
            self.mairuKUcunfei.text = model.margin_mode;
            self.maichuKucunfei.text = model.profit_mode;
            //self.yufukuanJisuan;
            self.yufukuanDuichong.text = model.tick_value;
            self.title = model.symbol;
        });
    }];
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
