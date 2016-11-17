//
//  SeniorCell.h
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeniorCell : UITableViewCell
@property (nonatomic, copy)NSString *symbol;
+ (instancetype)seniorCellWithTableView:(UITableView *)tableView;
@end
