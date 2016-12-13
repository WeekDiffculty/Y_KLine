//
//  NSString+md5.h
//  BTC-Kline
//
//  Created by BF on 2016/12/12.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (md5)
+ (NSString *)md5HexDigest:(NSString*)password;
@end
