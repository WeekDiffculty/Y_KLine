//
//  GoodsPath.h
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/16.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <Foundation/Foundation.h>
#define currentGoods @"currentGoods.plist"
#define goods @"goods.plist"
#define etcGoods @"etcGoods.plist"
#define accountPath @"account.archive"
@interface GoodsPath : NSObject
@property (nonatomic, copy) NSString * currentGoodsPath;
@property (nonatomic, copy) NSString *goodsPath;
@property (nonatomic, copy) NSString *etcPath;

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy)NSString *html;
+ (instancetype)sharePath;
@end
