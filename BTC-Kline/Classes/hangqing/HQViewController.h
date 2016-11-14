//
//  HQViewController.h
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HQVCDelegate <NSObject>
- (void)openJiaoyiWithVC:(UIViewController *)VC;
- (void)openTubiaoWithVC:(UIViewController *)VC;
@end
@interface HQViewController : UIViewController
@property (nonatomic, weak) id<HQVCDelegate>HQdelegate;
@end
