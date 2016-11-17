//
//  DetailCell.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/17.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "DetailCell.h"
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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
