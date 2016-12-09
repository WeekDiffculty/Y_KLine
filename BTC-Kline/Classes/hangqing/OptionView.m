//
//  OptionView.m
//  BTC-Kline
//
//  Created by apple on 2016/11/11.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "OptionView.h"

@implementation OptionView


+(instancetype)optionView{
    OptionView *view = [[[NSBundle mainBundle]loadNibNamed:@"OptionView" owner:nil options:nil]firstObject];
    return view;
}

- (void)setTittle:(NSString *)tittle{
    _tittle = tittle;
    self.symbolName.text = tittle;
}
- (IBAction)newJiaoyi:(UIButton *)sender {
    if (self.OptinViewDelegate) {
        [self.OptinViewDelegate OpenJiaoyiWithoptionView:self withSymbol:self.tittle];
    }
}

- (IBAction)OpenTubaio:(UIButton *)sender {
    if (self.OptinViewDelegate) {
        [self.OptinViewDelegate OpenTubiaoWithoptionView:self withSymbol:self.tittle];
    }

}

- (IBAction)jiaoyiSHuxing:(UIButton *)sender {
    if (self.OptinViewDelegate) {
        [self.OptinViewDelegate JiaoyishuxingWithOptionView:self withSymbol:self.tittle];
    }

}
@end
