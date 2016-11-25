//
//  NextJiaoyiViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/18.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "NextJiaoyiViewController.h"
#import "Glob.h"
#import "HangQing.h"
@interface NextJiaoyiViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *symbolanddescription;
@property (weak, nonatomic) IBOutlet UILabel *cmds;
@property (weak, nonatomic) IBOutlet UILabel *volumss;
@property (weak, nonatomic) IBOutlet UITextField *zhisun;
@property (weak, nonatomic) IBOutlet UITextField *huoli;
@property (weak, nonatomic) IBOutlet UITextField *piancha;
@property (weak, nonatomic) IBOutlet UILabel *gewei;
@property (weak, nonatomic) IBOutlet UILabel *fenshu;
@property (weak, nonatomic) IBOutlet UILabel *lifang;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *volume;
@property (nonatomic, copy) NSString *CMD;
@property (nonatomic, copy) NSString *SL;
@property (nonatomic, copy) NSString *TP;
@property (nonatomic, copy) NSString *server;
@property (nonatomic, strong) NSTimer *timer;
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.zhisun resignFirstResponder];
    [self.huoli resignFirstResponder];
    [self.piancha resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)sell:(id)sender {
    
}

- (IBAction)Openorder:(id)sender {
    
    Account *ccount = [NSKeyedUnarchiver unarchiveObjectWithFile:[GoodsPath sharePath].account];
    NSString *openURL = [NSString stringWithFormat:@"%@?type=%@&volume=%@&price=%@&symbol=%@&cmd=%@&SL=%@,&TP=%@&server=%@&login=%@&pwd=%@",CLOSE_POSITION,@"openorder",self.volume,@11,self.model.symbolName,@"1",@0,@0,self.server,ccount.account,ccount.password];
    [NetWorking openPositionWithApi:openURL param:nil success:^(NSDictionary *responseObject) {
        
    } fail:^(NSError *error) {
        
    }];
}

- (void)setCurrentPrice{
    NSString *url = [HQJK stringByAppendingString:self.model.symbolName];
    [NetWorking requestHQWithApi:url param:nil success:^(HangQing *responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *array = @[self.gewei,self.fenshu,self.lifang];
            [self changeColor:[responseObject.price substringFromIndex:(responseObject.price.length -1)].integerValue labelArray:array];
        });
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
- (void)viewWillAppear:(BOOL)animated{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(setCurrentPrice) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)changeColor:(NSInteger )length labelArray:(NSArray *)labelArray{
    
    for (NSInteger index = 0; index < labelArray.count -1; index ++) {
        UILabel *label = labelArray[index];
        if (length%2==0) {
            label.textColor = [UIColor redColor];
        }else{
            label.textColor = [UIColor blueColor];
        }
    }
}

@end
