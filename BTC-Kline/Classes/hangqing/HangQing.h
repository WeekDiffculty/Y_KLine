//
//  HangQing.h
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/14.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HangQing : NSObject
@property (nonatomic, copy) NSString *symble;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, weak) NSString *time;
+(instancetype)hangqingModelWith:(NSArray *)array;
@end
