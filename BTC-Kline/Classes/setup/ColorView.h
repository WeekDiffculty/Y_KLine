//
//  ColorView.h
//  BTC-Kline
//
//  Created by BF on 2016/12/19.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ColorViewDelegate<NSObject>
- (void)selectedColor:(UIView *)view ;
@end
@interface ColorView : UIView
@property (nonatomic, weak)id<ColorViewDelegate>delegate;
@end
