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
    NSDictionary *dict = [[NSDictionary alloc]init];
    kWeakSelf(weakSelf)
    [BOSSNetWorkManager requestWithParametersGET:dict withUrl:@"user/ucenter/agreement" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary *adData = kParseData(responseObject);
        if([adData isKindOfClass:[NSDictionary class]]){
            weakSelf.mainTextView.text = KISDictionaryHaveKey(adData, @"agreement");
        }
    } failure:^(id error) {
        
    }];

}
@end
