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
@interface HQViewController ()<UITableViewDataSource,UITableViewDelegate,OptionViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *simpleOrSeniorModel;
@property (nonatomic, weak) OptionView *optionView;
@property (nonatomic, weak) UITableView *tabView;
@property (nonatomic, copy) NSArray *arrayData;
@property (nonatomic) BOOL isSenior;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation HQViewController
- (OptionView *)optionView{
    if (!_optionView) {
        _optionView = [OptionView optionView];
        _optionView.OptinViewDelegate = self;
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
//    // Allocate a reachability object
//    Reachability* reach = [Reachability reachabilityWithHostname:@"http://47.89.53.7:8777/api/?type=singlequote&symbol=xagusd"];
//    
//    // Set the blocks
//    reach.reachableBlock = ^(Reachability*reach)
//    {
//        // keep in mind this is called on a background thread
//        // and if you are updating the UI it needs to happen
//        // on the main thread, like this:
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"REACHABLE!");
//           
//        });
//    };
//    reach.unreachableBlock = ^(Reachability*reach)
//    {
//        NSLog(@"UNREACHABLE!");
//    };
//    // Start the notifier, which will cause the reachability object to retain itself!
//    [reach startNotifier];
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
    [self.view addSubview:self.optionView];
    self.optionView.tittle = model.symbolName;
    self.optionView.frame= CGRectMake(75, 200, Width-150, 200);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.optionView removeFromSuperview];
}
- (void)viewWillAppear:(BOOL)animated{
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
- (void)OpenTubiaoWithoptionView:(UIView *)optionView{
    if (self.HQdelegate) {
        [self.HQdelegate openTubiaoWithVC:self];
    }
    [self.optionView removeFromSuperview];
}
-(void)JiaoyishuxingWithOptionView:(UIView *)optionView{
    JSViewController *JSVC = [JSViewController new];
    [self.navigationController pushViewController:JSVC animated:YES];
    [self.optionView removeFromSuperview];
}

- (void)OpenJiaoyiWithoptionView:(UIView *)optionView{
    if (self.HQdelegate) {
        [self.HQdelegate openJiaoyiWithVC:self];
    }
    [self.optionView removeFromSuperview];
}
@end
