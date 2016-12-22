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
        _colorArray = @[[UIColor colorWithRed:24/255.0 green:27/255.0 blue:32/255.0 alpha:1.0],
                        [UIColor colorWithRed:24/255.0 green:27/255.0 blue:98/255.0 alpha:1.0],
                        [UIColor colorWithRed:24/255.0 green:80/255.0 blue:32/255.0 alpha:1.0],
                        [UIColor colorWithRed:82/255.0 green:33/255.0 blue:32/255.0 alpha:1.0]];
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
            
            [self selectedWithtag:0];
            break;
        case 1:
            [self selectedWithtag:1];

            break;
        case 2:
            [self selectedWithtag:2];

            break;
        case 3:
            [self selectedWithtag:3];

            break;
        default:
            break;
    }
}
- (void)selectedWithtag:(NSInteger)tag{
    NSInteger R=0,G=0,B=0,hex=0;
    if (tag == 0) {
        R=24,G=27,B=32,hex=0;
           }else if (tag == 1){
               R=24,G=27,B=98,hex=0;
    }else if (tag == 2){
        R=24,G=80,B=32,hex=0;
    }else if(tag == 3){
        R=82,G=33,B=32,hex=0;
    }
    hex +=R*1000000;
    hex +=G*1000;
    hex +=B;
    [[NSUserDefaults standardUserDefaults]setInteger:hex forKey:@"backColor"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if ([self.delegate respondsToSelector:@selector(selectedColor:)]) {
        [self.delegate selectedColor:self];
    }
}
@end
