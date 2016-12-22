//
//  more.m
//  BTC-Kline
//
//  Created by BF on 2016/12/22.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "more.h"

@implementation more

- (void)drawRect:(CGRect)rect{
     CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 5, 8);
    CGContextAddLineToPoint(ctx, 15, 8);
    CGContextAddLineToPoint(ctx, 10, 15);
    CGContextClosePath(ctx);
    [[UIColor whiteColor]setFill];
    CGContextFillPath(ctx);

}

- (id)copyWithZone:(NSZone *)zone{
    more *vie = [[more allocWithZone:zone]init];

    return vie;
}
@end
