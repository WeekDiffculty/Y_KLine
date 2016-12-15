//
//  NomalCell.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/17.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "NomalCell.h"
#import "jioayiModel.h"
#import "Glob.h"
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
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ([super initWithCoder:aDecoder]) {
        [self loadDefaultSetting];
    }
    return self;
}
- (void) loadDefaultSetting{
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress)];
    [self addGestureRecognizer:longGesture];
}
- (void)longPress{
    if ([self.delegate respondsToSelector:@selector(NomalCell:withjiaoyiModel:)]) {
        [self.delegate NomalCell:self withjiaoyiModel:self.model];
    }
}


- (void)setModel:(jioayiModel *)model{
    _model = model;    
    self.symbolName.text = model.symbol;
    self.starPrice.text = model.open_price;
    if ([model.cmd isEqualToString:@"0"]) {
     self.volum.text = [NSString stringWithFormat:@"buy %@",model.volume];
    }else if([model.cmd isEqualToString:@"1"]){
       self.volum.text = [NSString stringWithFormat:@"sell %@",model.volume]; 
    }
    
    self.currentPrice.text = [NSString stringWithFormat:@"→%@" ,model.close_price];
    self.banlance.text = model.profit;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
