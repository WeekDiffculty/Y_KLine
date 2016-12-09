//
//  GoodsDetail.h
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 07/12/2016.
//  Copyright © 2016 yate1996. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsDetail : NSObject
@property (nonatomic, copy) NSString *contract_size;
@property (nonatomic, copy) NSString *margin_initial;
@property (nonatomic, copy) NSString *digits;
@property (nonatomic, copy) NSString *margin_mode;
@property (nonatomic, copy) NSString *profit_mode;
@property (nonatomic, copy) NSString *stops_level;
@property (nonatomic, copy) NSString *symbol;
@property (nonatomic, copy) NSString *tick_size;
@property (nonatomic, copy) NSString *tick_value;

@end
