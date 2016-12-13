//
//  KViewController.h
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KViewVCDelegate<NSObject>
- (void)KViewVC:(UIViewController *)KViewController withSymbol:(NSString *)symbol;
@end
@interface KViewController : UIViewController
@property (nonatomic, weak) id <KViewVCDelegate>delegate;
- (void)openAndSelectedSymbol:(NSString *)symbol;

@end
