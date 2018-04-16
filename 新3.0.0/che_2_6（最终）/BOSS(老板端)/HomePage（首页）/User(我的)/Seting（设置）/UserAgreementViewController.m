//
//  UserAgreementViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "UserAgreementViewController.h"

@interface UserAgreementViewController ()
@property(nonatomic,strong)UITextView *mainTextView;

@end

@implementation UserAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"用户协议" withBackButton:YES];
    
    self.mainTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, kBOSSNavBarHeight+10, kWindowW-20, kWindowH-kBOSSNavBarHeight-10)];
    self.mainTextView.backgroundColor = [UIColor clearColor];
    self.mainTextView.font = [UIFont systemFontOfSize:14];
    self.mainTextView.editable=NO;
//    self.mainTextView.userInteractionEnabled = NO;
    [self.view addSubview:self.mainTextView];
    [self huoquMenDianData];
}

-(void)huoquMenDianData
{
    
    [self showOrHideLoadView:YES];
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@user/ucenter/agreement",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf showOrHideLoadView:NO];
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"n返回：%@",parserDict);
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [BOSSNetWorkManager loginAgain:weakSelf];
            return;
        }
        
        if ([KISDictionaryHaveKey(parserDict, @"code") integerValue] == 404) {
            NPrintLog(@"msg:%@",KISDictionaryHaveKey(parserDict, @"msg"));
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(parserDict, @"msg") buttonTitle:@"确定"];
            return;
        }
        
        
        NSDictionary *adData = kParseData(responseObject);
        if([adData isKindOfClass:[NSDictionary class]]){
            weakSelf.mainTextView.text = KISDictionaryHaveKey(adData, @"agreement");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NPrintLog(@"task是%@",task);
        [weakSelf showOrHideLoadView:NO];
    }];
    
}
@end
