//
//  JsonstrTodic.h
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/22.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonstrTodic : NSObject
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
@end
