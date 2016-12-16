//
//  SetUpViewController.m
//  BTC-Kline
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "SetUpViewController.h"
#import "AccountViewController.h"
#import "TubiaoSetUPTableViewController.h"
#import "RCDCustomerServiceViewController.h"
#import "Glob.h"
@interface SetUpViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *aCount;
//@property (weak, nonatomic) IBOutlet UITableViewCell *OTP;
@property (weak, nonatomic) IBOutlet UITableViewCell *tubiao;
@property (weak, nonatomic) IBOutlet UITableViewCell *mail;
@property (weak, nonatomic) IBOutlet UITableViewCell *news;
@property (weak, nonatomic) IBOutlet UITableViewCell *guanyu;

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDefaultSetting];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.tabBarController setHidesBottomBarWhenPushed:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.tabBarController setHidesBottomBarWhenPushed:NO];
}
- (void) loadDefaultSetting{
    self.aCount.textLabel.text=@"交易账户";
//    self.OTP.textLabel.text = @"OTP";
//    self.OTP.detailTextLabel.text = @"一次性密码生成器";
    self.tubiao.textLabel.text=@"图表";
    self.mail.textLabel.text = @"联系客服";
    self.news.textLabel.text = @"新闻";
    self.guanyu.textLabel.text = @"关于";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TubiaoSetUPTableViewController *tbStVC = [storyboard instantiateViewControllerWithIdentifier:@"TubiaoSetUPTableViewController"];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            [self.navigationController pushViewController:[AccountViewController new] animated:YES];
        }else{
            
        }
    }else{
        switch (indexPath.row) {
            case 0:
            [self.navigationController pushViewController:tbStVC animated:YES];
                
                break;
            case 1:
            [self toChat];
                break;
            case 2:
                
                break;
            case 3:
                
                break;
            default:
                break;
        }
    }
}

- (void)toChat{
    RCDCustomerServiceViewController *chatService =
    [[RCDCustomerServiceViewController alloc] init];
#define SERVICE_ID @"KEFU147970983317739"
   // chatService.userName = @"客服";
    chatService.conversationType = ConversationType_CUSTOMERSERVICE;
#if RCDDebugTestFunction
    NSString *kefuId = self.kefuIdField.text;
    [[NSUserDefaults standardUserDefaults] setObject:kefuId forKey:@"KefuId"];
    chatService.targetId = kefuId;
#else
    chatService.targetId = SERVICE_ID;
#endif
    Account *ccount = [NSKeyedUnarchiver unarchiveObjectWithFile:[GoodsPath sharePath].account];

    //上传用户信息，nickname是必须要填写的
    RCCustomerServiceInfo *csInfo = [[RCCustomerServiceInfo alloc] init];
    csInfo.userId = [RCIM sharedRCIM].currentUserInfo.userId;
    
    csInfo.nickName = @"新用户";
    csInfo.loginName = ccount.account;
    csInfo.name = ccount.account;;
    csInfo.grade = @"11级";
    csInfo.gender = @"男";
    csInfo.birthday = @"2016.5.1";
    csInfo.age = @"36";
    csInfo.profession = @"software engineer";
    csInfo.portraitUrl =
    [RCIM sharedRCIM].currentUserInfo.portraitUri;
    csInfo.province = @"beijing";
    csInfo.city = @"beijing";
//    csInfo.memo = @"这是一个好顾客!";
//    
//    csInfo.mobileNo = @"13800000000";
//    csInfo.email = @"test@example.com";
//    csInfo.address = @"北京市北苑路北泰岳大厦";
//    csInfo.QQ = @"88888888";
//    csInfo.weibo = @"my weibo account";
//    csInfo.weixin = @"myweixin";
//    csInfo.page = @"卖化妆品的页面来的";
//    csInfo.referrer = @"客户端";
//    csInfo.enterUrl = @"testurl";
//    csInfo.skillId = @"技能组";
//    csInfo.listUrl = @[ @"用户浏览的第一个商品Url", @"用户浏览的第二个商品Url" ];
//    csInfo.define = @"自定义信息";
    chatService.csInfo = csInfo;
    //chatService.title = chatService.userName;
    self.hidesBottomBarWhenPushed = YES;
    [self addChildViewController:chatService];
    [self.navigationController pushViewController:chatService animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
