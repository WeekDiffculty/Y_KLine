//
//  HQViewController.m
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "HQViewController.h"
#import "Glob.h"
#import "SimpleCell.h"
#import "SeniorCell.h"
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
@end

@implementation HQViewController
- (OptionView *)optionView{
    if (!_optionView) {
        _optionView = [OptionView optionView];
        _optionView.OptinViewDelegate = self;
    }
    return _optionView;
}
- (NSArray *)arrayData{
    if (!_arrayData) {
        _arrayData = @[@"USDJPY",@"EURNZD"];
    }
    return _arrayData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDefaultSetting];
}
- (void)loadDefaultSetting{
    UITableView *tableView = [[UITableView alloc]init];
    [self.view addSubview:tableView];
    tableView.frame = CGRectMake(0, 0, Width, Height-104);
    self.tabView = tableView;
    tableView.delegate= self;
    tableView.dataSource = self;
    [tableView setRowHeight:60];
    
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell ;
    if (self.isSenior) {
        SeniorCell *seniorCell = [SeniorCell seniorCellWithTableView:tableView];
        cell = seniorCell;
        return cell;
    }else{
        SimpleCell *simpleCell = [SimpleCell simpleCellWithTableView:tableView];
        simpleCell.symbol = self.arrayData[indexPath.row];
        cell = simpleCell;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.view addSubview:self.optionView];
    self.optionView.frame= CGRectMake(75, 200, Width-150, 200);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.optionView removeFromSuperview];
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
