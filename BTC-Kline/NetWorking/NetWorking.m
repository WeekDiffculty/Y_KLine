//
//  NetWorking.m
//  btc123
//
//  Created by jarze on 16/1/18.
//  Copyright © 2016年 btc123. All rights reserved.
//

#import "NetWorking.h"
#import "AFNetworking.h"
#import "HangQing.h"
@implementation NetWorking



+(void)requestWithApi:(NSString *)url param:(NSMutableDictionary *)param thenSuccess:(void (^)(NSDictionary *responseObject))success fail:(void (^)(void))fail
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            !success ? : success(responseObject);
        });

    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            !fail ? : fail();
        });
    }];
    
}
//*行情接口/
+ (void)requestHQWithApi:(NSString *)url param:(NSDictionary *)param success:(void (^)(HangQing *responseObject))success fail:(void (^)(NSError *error))fail{
        NSURL *urls = [NSURL URLWithString:url];
        NSURLRequest *request = [NSURLRequest requestWithURL:urls];
        NSURLSession * session=[NSURLSession sharedSession];
        NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
            if(error){
              //  NSLog(@"error %@",error);
            }
            //判断状态响应码
            NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
            if(httpresponse.statusCode==200){
                //请求成功,解析数据
                NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                //NSLog(@"%@",str);
                NSArray *array = [str componentsSeparatedByString:@"|"];
                success([HangQing hangqingModelWith:array]);
                //NSLog(@"%@",array);
                dispatch_async(dispatch_get_main_queue(), ^{
                  [task suspend];
                });
            }
        }];
        //4.启动请求
        [task resume];
    
}

//*checkAccout/password/
+ (void)checkAccountWithApi:(NSString *)url account:(NSString *)account password:(NSString *)passWord success:(void (^)(BOOL responseObject))success fail:(void (^)(NSError *error))fail{
    NSString *str = [NSString stringWithFormat:@"%@?type=check&account=%@&password=%@",url,account,passWord];
    NSURL *urls = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    NSURLSession * session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
        if(error){
            !error?:fail(error);
        }
        //判断状态响应码
        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
        if(httpresponse.statusCode==200){
            //请求成功,解析数据
            NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if ([str isEqualToString:@"0"]) {
                success(YES);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [task suspend];
            });
        }
    }];
    //4.启动请求
    [task resume];
    
}

//*User query/
+ (void)userQueryWithApi:(NSString *)url account:(NSString *)account password:(NSString *)passWord success:(void (^)(NSDictionary *responseObject))success fail:(void (^)(NSError *error))fail{
    NSString *str = [NSString stringWithFormat:@"%@?type=userinfo&account=%@&password=%@",url,account,passWord];
    NSURL *urls = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    NSURLSession * session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
        if(error){
            !error?:fail(error);
        }
        //判断状态响应码
        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
        if(httpresponse.statusCode==200){
            //请求成功,解析数据
            NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if ([str isEqualToString:@"0"]) {
               
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [task suspend];
            });
        }
    }];
    //4.启动请求
    [task resume];


}

//*查持仓/
+ (void)checkThepositionWithApi:(NSString *)url account:(NSString *)account password:(NSString *)passWord success:(void (^)(NSDictionary *responseObject))success fail:(void (^)(NSError *error))fail{
    NSString *str = [NSString stringWithFormat:@"%@?type=orderlist&account=%@&password=%@",url,account,passWord];
    NSURL *urls = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    NSURLSession * session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
        if(error){
            !error?:fail(error);
        }
        //判断状态响应码
        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
        if(httpresponse.statusCode==200){
            //请求成功,解析数据
            NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if ([str isEqualToString:@"0"]) {
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [task suspend];
            });
        }
    }];
    //4.启动请求
    [task resume];
    

}

//*历史K线History K line 参数:商品名称，K线周期，时间戳/
+ (void)historyKlineQueryWithApi:(NSString *)url nameOfCommodity:(NSString *)nameOfCommodity KlineCycle:(NSInteger *)timeCycle timestamp:(NSString *)timestamp success:(void (^)(NSDictionary *responseObject))success fail:(void (^)(NSError *error))fail{
    

}
//开仓 open Position 参数:帐号login,密码pwd，商品symbol，数量volume，方向cmd /
+ (void) openPositionWithApi:(NSString *)url param:(NSDictionary *)param success:(void (^)(NSDictionary *responseObject))success fail:(void (^)(NSError *error))fail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url
       parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
           
       } progress:^(NSProgress * _Nonnull uploadProgress) {
           
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           !success?: success(responseObject);
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           !fail?:fail(error);
       }];

}

//*平仓 UNWIND 参数:帐号login,密码pwd，单号order,平仓数量volume，品种symbol，价格price/
+ (void) unwindWithApi:(NSString *)url param:(NSDictionary *)param success:(void (^)(NSDictionary *responseObject))success fail:(void (^)(NSError *error))fail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url
       parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
           
       } progress:^(NSProgress * _Nonnull uploadProgress) {
           
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           !success?: success(responseObject);
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           !fail?:fail(error);
       }];

}
@end
