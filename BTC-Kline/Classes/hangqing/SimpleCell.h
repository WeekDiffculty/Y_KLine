//
//  SimpleCell.h
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *mostLow;
@property (weak, nonatomic) IBOutlet UILabel *mostHight;
@property (nonatomic, copy)NSString *symbol;
+ (instancetype)simpleCellWithTableView:(UITableView *)tableView ;

@end
