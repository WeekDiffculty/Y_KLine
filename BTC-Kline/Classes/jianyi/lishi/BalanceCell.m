//
//  BalanceCell.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/24.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "BalanceCell.h"
@interface BalanceCell()
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *balance;
@property (weak, nonatomic) IBOutlet UILabel *blance;

@end
@implementation BalanceCell

+ (instancetype) balanceCellWith:(UITableView *)tableView{
    static NSString *strID = @"balanceCell";
    BalanceCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BalanceCell" owner:NSMetadataUbiquitousItemURLInLocalContainerKey options:nil] firstObject];
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
