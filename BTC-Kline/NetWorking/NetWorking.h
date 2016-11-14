//
//  NetWorking.h
//  btc123
//
//  Created by jarze on 16/1/18.
//  Copyright © 2016年 btc123. All rights reserved.
// 网络请求接口

#import <Foundation/Foundation.h>
@class HangQing;
@interface NetWorking : NSObject


+(void)requestWithApi:(NSString *)url param:(NSMutableDictionary *)param thenSuccess:(void (^)(NSDictionary *responseObject))success fail:(void (^)(void))fail;

//*行情接口/
+ (void)requestHQWithApi:(NSString *)url param:(NSDictionary *)param success:(void (^)(HangQing *responseObject))success fail:(void (^)(NSError *error))fail;

//*checkAccout/password/
+ (void)checkAccountWithApi:(NSString *)url account:(NSString *)account password:(NSString *)passWord success:(void (^)(NSDictionary *responseObject))success fail:(void (^)(NSError *error))fail;

//*User query/
+ (void)userQueryWithApi:(NSString *)url account:(NSString *)account password:(NSString *)passWord success:(void (^)(NSDictionary *responseObject))success fail:(void (^)(NSError *error))fail;

//*查持仓/
+ (void)checkThepositionWithApi:(NSString *)url account:(NSString *)account password:(NSString *)passWord success:(void (^)(NSDictionary *responseObject))success fail:(void (^)(NSError *error))fail;

//*历史K线History K line 参数:商品名称，K线周期，时间戳/
+ (void)historyKlineQueryWithApi:(NSString *)url nameOfCommodity:(NSString *)nameOfCommodity KlineCycle:(NSInteger *)timeCycle timestamp:(NSString *)timestamp success:(void (^)(NSDictionary *responseObject))success fail:(void (^)(NSError *error))fail;
//开仓 open Position 参数:帐号login,密码pwd，商品symbol，数量volume，方向cmd /
+ (void) openPositionWithApi:(NSString *)url param:(NSDictionary *)param success:(void (^)(NSDictionary *responseObject))success fail:(void (^)(NSError *error))fail;

//*平仓close position UNWIND 参数:帐号login,密码pwd，单号order,平仓数量volume，品种symbol，价格price/
+ (void) unwindWithApi:(NSString *)url param:(NSDictionary *)param success:(void (^)(NSDictionary *responseObject))success fail:(void (^)(NSError *error))fail;

@end
