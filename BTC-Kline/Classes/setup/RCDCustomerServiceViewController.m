//
//  RCDCustomerServiceViewController.m
//  RCloudMessage
//
//  Created by litao on 16/2/23.
//  Copyright © 2016年 RongCloud. All rights reserved.
//

#import "RCDCustomerServiceViewController.h"

//#import "RCDSettingBaseViewController.h"
@interface RCDCustomerServiceViewController ()<RCIMClientReceiveMessageDelegate>
//＊＊＊＊＊＊＊＊＊应用自定义评价界面开始1＊＊＊＊＊＊＊＊＊＊＊＊＊
//@property (nonatomic, strong)NSString *commentId;
//@property (nonatomic)RCCustomerServiceStatus serviceStatus;
//@property (nonatomic)BOOL quitAfterComment;
//＊＊＊＊＊＊＊＊＊应用自定义评价界面结束1＊＊＊＊＊＊＊＊＊＊＊＊＊

@end


@implementation RCDCustomerServiceViewController

- (void)onReceived:(RCMessage *)message left:(int)nLeft object:(id)object{
    RCTextMessage *messages = message.content;
    NSString *str = messages.content;
    if (![str isEqualToString:@"您好，很高兴为您服务，请问有什么可以帮您的？"]) {
    
    }
}
//#pragma mark - 导航栏基本设置
//- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
//    [self.conversationMessageCollectionView reloadData];
//}
//- (void)viewWillAppear:(BOOL)animated{
//     self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
//  }
//- (void)onReceived:(RCMessage *)message left:(int)nLeft object:(id)object{
//    if (nLeft) {
//        return;
//    }
//
//}
//- (void)viewWillDisappear:(BOOL)animated{
//     self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//}

