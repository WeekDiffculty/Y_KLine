//
//  AccountViewController.m
//  BTC-Kline
//
//  Created by zbf920563837@icloud.com on 2016/11/14.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "AccountViewController.h"
#import "Glob.h"
#import "Account.h"
#import "AddAccountViewController.h"
#import "Logined.h"
#import "userInfo.h"
@interface AccountViewController ()
@property (nonatomic, strong)UILabel *noLoginView;
@property (nonatomic, strong)Logined *logined;
@property (nonatomic, strong)UIButton *logOutBtn;
@end

@implementation AccountViewController

- (UIButton *)logOutBtn{
    if (!_logOutBtn) {
        _logOutBtn = [[UIButton alloc]init];
        [_logOutBtn setTitle: @"退出登录" forState:UIControlStateNormal];
        _logOutBtn.backgroundColor = [UIColor redColor];
        _logOutBtn.frame = CGRectMake((Width - 100)*0.5, Height - 100, 100, 40);
        [_logOutBtn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _logOutBtn;
}
- (Logined *)logined{
    if (!_logined) {
        _logined = [Logined logined];
        _logined.frame = CGRectMake(0, 114, Width, 150);
    }
    return _logined;
}
- (UILabel *)noLoginView{
    if (!_noLoginView) {
        _noLoginView = [[UILabel alloc]init];
        _noLoginView.backgroundColor = [UIColor lightGrayColor];
        _noLoginView.frame = CGRectMake(0, 0, Width, Height);
    }
    return  _noLoginView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDefaultSetting];
}


- (void)loadDefaultSetting{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"账户";
    UIBarButtonItem *buttonitem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add_22x22_"] style:0 target:self action:@selector(addAcount)];
    Account *ccount = [NSKeyedUnarchiver unarchiveObjectWithFile:[GoodsPath sharePath].account];
    if (![ccount.account isEqualToString:@""]&&ccount) {//已登陆
        [self loginedWithconfig:ccount];
    }else{//未登陆
         self.navigationItem.rightBarButtonItem = buttonitem;
        [self.view addSubview:self.noLoginView];
        self.noLoginView.text = @"当前没有已登陆用户，请点击右上角加号添加账号";
        self.noLoginView.textAlignment = NSTextAlignmentCenter;
        self.noLoginView.font = [UIFont systemFontOfSize:13];
    }
    
}

- (void)loginedWithconfig:(Account *)ccount{
    [self.view addSubview:self.noLoginView];
    self.noLoginView.text = @"当前登录用户：";
    self.noLoginView.frame = CGRectMake(0, 64, Width, 50);
    [self.view addSubview:self.logOutBtn];
     [self.view addSubview:self.logined];
    WeakObj(self);
    [NetWorking userQueryWithApi:USER_SEARCH account:ccount.account password:ccount.password success:^(userInfo *responseObject) {//
            weakself.logined.model = responseObject;
             } fail:^(NSError *error) {
    }];
}
- (void)logout:(UIButton *)btn{
    Account *count =  [Account shareAccount];
    count.account = @"";
    count.password = @"";
    BOOL ret = [NSKeyedArchiver archiveRootObject:count toFile:[GoodsPath sharePath].account];
    NSLog(@"%@",ret?@2:@0);
    WeakObj(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself.navigationController popToRootViewControllerAnimated:YES];
    });
}
- (void)addAcount{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    [self.navigationController pushViewController:[storyBoard instantiateViewControllerWithIdentifier:@"AddAccountViewController" ] animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
     self.navigationController.toolbarHidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    self.noLoginView = nil;
    self.logined = nil;
    self.logOutBtn = nil;
}

@end
