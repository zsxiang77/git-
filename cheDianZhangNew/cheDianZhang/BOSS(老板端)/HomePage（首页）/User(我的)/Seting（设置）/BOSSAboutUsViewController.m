//
//  BOSSAboutUsViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSAboutUsViewController.h"

@interface BOSSAboutUsViewController ()

@property(nonatomic,strong)UIScrollView *mainSrollView;

@property(nonatomic,strong)UILabel *jieShaoLabel;
@property(nonatomic,strong)UILabel *lianXilabel;
@property(nonatomic,strong)UIView  *zhongView;
@property(nonatomic,strong)UIView  *xiaView;

@end

@implementation BOSSAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"关于我们" withBackButton:YES];
    self.mainSrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
    [self.view addSubview:self.mainSrollView];
    
    
    UIView *shangView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 158)];
    [self.mainSrollView addSubview:shangView];
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"boss_logo")];
    [shangView addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(48);
        make.centerX.mas_equalTo(shangView);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(47);
    }];
    
    UILabel *banBenLabel = [[UILabel alloc]init];
    banBenLabel.textColor = kRGBColor(74, 74, 74);
    banBenLabel.font = [UIFont systemFontOfSize:17];
    banBenLabel.text = [NSString stringWithFormat:@"版本号：%@",kCurrentVersion];
    [shangView addSubview:banBenLabel];
    [banBenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoImageView.mas_bottom).mas_equalTo(12);
        make.centerX.mas_equalTo(shangView);
    }];
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = kLineBgColor;
    [shangView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(1);
    }];
    
    self.zhongView = [[UIView alloc]initWithFrame:CGRectMake(0, 158, kWindowW, 158)];
    [self.mainSrollView addSubview:self.zhongView];
    UILabel *line2 = [[UILabel alloc]init];
    line2.backgroundColor = kLineBgColor;
    [self.zhongView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *jieshaoLabel = [[UILabel alloc]init];
    jieshaoLabel.text = @"车店长介绍";
    jieshaoLabel.font = [UIFont boldSystemFontOfSize:17];
    jieshaoLabel.textColor = kRGBColor(74, 74, 74);
    [self.zhongView addSubview:jieshaoLabel];
    [jieshaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.centerX.mas_equalTo(self.zhongView);
    }];
    
    UIImageView *xiaotouBiaoIm = [[UIImageView alloc]initWithImage:DJImageNamed(@"boss_logo")];
    [self.zhongView addSubview:xiaotouBiaoIm];
    [xiaotouBiaoIm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(jieshaoLabel.mas_left).mas_equalTo(-5);
        make.centerY.mas_equalTo(jieshaoLabel);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(14);
    }];
    
    self.jieShaoLabel = [[UILabel alloc]init];
    self.jieShaoLabel.font = [UIFont systemFontOfSize:14];
    self.jieShaoLabel.numberOfLines = 0;
    [self.zhongView addSubview:self.jieShaoLabel];
    [self.jieShaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(jieshaoLabel.mas_bottom).mas_equalTo(10);
    }];
    
    
    self.xiaView = [[UIView alloc]initWithFrame:CGRectMake(0, 158+158, kWindowW, 158)];
    [self.mainSrollView addSubview:self.xiaView];
    
    UILabel *lainXiLabel = [[UILabel alloc]init];
    lainXiLabel.text = @"联系我们";
    lainXiLabel.font = [UIFont boldSystemFontOfSize:17];
    lainXiLabel.textColor = kRGBColor(74, 74, 74);
    [self.xiaView addSubview:lainXiLabel];
    [lainXiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.centerX.mas_equalTo(self.xiaView);
    }];
    
    
    self.lianXilabel = [[UILabel alloc]init];
    self.lianXilabel.font = [UIFont systemFontOfSize:14];
    self.lianXilabel.numberOfLines = 0;
    [self.xiaView addSubview:self.lianXilabel];
    [self.lianXilabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(lainXiLabel.mas_bottom).mas_equalTo(10);
    }];
    
    self.mainSrollView.contentSize = CGSizeMake(kWindowH, 158*3);
    
    [self postabout_us];
}

-(void)postabout_us
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"2" forKey:@"status"];
    
    kWeakSelf(weakSelf)
    [self showOrHideLoadView:YES];
    NSString *path = [NSString stringWithFormat:@"%@user/ucenter/about_us",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf showOrHideLoadView:NO];
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [BOSSNetWorkManager loginAgain:weakSelf];
            return;
        }
        
        if (code == 200) {
            NSDictionary* dataDic = kParseData(responseObject);
            [weakSelf chuLiData:KISDictionaryHaveKey(dataDic, @"info")];
            
        }else{
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(parserDict, @"msg") buttonTitle:@"确定"];
            return;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf showOrHideLoadView:NO];
    }];
}

-(void)chuLiData:(NSDictionary *)dict
{
    self.jieShaoLabel.text = [NSString stringWithFormat:@"        %@",KISDictionaryHaveKey(dict, @"introduce")];
    self.lianXilabel.text = [NSString stringWithFormat:@"        %@",KISDictionaryHaveKey(dict, @"contact")];
    
    self.zhongView.frame = CGRectMake(0, 158, kWindowW, self.jieShaoLabel.frame.size.height+100);
    self.xiaView.frame = CGRectMake(0, 158+self.jieShaoLabel.frame.size.height+100, kWindowW, self.lianXilabel.frame.size.height+100);
    self.mainSrollView.contentSize = CGSizeMake(kWindowW, 158+self.jieShaoLabel.frame.size.height+100+self.lianXilabel.frame.size.height+100);
}

@end
