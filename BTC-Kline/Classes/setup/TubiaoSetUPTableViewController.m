//
//  TubiaoSetUPTableViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/14.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "TubiaoSetUPTableViewController.h"
#import "Glob.h"
#import "ColorView.h"
@interface TubiaoSetUPTableViewController ()<ColorViewDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *zhuxingtu;
@property (weak, nonatomic) IBOutlet UITableViewCell *yinyangzhu;
@property (weak, nonatomic) IBOutlet UITableViewCell *tubiaoxian;
@property (weak, nonatomic) IBOutlet UITableViewCell *jaioyiliang;
@property (weak, nonatomic) IBOutlet UITableViewCell *maijiaxian;
@property (weak, nonatomic) IBOutlet UITableViewCell *zhouqifengefu;
@property (weak, nonatomic) IBOutlet UITableViewCell *jiaoyijibie;
@property (weak, nonatomic) IBOutlet UITableViewCell *gaokaidishou;
@property (weak, nonatomic) IBOutlet UITableViewCell *shujuchuangkou;
@property (weak, nonatomic) IBOutlet UITableViewCell *color;
@property (nonatomic, strong) NSMutableArray *arrayButton;
@property (nonatomic, strong) ColorView *colorView ;

@end

@implementation TubiaoSetUPTableViewController
- (ColorView *)colorView{
    if (!_colorView) {
        _colorView = [[ColorView alloc]init];
        _colorView.delegate = self;
    }
    return  _colorView;
}
- (NSMutableArray *)arrayButton{
    if (!_arrayButton) {
        _arrayButton = [NSMutableArray array];
    }
    return  _arrayButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}
- (void) loadDefaultSetting{
    
    self.zhuxingtu.textLabel.text = @"柱形图";
    self.yinyangzhu.textLabel.text = @"阴阳烛";
    self.tubiaoxian.textLabel.text = @"图表线";
    NSArray *arrayFIst = @[self.zhuxingtu,self.yinyangzhu,self.tubiaoxian];
    for(NSInteger index = 0; index< 3; index ++) {
        UITableViewCell *cell = arrayFIst[index];
        [self addButtonWithCell:cell andindex:index];
    }

    self.jaioyiliang.textLabel.text = @"交易量";
    self.maijiaxian.textLabel.text = @"买价线";
    self.zhouqifengefu.textLabel.text = @"周期分隔符";
    self.jiaoyijibie.textLabel.text = @"交易类别";
    self.gaokaidishou.textLabel.text = @"高开低收";
    self.shujuchuangkou.textLabel.text = @"数据窗口";
    NSArray *array = @[self.jaioyiliang,self.maijiaxian,self.zhouqifengefu,self.jiaoyijibie,self.gaokaidishou,self.shujuchuangkou];
    for(NSInteger index = 0; index< 6; index ++) {
        UITableViewCell *cell = array[index];
         [self addSwitcherWithcell:cell andindex:index];
    }
    self.color.textLabel.text = @"图表背景颜色";
    }

- (void)addButtonWithCell:(UITableViewCell *)cell andindex:(NSInteger)index{
    UIButton *button = [[UIButton alloc]init];
    button.tag = index;
    [button addTarget:self
               action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"res_ok_22x22_"] forState:UIControlStateSelected];
    [cell.contentView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.equalTo(cell.contentView);
        make.top.equalTo(cell.contentView).offset(8);
        make.width.equalTo(@50);
    }];
    [self.arrayButton addObject:button];
}

- (void)viewWillAppear:(BOOL)animated{
  NSInteger index =  [[NSUserDefaults standardUserDefaults] integerForKey:@"typeNumber"];
    [self changeTheTypeWith:index];
}

- (void)changeTheTypeWith:(NSInteger)index{
    [[NSUserDefaults standardUserDefaults]setInteger:index forKey:@"typeNumber"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    for (NSInteger i = 0; i<3; i++) {
        UIButton *button = self.arrayButton[i];
        [button setSelected:NO];
    }
    UIButton *curentBtn = self.arrayButton[index];
    [curentBtn setSelected:YES];
}
- (void)selected:(UIButton *)button{
    switch (button.tag) {
        case 0:
            [self changeTheTypeWith:0];
            break;
        case 1:
            [self changeTheTypeWith:1];
            break;
        case 2:
            [self changeTheTypeWith:2];
            break;
        default:
            break;
    }
}
- (void)addSwitcherWithcell:(UITableViewCell *)cell andindex:(NSInteger)index{
    UISwitch *switcher = [[UISwitch alloc]init];
    switcher.tag = index;
    [switcher addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:switcher];
    [switcher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cell.contentView);
        make.trailing.equalTo(cell.contentView).offset(-8);
        make.top.equalTo(cell.contentView).offset(8);
    }];
}
- (void)valueChanged:(UISwitch *)switcher{
    switch (switcher.tag) {
        case 0://交易量
            NSLog(@"");
            break;
        case 1://买价线
             NSLog(@"");
            break;
        case 2://周期定为符
            
            break;
        case 3://交易类别
            
            break;
        case 4://数据窗口
            
            break;
        case 5://颜色
          
            break;
        default:
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
    }else if(indexPath.section ==1){
        
    }else if(indexPath.section ==2){
        
    }else if(indexPath.section ==3){
        [self toChangeColor];
    }
}
- (void)toChangeColor{
    self.colorView.frame = CGRectMake((Width -120)/2, 300, 120, 120);
    [self.view addSubview:self.colorView];
}
- (void)selectedColor:(UIView *)view{
    [self.colorView removeFromSuperview];
}
@end
