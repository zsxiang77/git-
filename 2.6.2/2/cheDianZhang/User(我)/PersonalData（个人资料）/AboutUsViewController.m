//
//  AboutUsViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/10/25.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@property(nonatomic,strong)UILabel *shiFouZuiXinLabel;

@property(nonatomic,strong)NSString *down_urlStr;
@property(nonatomic,strong)NSString *versionStr;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"关于车店长" withBackButton:YES];
    self.down_urlStr = @"";
    self.versionStr = @"";
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"page-1")];
    backImageView.frame  = CGRectMake(0, 0, kWindowW, kWindowH);
    backImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:backImageView];
    
    UIView *whiteView = [[UIView alloc]init];
    whiteView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:whiteView];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(80);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = kLineBgColor;
    [whiteView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(40);
    }];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    UILabel *shangZuoLabel = [[UILabel alloc]init];
    shangZuoLabel.font = [UIFont systemFontOfSize:14];
    shangZuoLabel.text = [NSString stringWithFormat:@"版本%@",app_build];
    [whiteView addSubview:shangZuoLabel];
    [shangZuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    self.shiFouZuiXinLabel = [[UILabel alloc]init];
    self.shiFouZuiXinLabel.textColor = [UIColor grayColor];
    self.shiFouZuiXinLabel.font = [UIFont systemFontOfSize:14];
    [whiteView addSubview:self.shiFouZuiXinLabel];
    [self.shiFouZuiXinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *xiaZuoLabel = [[UILabel alloc]init];
    xiaZuoLabel.font = [UIFont systemFontOfSize:14];
    xiaZuoLabel.text = @"给车店长打分";
    [whiteView addSubview:xiaZuoLabel];
    [xiaZuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *tiaoZhuanAppStireBt = [[UIButton alloc]init];
    [tiaoZhuanAppStireBt addTarget:self action:@selector(tiaoZhuanAppStireBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [whiteView addSubview:tiaoZhuanAppStireBt];
    [tiaoZhuanAppStireBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self getHuoQuDangQianVesion];
}
-(void)getHuoQuDangQianVesion
{
    [self showOrHideLoadView:YES];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:@"2" forKey:@"type"];
    
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@store_staff/staff_user/version",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress) {
        
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf showOrHideLoadView:NO];
        
        NSData *filData = responseObject;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"\n返回：%@",parserDict);
        
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [NetWorkManager loginAgain:self];
            return;
        }
        
        NSDictionary *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSDictionary class]]) {
            return ;
            
        }
        
        if (code == 200) {
            weakSelf.down_urlStr = KISDictionaryHaveKey(adData, @"down_url");
            weakSelf.versionStr = KISDictionaryHaveKey(adData, @"version");
            
            if ([weakSelf.versionStr isEqualToString:kCurrentVersion]) {
                weakSelf.shiFouZuiXinLabel.text = @"已是最新版";
            }else
            {
                weakSelf.shiFouZuiXinLabel.text = [NSString stringWithFormat:@"最新版本是%@",weakSelf.versionStr];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf showOrHideLoadView:NO];
        [[UserInfo shareInstance] showNotNetView];
    }];
    
}
-(void)tiaoZhuanAppStireBtChick:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E8%BD%A6%E5%BA%97%E9%95%BF-%E8%AE%A9%E9%97%A8%E5%BA%97%E7%BB%8F%E8%90%A5%E6%9B%B4%E7%AE%80%E5%8D%95/id1298987528?mt=8"]];
}


@end
