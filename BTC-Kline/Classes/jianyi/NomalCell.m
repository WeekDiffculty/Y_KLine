//
//  NomalCell.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/17.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "NomalCell.h"
@interface NomalCell()
@property (weak, nonatomic) IBOutlet UILabel *symbolName;
@property (weak, nonatomic) IBOutlet UILabel *volum;
@property (weak, nonatomic) IBOutlet UILabel *starPrice;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UILabel *banlance;

@end
@implementation NomalCell

+ (instancetype)cellWith:(UITableView *)tableview{
    static NSString *strID = @"Nomalcell";
    NomalCell *cell = [tableview dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NomalCell" owner:nil options:nil] firstObject];
        
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
