//
//  XieyiViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/18.
//  Copyright © 2016年 yate1996. All rights reserved.
//
#define URL @"http://www.metaquotes.net/licenses/mobile/mt4"
#import "XieyiViewController.h"
#import "GoodsPath.h"
@interface XieyiViewController ()<UIWebViewDelegate>
@end

@implementation XieyiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:webView];
    webView.delegate = self;
    if ( [NSURL URLWithString: [[GoodsPath sharePath]html]]) {
        NSURL *url =[NSURL URLWithString: [[GoodsPath sharePath]html]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];

    }else{
    
    NSURL *urls = [NSURL URLWithString:URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:urls];
    NSURLSession * session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
        if(error){
           
        }
        //判断状态响应码
        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *)response;
        if(httpresponse.statusCode==200){
            //请求成功,解析数据
            NSMutableString *str=[[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
       NSString *str1 = [[str stringByReplacingOccurrencesOfString:@"© 2015, MetaQuotes Software Corp." withString:@"© 2016, MetaQuotes Software Corp."] copy];
            [str1 writeToFile:[[GoodsPath sharePath]html] atomically:YES encoding:NSUTF8StringEncoding error:nil];
                NSURL *url =[NSURL URLWithString: [[GoodsPath sharePath]html]];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                [webView loadRequest:request];
            dispatch_async(dispatch_get_main_queue(), ^{
                [task suspend];
            });
        }
    }];
    //4.启动请求
    [task resume];
}
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%@",request);
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
