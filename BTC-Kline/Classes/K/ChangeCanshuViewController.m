//
//  ChangeCanshuViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "ChangeCanshuViewController.h"
#import "Glob.h"
@interface ChangeCanshuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSDictionary *dict;
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation ChangeCanshuViewController

- (NSDictionary *)dict{
    if (!_dict) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"CANSHU" ofType:@"plist"];
        _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _dict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDefaultSetting];
}

- (void) loadDefaultSetting{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setSectionHeaderHeight:50];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.dict.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array;
    switch (section) {
        case 0:
            array = self.dict[@"趋势"];
           return  array.count;
            break;
        case 1:
            array = self.dict[@"振荡器"];
            return  array.count;
            break;
        case 2:
            array = self.dict[@"交易量"];
            return  array.count;
            break;
        case 3:
            array = self.dict[@"比尔.威廉姆斯指标"];
            return  array.count;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString  *strid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:strid];
    }
    NSInteger section = indexPath.section;
    NSArray *array;
    switch (section) {
        case 0:
            array = self.dict[@"趋势"];
            cell.textLabel.text = array[indexPath.row];
            break;
        case 1:
            array = self.dict[@"振荡器"];
            cell.textLabel.text = array[indexPath.row];
            break;
        case 2:
            array = self.dict[@"交易量"];
            cell.textLabel.text = array[indexPath.row];
            break;
        case 3:
            array = self.dict[@"比尔.威廉姆斯指标"];
            cell.textLabel.text = array[indexPath.row];
            break;
        default:            
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor grayColor];
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor whiteColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(view);
        make.bottom.equalTo(view).offset(-1);
    }];
    label.font = [UIFont systemFontOfSize:17];
    switch (section) {
        case 0:
            label.text = @"  趋势";
            break;
        case 1:
       
            label.text = @"  振荡器";
            break;
        case 2:
      
            label.text = @"  交易量";
            break;
        case 3:
      
            label.text = @"  比尔.威廉姆斯指标";
            break;
        default:
            return 0;
            break;
    }

    return view;
}
@end
