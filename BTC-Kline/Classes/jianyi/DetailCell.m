//
//  DetailCell.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/17.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "DetailCell.h"
#import "jioayiModel.h"
@interface DetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *symbolName;
@property (weak, nonatomic) IBOutlet UILabel *volum;
@property (weak, nonatomic) IBOutlet UILabel *starPrice;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UILabel *banlance;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *zhisun;
@property (weak, nonatomic) IBOutlet UILabel *kucunfei;
@property (weak, nonatomic) IBOutlet UILabel *huoli;
@property (weak, nonatomic) IBOutlet UILabel *shuifei;
@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *shouxufei;

@end
@implementation DetailCell
+ (instancetype) cellWith:(UITableView *)tableview{
    static NSString *strID = @"detailcell";
    DetailCell *cell = [tableview dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DetailCell" owner:nil options:nil] firstObject];
    }
    return  cell;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super initWithCoder:aDecoder]) {
       
    }
    return self;
}
- (void)setModel:(jioayiModel *)model{
    _model = model;
    self.symbolName.text = model.symbol;
    self.starPrice.text = model.open_price;
    self.volum.text = [NSString stringWithFormat:@"buy %@",model.volume];
    self.currentPrice.text = [NSString stringWithFormat:@"→%@" ,model.close_price];
    self.banlance.text = model.profit;
    NSString *time = model.open_time;
    NSTimeInterval interval=[time doubleValue] / 1.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]];
    self.time.text = timeStr;
    self.zhisun.text = @"";
    self.kucunfei.text = model.tp;
    self.huoli.text = model.sl;
    self.shuifei.text = @"";
    self.ID.text = model.order;
    self.shouxufei.text = model.commisson;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
