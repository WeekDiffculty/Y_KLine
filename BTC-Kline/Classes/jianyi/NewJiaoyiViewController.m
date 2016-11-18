//
//  NewJiaoyiViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/16.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "NewJiaoyiViewController.h"
#import "Glob.h"
@interface NewJiaoyiViewController ()
@property (weak, nonatomic) IBOutlet UILabel *symbolAndDescriptions;
@property (weak, nonatomic) IBOutlet UILabel *cmd;
@property (weak, nonatomic) IBOutlet UILabel *volum;
@property (weak, nonatomic) IBOutlet UITextField *volumValue;
@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UIButton *forword;
@property (weak, nonatomic) IBOutlet UIButton *fastBack;
@property (weak, nonatomic) IBOutlet UIButton *fastForword;
@property (weak, nonatomic) IBOutlet UITextField *symBol;
@property (weak, nonatomic) IBOutlet UITextField *CmdtextField;
@property (nonatomic) CGFloat volums;
@end

@implementation NewJiaoyiViewController

- (CGFloat)volums{
    if(!_volums){
        _volums = self.volumValue.text.floatValue;
    }
    return  _volums;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDefaultSetting];
}

- (instancetype)init{
    if (self = [super init]) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Jiaoyi" bundle:nil];
        self = [storyBoard instantiateViewControllerWithIdentifier:@"NewJiaoyiViewController.h"];
    }
    return self;
}
- (void) loadDefaultSetting{
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
- (IBAction)fastBack:(UIButton *)sender {
    self.volums -= 0.1;
    self.volumValue.text = [NSString stringWithFormat:@"%g",self.volums];
}
- (IBAction)back:(UIButton *)sender {
    self.volums -= 0.01;
    self.volumValue.text = [NSString stringWithFormat:@"%g",self.volums];
}
- (IBAction)forword:(UIButton *)sender {
    self.volums += 0.01;
    self.volumValue.text = [NSString stringWithFormat:@"%g",self.volums];
}
- (IBAction)fastForword:(UIButton *)sender {
    self.volums += 0.1;
    self.volumValue.text = [NSString stringWithFormat:@"%g",self.volums];
}


@end
