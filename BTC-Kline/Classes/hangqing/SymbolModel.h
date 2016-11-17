//
//  SymbolModel.h
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/15.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SymbolModel : NSObject
@property (nonatomic, copy)NSString * symbolName;
@property (nonatomic, copy)NSString * descriptions;
+ (instancetype)returnModelWithDictionry:(NSDictionary *)dict;
@end
