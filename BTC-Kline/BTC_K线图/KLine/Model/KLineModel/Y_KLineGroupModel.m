//
//  Y-KLineGroupModel.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/28.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineGroupModel.h"
#import "Y_KLineModel.h"
@implementation Y_KLineGroupModel
+ (instancetype) objectWithArray:(NSArray *)arr withcurrentPrice:(NSString *)currentPrice {
    
    NSAssert([arr isKindOfClass:[NSArray class]], @"arr不是一个数组");
    
    Y_KLineGroupModel *groupModel = [Y_KLineGroupModel new];
    NSMutableArray *mutableArr = @[].mutableCopy;
    __block Y_KLineModel *preModel = [[Y_KLineModel alloc]init];
   
    //设置数据
    for (NSArray *valueArr in arr)
    {
        Y_KLineModel *model = [Y_KLineModel new];
        model.PreviousKlineModel = preModel;
        
        
        //将数据排序
        NSMutableArray *arrayM = [valueArr mutableCopy];
//        [arrayM exchangeObjectAtIndex:1 withObjectAtIndex:2];
//        [arrayM exchangeObjectAtIndex:2 withObjectAtIndex:5];
        NSInteger digits = [[NSUserDefaults standardUserDefaults]integerForKey:@"digits"];
        NSInteger beishu = 1;
        for (NSInteger index =0 ; index< digits; index++ ) {
            beishu *= 10;
        }
        NSString *str = [NSString stringWithFormat:@"%@",arrayM[1]];
        [arrayM removeObjectAtIndex:1];
        [arrayM insertObject:[NSString stringWithFormat:@"%.3f",(CGFloat)str.floatValue/beishu] atIndex:1];
        
        NSArray *array = [arrayM copy];
        
        [model initWithArray:array];
        model.ParentGroupModel = groupModel;
        
        [mutableArr addObject:model];
        
        preModel = model;
    }
    
    groupModel.models = mutableArr;
    
    //初始化第一个Model的数据
    Y_KLineModel *firstModel = mutableArr[0];
    [firstModel initFirstModel];
    
    //初始化其他Model的数据
    [mutableArr enumerateObjectsUsingBlock:^(Y_KLineModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [model initData];
    }];

    return groupModel;
}
@end
