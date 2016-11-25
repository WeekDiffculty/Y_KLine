//
//  JYViewController.m
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "JYViewController.h"
#import "Glob.h"
#import "HeaderView.h"
#import "NomalCell.h"
#import "DetailCell.h"
#import "NewJiaoyiViewController.h"
#import "jioayiModel.h"
@interface JYViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *symbolAndBanlance;
@property (strong, nonatomic) IBOutlet UIView *views;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UILabel *jieyu;
@property (weak, nonatomic) IBOutlet UILabel *jingzhi;
@property (weak, nonatomic) IBOutlet UILabel *yufukuan;
@property (weak, nonatomic) IBOutlet UILabel *keyongyufukuan;
@property (weak, nonatomic) IBOutlet UILabel *yufukuanbilv;
@property (weak, nonatomic)UITableView *tableView;
@property (nonatomic, copy) NSArray *arrayData;
@property (nonatomic) BOOL isDetail;
@property (nonatomic) NSInteger openCell;
@property (nonatomic) CGFloat profit;
@end

@implementation JYViewController

- (NSArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSArray array];
    }
    return  _arrayData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDefaultSetting];
}
- (void) loadDefaultSetting{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = CGRectMake(0, 214,Width, Height-258);
    [self.views addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    UILabel *labelHeader = [[UILabel alloc]init];
    labelHeader.backgroundColor = [UIColor grayColor];
    labelHeader.alpha = 0.6;
    labelHeader.text = @"  价位";
    labelHeader.frame = CGRectMake(0, 0, Width, 30);
    labelHeader.font = [UIFont systemFontOfSize:16];
    [labelHeader setTextAlignment:NSTextAlignmentLeft];
    [tableView setTableHeaderView:labelHeader];
    [tableView setScrollsToTop:NO];
    [tableView setShowsVerticalScrollIndicator:NO];
    [tableView setEstimatedRowHeight:120];
    
    [self reloadData];
}
#pragma  delegate >>>>>>>>>>>>>>>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.arrayData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    jioayiModel *model = self.arrayData[indexPath.row];
    if(self.isDetail) {
        if (indexPath.row == self.openCell) {
            DetailCell *cell = [DetailCell cellWith:tableView];
            cell.model = model;
            return cell;
        }else{
            NomalCell *cell = [NomalCell cellWith:tableView];
            cell.model = model;
            return  cell;
        }
        
    }else{
        NomalCell *cell = [NomalCell cellWith:tableView];
        cell.model = model;
        return  cell;
    }
}

- (void)reloadData{
     Account *ccount = [NSKeyedUnarchiver unarchiveObjectWithFile:[GoodsPath sharePath].account];
    [NetWorking checkThepositionWithApi:CHICANG account:ccount.account password:ccount.password success:^(NSArray *responseObject) {
        NSInteger count = responseObject.count;
        NSMutableArray *arraM = [NSMutableArray arrayWithCapacity:count];
        for (NSInteger index = 0; index < count; index ++) {
            jioayiModel *model = [jioayiModel returnJiaoyiModelWithDictionary:responseObject[index]];
            [arraM addObject:model];
        }
        self.arrayData = [arraM copy];
        [self.tableView reloadData];
        [self profie];
    } fail:^(NSError *error) {
        
    }];
}

- (void)profie{
    NSInteger count = self.arrayData.count;
    
    for (NSInteger index = 0; index < count; index ++) {
        jioayiModel *model = self.arrayData[index];
        self.profit += [model.profit doubleValue];
    }
    self.symbolAndBanlance.text = [NSString stringWithFormat:@"%g",self.profit];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.isDetail = !_isDetail;
    self.openCell = indexPath.row;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)newJiaoyi:(UIBarButtonItem *)sender {
    NewJiaoyiViewController *jyVC = [[NewJiaoyiViewController alloc]init];
    [self.navigationController pushViewController:jyVC animated:YES];
}
@end
