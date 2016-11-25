//
//  BalanceDetailCell.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/24.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "BalanceDetailCell.h"

@implementation BalanceDetailCell

+ (instancetype) balanceDetailCellWith:(UITableView *)tableView{
    static NSString *strID = @"balanceDetailCell";
    BalanceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BalanceDetailCell" owner:nil options:nil] firstObject];
    }
    return cell;
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
