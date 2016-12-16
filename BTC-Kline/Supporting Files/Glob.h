//
//  Glob.h
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
// 8888666   abc123456 测试账号
#ifndef Glob_h
#define Glob_h
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

#define WeakObj(obj) __weak typeof(obj) weak##obj = obj
//#define StrongObj(obj) __strong typeof(obj) strong##obj = obj
#import "Reachability.h"
#import "NetWorking.h"
#import "Masonry.h"
#import "GoodsPath.h"
#import "JSViewController.h"
#import "Account.h"
#import "JsonstrTodic.h"
#import "MJExtension.h"
//*行情*/
#define  HQJK @"http://47.89.53.7:8777/api/?type=singlequote&symbol="
//商品详情
#define GOODSDETAIl @"http://47.89.53.7:8788/api/?type=symbolinfo&symbol="
//账号密码校验3
#define ACCOUNT_PASSWORD @"http://47.89.53.7:8788/api/"
//用户查询
#define USER_SEARCH @"http://47.89.53.7:8788/api/"
//查持仓
#define CHICANG @"http://47.89.53.7:8788/api/"
//历史K线
#define K_LINE @"http://47.89.53.7:8788/api/"
//开仓
#define OPEN_POSITION @"http://47.89.53.7:8788/api/"
//平仓
#define CLOSE_POSITION @"http://47.89.53.7:8788/api/"
#endif /* Glob_h */
//获取token
#define TOKEN @"http://api.cn.ronghub.com/user/getToken.json"
//头像
#define PORTRAITURLI @"http://img5.duitang.com/uploads/item/201601/06/20160106061634_ALNQs.jpeg"

#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((fmt), ##__VA_ARGS__);
#else
#define NSLog(...);
#endif
