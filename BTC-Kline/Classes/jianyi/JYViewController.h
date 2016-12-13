//
//  JYViewController.h
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JYDElegate <NSObject>
- (void) opennewJiaoyi:(UIViewController *)VC withSymbol:(NSString *)symbol;
- (void) openTubiao:(UIViewController *)VC withSymbol:(NSString *)symbol;
@end
@interface JYViewController : UIViewController
- (IBAction)newJiaoyi:(UIBarButtonItem *)sender;
@property (nonatomic, weak) id<JYDElegate>delegate;
@end
