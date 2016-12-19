//
//  YStockChartViewController.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/27.
//  Copyright © 2016年 yate1996. All rights reserved.
//  K图控制器
#import "ChangeCanshuViewController.h"
#import "Y_StockChartViewController.h"
#import "Masonry.h"
#import "Y_StockChartView.h"
#import "Y_StockChartView.h"
#import "NetWorking.h"
#import "Y_KLineGroupModel.h"
//颜色配置类
#import "UIColor+Y_StockChart.h"
#import "AppDelegate.h"
#import "Glob.h"
#import "ChangeCanshuViewController.h"
@interface Y_StockChartViewController ()<Y_StockChartViewDataSource>

@property (nonatomic, strong) Y_StockChartView *stockChartView;

//k图组model
@property (nonatomic, strong) Y_KLineGroupModel *groupModel;

//不同类型的K图组model
@property (nonatomic, copy) NSMutableDictionary <NSString*, Y_KLineGroupModel*> *modelsDict;

@property (nonatomic, assign) NSInteger currentIndex;
//类型 1min 5min 1d
@property (nonatomic, copy) NSString *type;
//计时器
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation Y_StockChartViewController
- (NSString *)symbolName{
    if (!_symbolName) {
        _symbolName = @"USDJPY";
    }
    return _symbolName;
}
- (NSTimer *)timer{
    if (!_timer) {
        _timer =  [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(reloadData) userInfo:nil repeats:YES];
    }
    return  _timer;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.timer fire];
    [super viewWillAppear:animated];
    //隐藏状态栏
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.timer invalidate];
    _timer = nil;
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentIndex = -1;
    //所有图表的背景颜色
    self.stockChartView.backgroundColor = [UIColor backgroundColor];
}

- (NSMutableDictionary<NSString *,Y_KLineGroupModel *> *)modelsDict
{
    if (!_modelsDict) {
        _modelsDict = @{}.mutableCopy;
    }
    return _modelsDict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of  nmthat can be recreated.
}

-(id) stockDatasWithIndex:(NSInteger)index
{
    NSString *type;
    switch (index) {
        case 0:
        {
            type = @"1min";
        }
            break;
        case 1:
        {
            type = @"1min";
        }
            break;
        case 2:
        {
            type = @"1min";
        }
            break;
        case 3:
        {
            type = @"5min";
        }
            break;
        case 4:
        {
            type = @"30min";
        }
            break;
        case 5:
        {
            type = @"1hour";
        }
            break;
        case 6:
        {
            type = @"1day";
        }
            break;
        case 7:
        {
            type = @"1week";
        }
            break;
            
        default:
            break;
    }
    
    self.currentIndex = index;
    self.type = type;
    if(![self.modelsDict objectForKey:type])
    {
        [self reloadData];
    } else {
        return [self.modelsDict objectForKey:type].models;
    }
    return nil;
}

- (void)reloadData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    // 周期  时间戳 symbol
    NSString *endTime = [self getCurrentTimestamp];
    NSString *startTime = [self getStartTimestampWithType:self.type];
    param[@"symbol"] = self.symbolName; //symbol
    param[@"starttime"] = startTime;
    param[@"endtime"] = endTime;
    [NetWorking historyKlineQueryWithApi:param success:^(NSDictionary *responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger digits = [responseObject[@"digits"] integerValue];
            [[NSUserDefaults standardUserDefaults]setInteger:digits forKey:@"digits"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            if (![responseObject[@"data"] isKindOfClass:[NSArray class]]) {
                return ;
            }
            Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:responseObject[@"data"]withcurrentPrice:responseObject[@"currentprice"]] ;
          
            NSArray *aray = responseObject[@"data"];
            [aray writeToFile:@"/Users/bf/Desktop/djj.plist" atomically:YES];;
            self.groupModel = groupModel;
            [self.modelsDict setObject:groupModel forKey:self.type];
            NSLog(@"%@",groupModel);
            [self.stockChartView reloadData];
        });
            } fail:^(NSError *error) {
        
    }];
}

-(NSString*)getCurrentTimestamp{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    return timeString;
    
}

- (NSString *)getStartTimestampWithType:(NSString *)type{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
     NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    NSInteger time = timeString.integerValue;
    NSString *starttime ;
    if ([self.type isEqualToString:@"1min"]) {
        starttime  = [NSString stringWithFormat:@"%ld",time-60];
    }
    
    if ([self.type isEqualToString:@"5min"]) {
        starttime  = [NSString stringWithFormat:@"%ld",time-300];
    }
    if ([self.type isEqualToString:@"30min"]) {
        starttime  = [NSString stringWithFormat:@"%ld",time-1800];
    }
    if ([self.type isEqualToString:@"1hour"]) {
        starttime  = [NSString stringWithFormat:@"%ld",time-3600];
    }
    if ([self.type isEqualToString:@"1day"]) {
        starttime  = [NSString stringWithFormat:@"%ld",time-86400];
    }
    if ([self.type isEqualToString:@"1week"]) {
        starttime  = [NSString stringWithFormat:@"%ld",time-604800];
    }
    
    return starttime;

}
- (Y_StockChartView *)stockChartView
{
    if(!_stockChartView) {
        _stockChartView = [Y_StockChartView new];
        _stockChartView.itemModels = @[
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"指标" type:Y_StockChartcenterViewTypeOther],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"分时" type:Y_StockChartcenterViewTypeTimeLine],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"M1" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"M5" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"M30" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"H1" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"D1" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"W1" type:Y_StockChartcenterViewTypeKline],
 
                                       ];
        _stockChartView.backgroundColor = [UIColor orangeColor];
        _stockChartView.dataSource = self;
        [self.view addSubview:_stockChartView];
        [_stockChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
            }
    return _stockChartView;
}


- (void)changeCanshu{
    ChangeCanshuViewController *changeVC = [[ChangeCanshuViewController alloc]init];
    [self.navigationController pushViewController:changeVC animated:YES];
}
- (void)tip:(NSString *)str{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"知道了" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:yes];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
