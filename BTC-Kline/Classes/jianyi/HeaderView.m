//
//  HeaderView.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/14.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "HeaderView.h"
#import "Glob.h"
@interface HeaderView ()

@end
@implementation HeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
    static NSString *strId = @"HeaderFooter";
    HeaderView *headerView = [[HeaderView alloc]initWithReuseIdentifier:strId];
    
        return  headerView;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self loadDefaultSetting];
    }
    return self;
}
- (void) loadDefaultSetting{
    UIView *view = [[UIView alloc]init];
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.leading.bottom.equalTo(self.contentView);
    }];
    UIView *leftView = [[UIView alloc]init];
    UIView *rightView = [[UIView alloc]init];
    leftView.backgroundColor = [UIColor redColor];
    [view addSubview:leftView];
    [view addSubview:rightView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.bottom.equalTo(view);
    }];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.equalTo(view);
        make.width.equalTo(leftView);
    }];
    [self leftViews:leftView];
}

- (void)leftViews:(UIView *)leftView{
    UILabel *symbolLabel = [[UILabel alloc]init];
    UILabel *statusLabel = [[UILabel alloc]init];
    UILabel *priceLabel = [[UILabel alloc]init];
    [leftView addSubview:symbolLabel];
    [leftView addSubview:statusLabel];
    [leftView addSubview:priceLabel];
    
}
@end
