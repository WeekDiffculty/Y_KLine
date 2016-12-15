//
//  NextJiaoyiViewController.h
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/18.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SymbolModel.h"
@interface NextJiaoyiViewController : UIViewController
@property (nonatomic, copy) NSString *cmd;
@property (nonatomic, strong) SymbolModel *model;
@property (nonatomic) CGFloat volums;
@property (nonatomic, copy) NSString *symbol;
@end
