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
#import "orderEdting.h"
@interface JYViewController ()<UITableViewDelegate,UITableViewDataSource,jiaoyiDelegete,orderEdtingDelegate>
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
@property (strong, nonatomic) orderEdting  *orderEdtingView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) jioayiModel *jioayiModel;
@end

@implementation JYViewController

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.frame = self.view.frame;
        _backView.backgroundColor = [UIColor grayColor];
        _backView.alpha= 0.9;
        [self.view addSubview:_backView];
    }
    return _backView;
}
- (NSArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSArray array];
    }
    return  _arrayData;
}


- (orderEdting *)orderEdtingView{
    if (!_orderEdtingView) {
        _orderEdtingView = [orderEdting optionView];
        _orderEdtingView.alpha = 1;
    }
    return _orderEdtingView;
}
 
- (void)viewWillAppear:(BOOL)animated{
    [self reloadData];
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
        cell.delegate = self;
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


- (IBAction)newJiaoyi:(UIBarButtonItem *)sender {
    NewJiaoyiViewController *jyVC = [[NewJiaoyiViewController alloc]init];
    [self.navigationController pushViewController:jyVC animated:YES];
}
#pragma NomalCelldelegate
- (void)NomalCell:(NomalCell *)cell withjiaoyiModel:(jioayiModel *)model{
    self.jioayiModel = model;
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.orderEdtingView];
    self.orderEdtingView.delegate = self;
     self.orderEdtingView.frame = CGRectMake(75, 200, Width-150, 200);
    if ([model.cmd isEqualToString:@"0"]||[model.cmd isEqualToString:@"2"]||[model.cmd isEqualToString:@"4"] ) {
        self.orderEdtingView.tittle = [NSString stringWithFormat:@"%@,%@",model.symbol,@"BUY"];
    }else{
        self.orderEdtingView.tittle = [NSString stringWithFormat:@"%@,%@",model.symbol,@"SELL"];
    }
    self.orderEdtingView.tittle = model.symbol;
}
#pragma orderEdtingDelegate
- (void)OpenPosionWithOptionView:(UIView *)optionView{
    [NetWorking unwindWithApi:CLOSE_POSITION param:self.jioayiModel success:^(NSString *responseObject) {
        if ([responseObject isEqualToString:@"error"]) {
            [self tip:@"平仓失败"];
        }else{
            [self tip:[NSString stringWithFormat:@"订单关闭，以%@价格平仓",self.jioayiModel.close_price]];
        }
    } fail:^(NSError *error) {
        [self tip:@"请检查网络是否正常"];
    }];
    [self removeTheView];
}
- (void)tip:(NSString *)str{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"知道了" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:yes];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)OpenJiaoyiWithoptionView:(UIView *)optionView{
    if ([self.delegate respondsToSelector:@selector(opennewJiaoyi)]) {
        [self.delegate opennewJiaoyi];
    }
    [self removeTheView];
}
- (void)OpenTubiaoWithoptionView:(UIView *)optionView{
    if ([self.delegate respondsToSelector:@selector(openTubiao)]) {
        [self.delegate openTubiao];
    }
    [self removeTheView];
}

- (void)removeTheView{
    [self.orderEdtingView removeFromSuperview];
    self.orderEdtingView = nil;
    [self.backView removeFromSuperview];
    self.backView = nil;

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeTheView];
}
@end
