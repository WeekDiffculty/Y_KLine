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
@interface AccountViewController ()
@property (nonatomic, strong)UILabel *noLoginView;
@end

@implementation AccountViewController

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
    if ([Account shareAccount].account) {//已登陆
        [self.view addSubview:self.noLoginView];
        self.noLoginView.text = @"当前登录用户：";
        [self.noLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self.view);
            make.height.equalTo(@50);
        }];
        
    }else{//未登陆
         self.navigationItem.rightBarButtonItem = buttonitem;
        [self.view addSubview:self.noLoginView];
        self.noLoginView.text = @"当前没有已登陆用户，请点击右上角加号添加账号";
    }
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
