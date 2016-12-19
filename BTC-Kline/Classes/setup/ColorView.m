//
//  ColorView.m
//  BTC-Kline
//
//  Created by BF on 2016/12/19.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "ColorView.h"
#import "Masonry.h"
@interface ColorView ()
@property (nonatomic, copy)NSArray *colorArray;
@end
@implementation ColorView
- (NSArray *)colorArray{
    if (!_colorArray) {
        _colorArray = @[[UIColor cyanColor],[UIColor blackColor],[UIColor blueColor],[UIColor grayColor]];
    }
    return _colorArray;
}
- (instancetype)init{
    if (self = [super init]) {
        [self loadDefaultsetting];
    }
    return  self;
}
- (void)loadDefaultsetting{

    for (NSInteger index = 0; index<4; index ++) {
        UIButton *button = [[UIButton alloc]init];
        [self addSubview:button];
        button.tag = index;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self).multipliedBy(0.5);
            
        }];
        if (index/2 == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
            }];
        }else{
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
            }];
        }
        
        if (index%2 == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self);
            }];
        }else{
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.trailing.equalTo(self);
            }];
        }
        [button addTarget:self action:@selector(changeColer:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = self.colorArray[index];
    }
}
- (void)drawRect:(CGRect)rect{
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor orangeColor].CGColor;
}
- (void)changeColer:(UIButton *)button{
    switch (button.tag) {
        case 0:
           
            [self selected];
            break;
        case 1:
            [self selected];
            break;
        case 2:
                 [self selected];
            break;
        case 3:
            [self selected];
            break;
        default:
            break;
    }
}
- (void)selected{
    if ([self.delegate respondsToSelector:@selector(selectedColor:)]) {
        [self.delegate selectedColor:self];
    }
}
@end
