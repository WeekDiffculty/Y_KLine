//
//  HQViewController.h
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HQVCDelegate <NSObject>
- (void)openJiaoyiWithVC:(UIViewController *)VC withSymbol:(NSString *)symbol;
- (void)openTubiaoWithVC:(UIViewController *)VC withSymbol:(NSString *)symbol;
@end
@interface HQViewController : UIViewController
@property (nonatomic, weak) id<HQVCDelegate>HQdelegate;
@end
