//
//  OptionView.h
//  BTC-Kline
//
//  Created by apple on 2016/11/11.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol orderEdtingDelegate <NSObject>
- (void)OpenJiaoyiWithoptionView:(UIView *)optionView withSymbol:(NSString *)symbol;
- (void)OpenTubiaoWithoptionView:(UIView *)optionView withSymbol:(NSString *)symbol;
- (void)OpenPosionWithOptionView:(UIView *)optionView withSymbol:(NSString *)symbol;
@end

@interface orderEdting : UIView
@property (nonatomic, weak) NSString *tittle;
@property (nonatomic, weak) id <orderEdtingDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *symbolName;
+(instancetype)optionView;


@end
