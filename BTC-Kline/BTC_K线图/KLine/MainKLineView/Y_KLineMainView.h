//
//  Y_KLineMainView.h
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//  长按👍

#import <UIKit/UIKit.h>
#import "Y_KLinePositionModel.h"
#import "Y_KLineModel.h"
#import "Y_StockChartConstant.h"
@protocol Y_KLineMainViewDelegate <NSObject>

@optional

/**
 *  长按显示手指按着的Y_KLinePosition和KLineModel
 */
- (void)kLineMainViewLongPressKLinePositionModel:(Y_KLinePositionModel*)kLinePositionModel kLineModel:(Y_KLineModel *)kLineModel;

/**
 *  当前MainView的最大值和最小值
 */
- (void)kLineMainViewCurrentMaxPrice:(CGFloat)maxPrice minPrice:(CGFloat)minPrice;

/**
 *  当前需要绘制的K线模型数组
 */
- (void)kLineMainViewCurrentNeedDrawKLineModels:(NSArray *)needDrawKLineModels;

/**
 *  当前需要绘制的K线位置模型数组
 */
- (void)kLineMainViewCurrentNeedDrawKLinePositionModels:(NSArray *)needDrawKLinePositionModels;

/**
 *  当前需要绘制的K线颜色数组
 */
- (void)kLineMainViewCurrentNeedDrawKLineColors:(NSArray *)kLineColors;

@end


@interface Y_KLineMainView : UIView


/**
 *  模型数组
 */
@property (nonatomic, strong) NSArray *kLineModels;


/**
 *  父ScrollView
 */
@property (nonatomic, weak, readonly) UIScrollView *parentScrollView;

/**
 *  代理
 */
@property (nonatomic, weak) id<Y_KLineMainViewDelegate> delegate;

/**
 *  是否为图表类型
 */
@property (nonatomic, assign) Y_StockChartCenterViewType MainViewType;

/**
 *  Accessory指标种类
 */
@property (nonatomic, assign) Y_StockChartTargetLineStatus targetLineStatus;

/**
 *  需要绘制Index开始值
 */
@property (nonatomic, assign) NSInteger needDrawStartIndex;

/**
 *  捏合点
 */
@property (nonatomic, assign) NSInteger pinchStartIndex;
#pragma event

/**
 *  画MainView的所有线
 */
- (void)drawMainView;

/**
 *  更新MainView的宽度
 */
- (void)updateMainViewWidth;

/**
 *  长按的时候根据原始的x位置获得精确的x的位置
 */
- (CGFloat)getExactXPositionWithOriginXPosition:(CGFloat)originXPosition;

/**
 *  移除所有的监听事件
 */
- (void)removeAllObserver;
@end
