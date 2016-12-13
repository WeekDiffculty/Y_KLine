//
//  HQViewController.m
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//
#import "MJRefresh.h"
#import <UIKit/UIKit.h>
#import "HQViewController.h"
#import "Glob.h"
#import "SimpleCell.h"
#import "SeniorCell.h"
#import "SymbolModel.h"
#import "SymbolListTableViewController.h"
#import "EdtingTableViewController.h"
#import "OptionView.h"
#import "JSViewController.h"
#import "NSString+md5.h"
@interface HQViewController ()<UITableViewDataSource,UITableViewDelegate,OptionViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *simpleOrSeniorModel;
@property (nonatomic, weak) OptionView *optionView;
@property (nonatomic, weak) UITableView *tabView;
@property (nonatomic, copy) NSArray *arrayData;
@property (nonatomic) BOOL isSenior;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *noDateView;
@end

@implementation HQViewController
- (UILabel *)noDateView{
    if (!_noDateView) {
        _noDateView = [[UILabel alloc]initWithFrame:self.view.frame];
        _noDateView.text = @"网络或服务器异常，检查网络，联系服务提供商。";
        [_noDateView setAdjustsFontSizeToFitWidth:YES];
        _noDateView.textAlignment = NSTextAlignmentCenter;
        _noDateView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:_noDateView];
    }
    return _noDateView;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.frame = self.view.frame;
        _backView.backgroundColor = [UIColor grayColor];
        _backView.alpha= 0.95;
        [self.view addSubview:_backView];
    }
    return _backView;
}

- (OptionView *)optionView{
    if (!_optionView) {
        _optionView = [OptionView optionView];
        _optionView.OptinViewDelegate = self;
        _optionView.alpha = 1;
    }
    return _optionView;
}
//初始化，把列表写入沙盒
+(void)load{
    NSString *versionNew = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    NSString * versionOld= [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    if ([versionOld isEqualToString:versionNew]) { //
        
       
    }else{
        NSString *path = [[NSBundle mainBundle]pathForResource:@"goods" ofType:@"plist"];
        NSArray *array  = [NSArray arrayWithContentsOfFile:path];
        [array writeToFile: [GoodsPath sharePath].goodsPath atomically:YES];
        [array writeToFile:[GoodsPath sharePath].currentGoodsPath atomically:YES];
        [[NSUserDefaults standardUserDefaults]setObject:versionOld forKey:@"version"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }

}
- (NSArray *)arrayData{
    if (!_arrayData) {
               NSArray *array  = [NSArray arrayWithContentsOfFile:[GoodsPath sharePath].currentGoodsPath];
               NSInteger count = array.count;
        NSMutableArray *arraM = [NSMutableArray arrayWithCapacity:count];
        for (NSInteger index = 0; index < count; index ++) {
            NSDictionary *dict = array[index];
            SymbolModel *model = [SymbolModel returnModelWithDictionry:dict];
            [arraM addObject:model];
        }
        _arrayData = [arraM copy];
    }
    return  _arrayData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDefaultSetting];
   
}
- (void)loadDefaultSetting{
    UITableView *tableView = [[UITableView alloc]init];
    [self.view addSubview:tableView];
    tableView.frame = CGRectMake(0, 0, Width, Height-44);
    self.tabView = tableView;
    tableView.delegate= self;
    tableView.dataSource = self;
    [tableView setRowHeight:60];
    [self.view addSubview:self.noDateView];
//    NSString *str = @"12345";
//    NSLog(@"%@",[NSString md5HexDigest:str]);
//    NSLog(@"%@",[NSString md5HexDigest:str]);
    
}
//监测网络
- (void) chekNet{
    [NetWorking netStatus:HQJK success:^(BOOL netIsconnect) {
        if (netIsconnect) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.noDateView removeFromSuperview];
                self.noDateView = nil;
                NSLog(@"%@", self.arrayData);
                [self.tabView reloadData]; 
            });
                   }else{
            [self.view addSubview:self.noDateView];
            self.arrayData = nil;
            [self tip:@"网络或服务器异常，请稍后再试"];
        }
    }];
}
- (void)tip:(NSString *)str{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"知道了" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:yes];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)refresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger count = self.arrayData.count;
        for (NSInteger index = 0; index < count; index ++) {
            [self.tabView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
  
    });
}
- (IBAction)changeSimpleOrSeniorModel:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex==0) {
        self.isSenior = NO;
    }else{
        self.isSenior = YES;
 
    }
  [self.tabView reloadData];
}
- (IBAction)addSymbol:(UIBarButtonItem *)sender {
    SymbolListTableViewController *symbolList = [[SymbolListTableViewController alloc]init];
    [self.navigationController pushViewController:symbolList animated:YES];
}
- (IBAction)edtingSymbol:(UIBarButtonItem *)sender {
    EdtingTableViewController *edtingVC = [[EdtingTableViewController alloc]init];
    [self.navigationController pushViewController:edtingVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SymbolModel *model = self.arrayData[indexPath.row];
    if (self.isSenior) {
        SeniorCell *seniorCell = [SeniorCell seniorCellWithTableView:tableView];
        
        seniorCell.symbol = model.symbolName;
        return seniorCell;
    }else{
        SimpleCell *simpleCell = [SimpleCell simpleCellWithTableView:tableView];
        simpleCell.symbol = model.symbolName;
        return simpleCell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SymbolModel *model = self.arrayData[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.optionView];
    self.optionView.tittle = model.symbolName;
    self.optionView.frame= CGRectMake(75, 200, Width-150, 200);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removView];
}
- (void)removView{
    [self.optionView removeFromSuperview];
    self.optionView = nil;
    [self.backView removeFromSuperview];
    self.backView = nil;
}
- (void)viewWillAppear:(BOOL)animated{
    [self chekNet];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
    [self.timer fire];
    self.arrayData = nil;
    NSLog(@"%@", self.arrayData);
    [self.tabView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma OptionviewDelegate
- (void)OpenTubiaoWithoptionView:(UIView *)optionView withSymbol:(NSString *)symbol{
    if (self.HQdelegate) {
        [self.HQdelegate openTubiaoWithVC:self withSymbol:symbol];
    }
    [self removView];
}
-(void)JiaoyishuxingWithOptionView:(UIView *)optionView withSymbol:(NSString *)symbol {
    JSViewController *JSVC = [JSViewController new];
    JSVC.symbol = symbol;
    [self.navigationController pushViewController:JSVC animated:YES];
    [self removView];
}

- (void)OpenJiaoyiWithoptionView:(UIView *)optionView withSymbol:(NSString *)symbol{
    if (self.HQdelegate) {
        [self.HQdelegate openJiaoyiWithVC:self withSymbol:symbol];
    }
    [self removView];
}

@end
