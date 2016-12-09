//
//  NomalCell.h
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/17.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  jioayiModel;
@class NomalCell;
@protocol jiaoyiDelegete <NSObject>

- (void)NomalCell:(NomalCell *)cell withjiaoyiModel:(jioayiModel *)model;

@end
@interface NomalCell : UITableViewCell
@property (nonatomic, strong) jioayiModel *model;
@property (nonatomic, weak) id <jiaoyiDelegete> delegate ;
+ (instancetype) cellWith:(UITableView *)tableview;
@end
