//
//  NextJiaoyiViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/18.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "NextJiaoyiViewController.h"

@interface NextJiaoyiViewController ()
@property (weak, nonatomic) IBOutlet UILabel *symbolanddescription;
@property (weak, nonatomic) IBOutlet UILabel *cmds;
@property (weak, nonatomic) IBOutlet UILabel *volumss;

@end

@implementation NextJiaoyiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDefaultSetting];
}

- (void) loadDefaultSetting{
    self.symbolanddescription.text = [NSString stringWithFormat:@"%@-%@",self.model.symbolName,self.model.descriptions];
    self.cmds.text = self.cmd;
    self.volumss.text = [NSString stringWithFormat:@"%g",self.volums];
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
