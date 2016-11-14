//
//  OptionView.h
//  BTC-Kline
//
//  Created by apple on 2016/11/11.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OptionViewDelegate <NSObject>
- (void)OpenJiaoyiWithoptionView:(UIView *)optionView;
- (void)OpenTubiaoWithoptionView:(UIView *)optionView;
- (void)JiaoyishuxingWithOptionView:(UIView *)optionView;
@end

@interface OptionView : UIView
@property (nonatomic, weak) id <OptionViewDelegate> OptinViewDelegate;
@property (weak, nonatomic) IBOutlet UILabel *symbolName;
+(instancetype)optionView;
- (IBAction)newJiaoyi:(UIButton *)sender;
- (IBAction)OpenTubaio:(UIButton *)sender;
- (IBAction)jiaoyiSHuxing:(UIButton *)sender;

@end
