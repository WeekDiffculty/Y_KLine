//
//  UIColor+Y_StockChart.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "UIColor+Y_StockChart.h"
@implementation UIColor (Y_StockChart)
+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
#pragma mark 所有图表的背景颜色
+(UIColor *)backgroundColor
{
    //backColor 自定义的背景颜色
//  NSInteger color =  [[NSUserDefaults standardUserDefaults]integerForKey:@"backColor"];
//    if (color) {
//        NSInteger R=0,G=0,B=0;
//        R  = color/1000000;
//        G = (color-(R*1000000))/1000;
//        B = (color -R *1000000 - G*1000);
//        return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
//    }else{
//        return [UIColor colorWithRGBHex:0x181c20];
//    }
    return [UIColor colorWithRGBHex:0x181c20];
}

#pragma mark 辅助背景色
+(UIColor *)assistBackgroundColor
{
    //return [UIColor grayColor];
    return [UIColor colorWithRGBHex:0x1d2227];
}

#pragma mark 涨的颜色
+(UIColor *)increaseColor
{
    return [UIColor colorWithRGBHex:0xff5353];
}

#pragma mark 跌的颜色
+(UIColor *)decreaseColor
{
    return [UIColor colorWithRGBHex:0x00b07c];
}

#pragma mark 主文字颜色
+(UIColor *)mainTextColor
{
    return [UIColor colorWithRGBHex:0xe1e2e6];
}

#pragma mark 辅助文字颜色
+(UIColor *)assistTextColor
{
    return [UIColor colorWithRGBHex:0x565a64];
}

#pragma mark 分时线下面的成交量线的颜色
+(UIColor *)timeLineVolumeLineColor
{
    return [UIColor colorWithRGBHex:0x2d333a];
}

#pragma mark 分时线界面线的颜色
+(UIColor *)timeLineLineColor
{
    return [UIColor colorWithRGBHex:0x49a5ff];
}

#pragma mark 长按时线的颜色
+(UIColor *)longPressLineColor
{
//    return [UIColor colorWithRGBHex:0xff5353];
    return [UIColor colorWithRGBHex:0xe1e2e6];
}

#pragma mark ma5的颜色
+(UIColor *)ma7Color
{
    return [UIColor colorWithRGBHex:0xff783c];
}

#pragma mark ma30颜色
+(UIColor *)ma30Color
{
    return [UIColor colorWithRGBHex:0x49a5ff];
}
@end
