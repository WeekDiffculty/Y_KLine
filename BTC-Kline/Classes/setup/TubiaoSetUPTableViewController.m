//
//  TubiaoSetUPTableViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/14.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "TubiaoSetUPTableViewController.h"
#import "Glob.h"
@interface TubiaoSetUPTableViewController ()
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
@property (nonatomic, strong) UIView *colorView ;
@end

@implementation TubiaoSetUPTableViewController

- (UIView *)colorView{
    if (!_colorView) {
        _colorView = [[UIView alloc]init];
        for (NSInteger index = 0; index<4; index ++) {
            UIButton *button = [[UIButton alloc]init];
            
            [_colorView addSubview:button];
        }
    }
    return _colorView;
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
   
    self.color.textLabel.text = @"颜色";
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
