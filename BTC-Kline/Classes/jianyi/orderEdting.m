//
//  OptionView.m
//  BTC-Kline
//
//  Created by apple on 2016/11/11.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "orderEdting.h"

@implementation orderEdting


+(instancetype)optionView{
    orderEdting *view = [[[NSBundle mainBundle]loadNibNamed:@"orderEdting" owner:nil options:nil]firstObject];
    return view;
}

- (void)setTittle:(NSString *)tittle{
    _tittle = tittle;
    self.symbolName.text = tittle;
}
- (IBAction)ClosePositation:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(OpenPosionWithOptionView:)]) {
        [self.delegate OpenPosionWithOptionView:self];
    }
}
- (IBAction)NewOrder:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(OpenJiaoyiWithoptionView:)]) {
        [self.delegate OpenJiaoyiWithoptionView:self];
    }
}
- (IBAction)OpenChatt:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(OpenTubiaoWithoptionView:)]) {
        [self.delegate OpenTubiaoWithoptionView:self];
    }
}

@end
