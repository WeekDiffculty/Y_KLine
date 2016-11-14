//
//  SeniorCell.m
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "SeniorCell.h"

@implementation SeniorCell

+ (instancetype) seniorCellWithTableView:(UITableView *)tableView{
    static NSString *strID = @"seniorCell";
    SeniorCell *seniorCell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!seniorCell) {
        seniorCell = [[[NSBundle mainBundle]loadNibNamed:@"SeniorCell" owner:nil options:nil] firstObject];
    }
    return seniorCell;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadDefaultSetting];
    }
    return self;
}

- (void)loadDefaultSetting{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
