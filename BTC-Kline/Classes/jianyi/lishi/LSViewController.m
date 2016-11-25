//
//  LSViewController.m
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.//


#import "LSViewController.h"
#import "NetWorking.h"
#import "Glob.h"
#import "jioayiModel.h"
#import "BalanceCell.h"
#import "BalanceDetailCell.h"
@interface LSViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *rujin;
@property (weak, nonatomic) IBOutlet UILabel *jieyu;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL isDetail;
@property (nonatomic) NSInteger openCell;
@end

@implementation LSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDefaultSetting];
}

- (void) loadDefaultSetting{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setEstimatedRowHeight:120];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}
-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.isDetail) {
        if (indexPath.row == self.openCell) {
            BalanceDetailCell *cell = [BalanceDetailCell balanceDetailCellWith:tableView];
            
            return cell;
        }else{
            BalanceCell *cell = [BalanceCell balanceCellWith:tableView];
            
            return  cell;
        }
        
    }else{
        BalanceCell *cell = [BalanceCell balanceCellWith:tableView];
        
        return  cell;
    }

    return nil;
}
- (IBAction)valueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
}

- (void)requestData{
   
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

@end
