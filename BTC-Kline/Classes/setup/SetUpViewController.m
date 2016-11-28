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
#import "ChatViewController.h"
@interface SetUpViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *aCount;
//@property (weak, nonatomic) IBOutlet UITableViewCell *OTP;
@property (weak, nonatomic) IBOutlet UITableViewCell *tubiao;
@property (weak, nonatomic) IBOutlet UITableViewCell *mail;
@property (weak, nonatomic) IBOutlet UITableViewCell *news;
@property (weak, nonatomic) IBOutlet UITableViewCell *log;
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
    self.log.textLabel.text = @"日志";
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
            case 4:
                
                break;
            default:
                break;
        }
    }
}

- (void)toChat{
    ChatViewController *chat = [[ChatViewController alloc] init];
    chat.conversationType = ConversationType_CUSTOMERSERVICE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = @"KEFU147970983317739";
    //设置聊天会话界面要显示的标题
    chat.title = @"联系客服";
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
