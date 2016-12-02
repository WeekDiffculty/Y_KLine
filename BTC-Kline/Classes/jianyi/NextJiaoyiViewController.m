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


//下单

- (IBAction)Openorder:(id)sender {
    
    Account *ccount = [NSKeyedUnarchiver unarchiveObjectWithFile:[GoodsPath sharePath].account];
    NSString *cmd ;
    if ([self.CMD isEqualToString:@"即时买入"]) {
        cmd = [NSString stringWithFormat:@"%d",0];
    }
    if ([self.CMD isEqualToString:@"即时卖出"]) {
       cmd = [NSString stringWithFormat:@"%d",1];
    }if ([self.CMD isEqualToString:@"买入限价"]) {
        cmd = [NSString stringWithFormat:@"%d",2];
    }if ([self.CMD isEqualToString:@"卖出限价"]) {
      cmd = [NSString stringWithFormat:@"%d",3];
    }if ([self.CMD isEqualToString:@"买入止损"]) {
       cmd = [NSString stringWithFormat:@"%d",4];
    }if ([self.CMD isEqualToString:@"卖出止损"]) {
       cmd = [NSString stringWithFormat:@"%d",5];
    }
   
    NSString *openURL = [NSString stringWithFormat:@"%@?type=%@&volume=%@&price=%@&symbol=%@&cmd=%@&SL=%@,&TP=%@&server=%@&login=%@&pwd=%@",OPEN_POSITION,@"openorder",self.volume,self.price,self.model.symbolName,cmd,self.SL,self.TP,self.server,ccount.account,ccount.password];
    [NetWorking openPositionWithApi:openURL param:nil success:^(NSString *responseObject) {
        if ([responseObject isEqualToString:@"成功"]) {
            [self jiaoyiSuccess];
        }else{
            [self tip:@"交易失败"];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}
- (void) jiaoyiSuccess{
    [self tip:@"交易成功"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)tip:(NSString *)str{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"知道了" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:yes];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)setCurrentPrice{
    NSString *url = [HQJK stringByAppendingString:self.model.symbolName];
    WeakObj(self);
    [NetWorking requestHQWithApi:url param:nil success:^(HangQing *responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *array = @[weakself.gewei,weakself.fenshu,weakself.lifang];
            NSInteger length = responseObject.price.length;
            weakself.gewei.text = [responseObject.price substringToIndex:(length -3)];
            weakself.fenshu.text = [responseObject.price substringWithRange:NSMakeRange(length-3, 2)];
            weakself.lifang.text = [responseObject.price substringFromIndex:(length -1)];
            weakself.price = responseObject.price;
            [weakself changeColor:[responseObject.price substringFromIndex:(responseObject.price.length -1)].integerValue labelArray:array];
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
    
    for (NSInteger index = 0; index < labelArray.count ; index ++) {
        UILabel *label = labelArray[index];
        if (length%2==0) {
            label.textColor = [UIColor redColor];
        }else{
            label.textColor = [UIColor blueColor];
        }
    }
}

@end