- (void)viewDidLoad {
  [super viewDidLoad];
    	self.title = @"客服";
  // Do any additional setup after loading the view.
     
      self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    [self notifyUpdateUnreadMessageCount];
    [[RCIMClient sharedRCIMClient]setReceiveMessageDelegate:self object:nil];
//    UIButton *button =
//    [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
//    UIImageView *imageView =
//    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Private_Setting"]];
//    imageView.frame = CGRectMake(15, 5,16 , 17);
//    [button addSubview:imageView];
//    [button addTarget:self
//               action:@selector(rightBarButtonItemClicked:)
//     forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBarButton =
//    [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.rightBarButtonItem = rightBarButton;
}
//
//- (void)rightBarButtonItemClicked:(id)sender {
////  RCDSettingBaseViewController *settingVC =
////      [[RCDSettingBaseViewController alloc] init];
////  settingVC.conversationType = self.conversationType;
////  settingVC.targetId = self.targetId;
////  //清除聊天记录之后reload data
////  __weak typeof(self) weakSelf = self;
////  settingVC.clearHistoryCompletion = ^(BOOL isSuccess) {
////    if (isSuccess) {
////      [weakSelf.conversationDataRepository removeAllObjects];
////      dispatch_async(dispatch_get_main_queue(), ^{
////        [weakSelf.conversationMessageCollectionView reloadData];
////      });
////    }
////  };
////  [self.navigationController pushViewController:settingVC animated:YES];
//}
//
//
//
////客服VC左按键注册的selector是customerServiceLeftCurrentViewController，
////这个函数是基类的函数，他会根据当前服务时间来决定是否弹出评价，根据服务的类型来决定弹出评价类型。
////弹出评价的函数是commentCustomerServiceAndQuit，应用可以根据这个函数内的注释来自定义评价界面。
////等待用户评价结束后调用如下函数离开当前VC。
//- (void)leftBarButtonItemPressed:(id)sender {
//  //需要调用super的实现
//  [super leftBarButtonItemPressed:sender];
//
//  [self.navigationController popViewControllerAnimated:YES];
//}
//
////评价客服，并离开当前会话
////如果您需要自定义客服评价界面，请把本函数注释掉，并打开“应用自定义评价界面开始1/2”到“应用自定义评价界面结束”部分的代码，然后根据您的需求进行修改。
////如果您需要去掉客服评价界面，请把本函数注释掉，并打开下面“应用去掉评价界面开始”到“应用去掉评价界面结束”部分的代码，然后根据您的需求进行修改。
//- (void)commentCustomerServiceWithStatus:(RCCustomerServiceStatus)serviceStatus
//                               commentId:(NSString *)commentId
//                        quitAfterComment:(BOOL)isQuit {
//  [super commentCustomerServiceWithStatus:serviceStatus
//                                commentId:commentId
//                         quitAfterComment:isQuit];
//}
//
////＊＊＊＊＊＊＊＊＊应用去掉评价界面开始＊＊＊＊＊＊＊＊＊＊＊＊＊
////-
////(void)commentCustomerServiceWithStatus:(RCCustomerServiceStatus)serviceStatus
////commentId:(NSString *)commentId quitAfterComment:(BOOL)isQuit {
////    if (isQuit) {
////        [self leftBarButtonItemPressed:nil];
////    }
////}
////＊＊＊＊＊＊＊＊＊应用去掉评价界面结束＊＊＊＊＊＊＊＊＊＊＊＊＊
//
////＊＊＊＊＊＊＊＊＊应用自定义评价界面开始2＊＊＊＊＊＊＊＊＊＊＊＊＊
////-
////(void)commentCustomerServiceWithStatus:(RCCustomerServiceStatus)serviceStatus
////commentId:(NSString *)commentId quitAfterComment:(BOOL)isQuit {
////    self.serviceStatus = serviceStatus;
////    self.commentId = commentId;
////    self.quitAfterComment = isQuit;
////    if (serviceStatus == 0) {
////        [self leftBarButtonItemPressed:nil];
////    } else if (serviceStatus == 1) {
////        UIAlertView *alert = [[UIAlertView alloc]
////        initWithTitle:@"请评价我们的人工服务"
////        message:@"如果您满意就按5，不满意就按1" delegate:self
////        cancelButtonTitle:@"5" otherButtonTitles:@"1", nil];
////        [alert show];
////    } else if (serviceStatus == 2) {
////        UIAlertView *alert = [[UIAlertView alloc]
////        initWithTitle:@"请评价我们的机器人服务"
////        message:@"如果您满意就按是，不满意就按否" delegate:self
////        cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
////        [alert show];
////    }
////}
////- (void)alertView:(UIAlertView *)alertView
////clickedButtonAtIndex:(NSInteger)buttonIndex {
////    //(1)调用evaluateCustomerService将评价结果传给融云sdk。
////    if (self.serviceStatus == RCCustomerService_HumanService) { //人工评价结果
////        if (buttonIndex == 0) {
////            [[RCIMClient sharedRCIMClient]
////            evaluateCustomerService:self.targetId dialogId:self.commentId
////            humanValue:5 suggest:nil];
////        } else if (buttonIndex == 1) {
////            [[RCIMClient sharedRCIMClient]
////            evaluateCustomerService:self.targetId dialogId:self.commentId
////            humanValue:0 suggest:nil];
////        }
////    } else if (self.serviceStatus == RCCustomerService_RobotService)
////    {//机器人评价结果
////        if (buttonIndex == 0) {
////            [[RCIMClient sharedRCIMClient]
////            evaluateCustomerService:self.targetId knownledgeId:self.commentId
////            robotValue:YES suggest:nil];
////        } else if (buttonIndex == 1) {
////            [[RCIMClient sharedRCIMClient]
////            evaluateCustomerService:self.targetId knownledgeId:self.commentId
////            robotValue:NO suggest:nil];
////        }
////    }
////    //(2)离开当前客服VC
////    if (self.quitAfterComment) {
////        [self leftBarButtonItemPressed:nil];
////    }
////}
////＊＊＊＊＊＊＊＊＊应用自定义评价界面结束2＊＊＊＊＊＊＊＊＊＊＊＊＊
//

//即将更新未读消息的回调
//- (void)notifyUpdateUnreadMessageCount {
//    [super notifyUpdateUnreadMessageCount];
//  int count = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
//    @(ConversationType_PRIVATE),
//    @(ConversationType_DISCUSSION),
//    @(ConversationType_APPSERVICE),
//    @(ConversationType_PUBLICSERVICE),
//    @(ConversationType_GROUP)
//  ]];
//  dispatch_async(dispatch_get_main_queue(), ^{
//    NSString *backString = nil;
//    if (count > 0 && count < 1000) {
//      backString = [NSString stringWithFormat:@"返回(%d)", count];
//    } else if (count >= 1000) {
//      backString = @"返回(...)";
//    } else {
//      backString = @"返回";
//    }
//      });
//}

@end
