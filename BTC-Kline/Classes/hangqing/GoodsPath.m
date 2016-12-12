//
//  GoodsPath.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/16.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "GoodsPath.h"

@implementation GoodsPath

+(instancetype)sharePath{
    static GoodsPath *path;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        path = [[GoodsPath alloc]init];
    });
    return path;
}
- (NSString *)currentGoodsPath{
    if (_currentGoodsPath) {
        return _currentGoodsPath;
    }
    //1.在沙盒中的documents创建一个子目录
    //1.1获取文件管理器的对象
    NSFileManager *manager=[NSFileManager defaultManager];
    //1.2 获取沙盒docments路径
    NSString *docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //1.2.2 合并路径与子目录
    //NSString *strDirPath=[NSString stringWithFormat:@"%@//%@",docPath,KDIR];
    NSString *strDirPath=[docPath stringByAppendingPathComponent:@"LIST"];
    //1.3创建文件夹
    NSError *error;
    if (![manager createDirectoryAtPath:strDirPath withIntermediateDirectories:YES attributes:nil error:&error]) {
        NSLog(@"子目录创建失败%@",error);
    }
    // NSLog(@"创建子目录%@",strDirPath);
    //2.创建文件的路径
    //2.1合并文件路径
    NSString *filePath=[strDirPath stringByAppendingPathComponent:currentGoods];
    //2.2 创建文件
    //2.2.1判断文件是否存在
    if (![manager fileExistsAtPath:filePath]) {
        //2.2.2创建文件
        if(![manager createFileAtPath:filePath contents:nil attributes:nil]){
            return nil;
        }
    }
    NSLog(@"文件所在的目录%@",filePath);
    return filePath;
}

- (NSString *)goodsPath{
    if (_goodsPath) {
        return _goodsPath;
    }
    //1.在沙盒中的documents创建一个子目录
    //1.1获取文件管理器的对象
    NSFileManager *manager=[NSFileManager defaultManager];
    //1.2 获取沙盒docments路径
    NSString *docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //1.2.2 合并路径与子目录
    //NSString *strDirPath=[NSString stringWithFormat:@"%@//%@",docPath,KDIR];
    NSString *strDirPath=[docPath stringByAppendingPathComponent:@"LIST"];
    //1.3创建文件夹
    NSError *error;
    if (![manager createDirectoryAtPath:strDirPath withIntermediateDirectories:YES attributes:nil error:&error]) {
        NSLog(@"子目录创建失败%@",error);
    }
    // NSLog(@"创建子目录%@",strDirPath);
    //2.创建文件的路径
    //2.1合并文件路径
    NSString *filePath=[strDirPath stringByAppendingPathComponent:goods];
    //2.2 创建文件
    //2.2.1判断文件是否存在
    if (![manager fileExistsAtPath:filePath]) {
        //2.2.2创建文件
        if(![manager createFileAtPath:filePath contents:nil attributes:nil]){
            return nil;
        }
    }
    NSLog(@"文件所在的目录%@",filePath);
    return filePath;
}

- (NSString *)etcPath{
    if (_etcPath) {
        return _etcPath;
    }
    //1.在沙盒中的documents创建一个子目录
    //1.1获取文件管理器的对象
    NSFileManager *manager=[NSFileManager defaultManager];
    //1.2 获取沙盒docments路径
    NSString *docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //1.2.2 合并路径与子目录
    //NSString *strDirPath=[NSString stringWithFormat:@"%@//%@",docPath,KDIR];
    NSString *strDirPath=[docPath stringByAppendingPathComponent:@"LIST"];
    //1.3创建文件夹
    NSError *error;
    if (![manager createDirectoryAtPath:strDirPath withIntermediateDirectories:YES attributes:nil error:&error]) {
        NSLog(@"子目录创建失败%@",error);
    }
    // NSLog(@"创建子目录%@",strDirPath);
    //2.创建文件的路径
    //2.1合并文件路径
    NSString *filePath=[strDirPath stringByAppendingPathComponent:etcGoods];
    //2.2 创建文件
    //2.2.1判断文件是否存在
    if (![manager fileExistsAtPath:filePath]) {
        //2.2.2创建文件
        if(![manager createFileAtPath:filePath contents:nil attributes:nil]){
            return nil;
        }
    }
    NSLog(@"文件所在的目录%@",filePath);
    return filePath;
}

- (NSString *)account{
    if (_account) {
        return _account;
    }
    //1.在沙盒中的documents创建一个子目录
    //1.1获取文件管理器的对象
    NSFileManager *manager=[NSFileManager defaultManager];
    //1.2 获取沙盒docments路径
    NSString *docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //1.2.2 合并路径与子目录
    //NSString *strDirPath=[NSString stringWithFormat:@"%@//%@",docPath,KDIR];
    NSString *strDirPath=[docPath stringByAppendingPathComponent:@"ACCOUNT"];
    //1.3创建文件夹
    NSError *error;
    if (![manager createDirectoryAtPath:strDirPath withIntermediateDirectories:YES attributes:nil error:&error]) {
        NSLog(@"子目录创建失败%@",error);
    }
    // NSLog(@"创建子目录%@",strDirPath);
    //2.创建文件的路径
    //2.1合并文件路径
    NSString *filePath=[strDirPath stringByAppendingPathComponent:accountPath];
    //2.2 创建文件
    //2.2.1判断文件是否存在
    if (![manager fileExistsAtPath:filePath]) {
        //2.2.2创建文件
        if(![manager createFileAtPath:filePath contents:nil attributes:nil]){
            return nil;
        }
    }
    NSLog(@"文件所在的目录%@",filePath);
    return filePath;
}

- (NSString *)html{
    if (_account) {
        return _account;
    }
    //1.在沙盒中的documents创建一个子目录
    //1.1获取文件管理器的对象
    NSFileManager *manager=[NSFileManager defaultManager];
    //1.2 获取沙盒docments路径
    NSString *docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //1.2.2 合并路径与子目录
    //NSString *strDirPath=[NSString stringWithFormat:@"%@//%@",docPath,KDIR];
    NSString *strDirPath=[docPath stringByAppendingPathComponent:@"SETUP"];
    //1.3创建文件夹
    NSError *error;
    if (![manager createDirectoryAtPath:strDirPath withIntermediateDirectories:YES attributes:nil error:&error]) {
        NSLog(@"子目录创建失败%@",error);
    }
    // NSLog(@"创建子目录%@",strDirPath);
    //2.创建文件的路径
    //2.1合并文件路径
    NSString *filePath=[strDirPath stringByAppendingPathComponent:@"info.html"];
    //2.2 创建文件
    //2.2.1判断文件是否存在
    if (![manager fileExistsAtPath:filePath]) {
        //2.2.2创建文件
        if(![manager createFileAtPath:filePath contents:nil attributes:nil]){
            return nil;
        }
    }
    NSLog(@"文件所在的目录%@",filePath);
    return filePath;
}
@end
