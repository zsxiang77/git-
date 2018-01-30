//
//  VINNewAlertView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "VINNewAlertView.h"
#import "CheDianZhangCommon.h"

@implementation VINNewAlertView


-(instancetype)initWithTitleWithmessage:(NSString *)manage cancelButtonTitle:(NSString *)title otherButtonTitle:(NSString *)titleEr
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kWindowW, kWindowH);
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        self.hidden = YES;
        
        UIView *mainView = [[UIView alloc]init];
        mainView.backgroundColor = [UIColor whiteColor];
        [mainView.layer setMasksToBounds:YES];
        [mainView.layer setCornerRadius:16];
        
        [self addSubview:mainView];
        [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kWindowW-40);
            make.height.mas_equalTo(300/2);
            make.center.mas_equalTo(self);
        }];
        
        
        
        self.maLabel = [[UILabel alloc]init];
        self.maLabel.numberOfLines = 0;
        self.maLabel.textAlignment = NSTextAlignmentCenter;
        self.maLabel.text = manage;
        self.maLabel.textColor = kRGBColor(74, 74, 74);
        [mainView addSubview:self.maLabel];
        [self.maLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(150-45);
        }];
        
        
        self.maLabel2 = [[UILabel alloc]init];
        self.maLabel2.numberOfLines = 0;
        self.maLabel2.textAlignment = NSTextAlignmentCenter;
        self.maLabel2.text = manage;
        self.maLabel2.textColor = kRGBColor(74, 74, 74);
        self.maLabel2.hidden = YES;
        [mainView addSubview:self.maLabel2];
        [self.maLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(40);
            make.centerX.mas_equalTo(mainView);
        }];
        
        self.maLabel3 = [[UILabel alloc]init];
        self.maLabel3.numberOfLines = 0;
        self.maLabel3.textAlignment = NSTextAlignmentCenter;
        self.maLabel3.text = manage;
        self.maLabel3.textColor = [UIColor redColor];
        self.maLabel3.hidden = YES;
        [mainView addSubview:self.maLabel3];
        [self.maLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.maLabel2.mas_bottom).mas_equalTo(8);
            make.centerX.mas_equalTo(mainView);
        }];
        
        self.quXiaoLabel = [[UILabel alloc]init];
        self.quXiaoLabel.textColor = kRGBColor(155, 155, 155);
        self.quXiaoLabel.textAlignment = NSTextAlignmentCenter;
        [mainView addSubview:self.quXiaoLabel];
        [self.quXiaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(45);
            make.left.bottom.mas_equalTo(0);
            make.width.mas_equalTo((kWindowW-40)/2);
        }];
        
        self.quXiaobt = [[UIButton alloc]init];
        [self.quXiaobt addTarget:self action:@selector(quXiaobtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.queRenBt setTitleColor:kRGBColor(155, 155, 155) forState:(UIControlStateNormal)];
        [self.quXiaobt.layer setMasksToBounds:YES];
        [self.quXiaobt.layer setBorderWidth:0.5];
        [self.quXiaobt.layer setBorderColor:kLineBgColor.CGColor];
        [mainView addSubview:self.quXiaobt];
        [self.quXiaobt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(45);
            make.left.bottom.mas_equalTo(0);
            make.width.mas_equalTo((kWindowW-40)/2);
        }];
        
        self.queRenBt = [[UIButton alloc]init];
        [self.queRenBt addTarget:self action:@selector(queRenBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.queRenBt setTitleColor:kRGBColor(74, 144, 226) forState:(UIControlStateNormal)];
        [self.queRenBt setTitle:titleEr forState:(UIControlStateNormal)];
        [self.queRenBt.layer setMasksToBounds:YES];
        [self.queRenBt.layer setBorderWidth:0.5];
        [self.queRenBt.layer setBorderColor:kLineBgColor.CGColor];
        [mainView addSubview:self.queRenBt];
        [self.queRenBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(45);
            make.right.bottom.mas_equalTo(0);
            make.width.mas_equalTo((kWindowW-40)/2);
        }];
        
    }
    return self;
}

-(void)daoJiShi
{
    //    倒计时时间
    __block NSInteger timeOut = 8;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //    每秒执行一次
    dispatch_source_set_timer(source,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(source, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(source);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dissMIssView];
            });
        }else
        {
            //            int seconds = timeOut % 60;
            NSInteger seconds = timeOut;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2ld", (long)seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.quXiaoLabel.text = [NSString stringWithFormat:@"(%@s)取消",timeStr];
            });
            timeOut--;
        }
    });
    dispatch_resume(source);
}

-(void)queRenBtChick:(UIButton *)sender
{
    [self dissMIssView];
    self.queRenBtBlock();
}
-(void)quXiaobtChick:(UIButton *)sender
{
    [self dissMIssView];
    
}

-(void)dissMIssView
{
    self.hidden = YES;
    [self removeFromSuperview];
}

-(void)show{
    self.hidden = NO;
}
@end
