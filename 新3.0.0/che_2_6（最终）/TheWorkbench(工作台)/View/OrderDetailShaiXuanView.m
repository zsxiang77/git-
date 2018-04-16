//
//  OrderDetailShaiXuanView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/30.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailShaiXuanView.h"
#import "CheDianZhangCommon.h"
#import "BaseViewController.h"

@implementation OrderDetailShaiXuanView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.indexPage = 0;
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.4);
        UIView *baiView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+(63/2+10)*2, kWindowW, 49)];
        baiView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baiView];
        
        CGFloat anWight = 159/2;
        CGFloat anHeight = 27;
        daiShiGongBt = [[UIButton alloc]init];
        [daiShiGongBt addTarget:self action:@selector(dianJiAnNiuBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        daiShiGongBt.titleLabel.font = [UIFont systemFontOfSize:11];
        daiShiGongBt.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
        UIImageView *im1 = [[UIImageView alloc]initWithImage:DJImageNamed(@"waiting_repair")];
        [daiShiGongBt addSubview:im1];
        [im1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(15);
            make.centerY.mas_equalTo(daiShiGongBt);
            make.right.mas_equalTo(daiShiGongBt.titleLabel.mas_left).mas_equalTo(-3);
        }];
        [daiShiGongBt.layer setCornerRadius:4];
        daiShiGongBt.backgroundColor = kRGBColor(242, 242, 242);
        [daiShiGongBt setTitle:@"待施工" forState:(UIControlStateNormal)];
        [daiShiGongBt setTitleColor:kRGBColor(245, 166, 35) forState:(UIControlStateNormal)];
        [baiView addSubview:daiShiGongBt];
        [daiShiGongBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(anWight);
            make.height.mas_equalTo(anHeight);
            make.centerY.mas_equalTo(baiView);
            make.left.mas_equalTo((kWindowW-anWight*4)/5);
        }];
        
        yiWanChengBt = [[UIButton alloc]init];
        [yiWanChengBt addTarget:self action:@selector(dianJiAnNiuBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        yiWanChengBt.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
        UIImageView *im2 = [[UIImageView alloc]initWithImage:DJImageNamed(@"waiting_WanCheng")];
        [yiWanChengBt addSubview:im2];
        [im2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(15);
            make.centerY.mas_equalTo(yiWanChengBt);
            make.right.mas_equalTo(yiWanChengBt.titleLabel.mas_left).mas_equalTo(-3);
        }];
        yiWanChengBt.titleLabel.font = [UIFont systemFontOfSize:11];
        [yiWanChengBt.layer setMasksToBounds:YES];
        [yiWanChengBt.layer setCornerRadius:4];
        yiWanChengBt.backgroundColor = kRGBColor(242, 242, 242);
        [yiWanChengBt setTitle:@"已完成" forState:(UIControlStateNormal)];
        [yiWanChengBt setTitleColor:kRGBColor(98, 172, 13) forState:(UIControlStateNormal)];
        [baiView addSubview:yiWanChengBt];
        [yiWanChengBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(anWight);
            make.height.mas_equalTo(anHeight);
            make.centerY.mas_equalTo(baiView);
            make.left.mas_equalTo((kWindowW-anWight*4)/5*2+anWight);
        }];
        
        daiChuChangBt = [[UIButton alloc]init];
        [daiChuChangBt addTarget:self action:@selector(dianJiAnNiuBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        daiChuChangBt.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
        UIImageView *im3 = [[UIImageView alloc]initWithImage:DJImageNamed(@"waiting_chuChang")];
        [daiChuChangBt addSubview:im3];
        [im3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(15);
            make.centerY.mas_equalTo(daiChuChangBt);
            make.right.mas_equalTo(daiChuChangBt.titleLabel.mas_left).mas_equalTo(-3);
        }];
        daiChuChangBt.titleLabel.font = [UIFont systemFontOfSize:11];
        [daiChuChangBt.layer setMasksToBounds:YES];
        [daiChuChangBt.layer setCornerRadius:4];
        daiChuChangBt.backgroundColor = kRGBColor(242, 242, 242);
        [daiChuChangBt setTitle:@"待出厂" forState:(UIControlStateNormal)];
        [daiChuChangBt setTitleColor:kRGBColor(74, 144, 226) forState:(UIControlStateNormal)];
        [baiView addSubview:daiChuChangBt];
        [daiChuChangBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(anWight);
            make.height.mas_equalTo(anHeight);
            make.centerY.mas_equalTo(baiView);
            make.left.mas_equalTo((kWindowW-anWight*4)/5*3+anWight*2);
        }];
        
        daiDaiJieSuanBt = [[UIButton alloc]init];
        [daiDaiJieSuanBt addTarget:self action:@selector(dianJiAnNiuBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        daiDaiJieSuanBt.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
        UIImageView *im4 = [[UIImageView alloc]initWithImage:DJImageNamed(@"waiting_statement")];
        [daiDaiJieSuanBt addSubview:im4];
        [im4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(15);
            make.centerY.mas_equalTo(daiDaiJieSuanBt);
            make.right.mas_equalTo(daiDaiJieSuanBt.titleLabel.mas_left).mas_equalTo(-3);
        }];
        daiDaiJieSuanBt.titleLabel.font = [UIFont systemFontOfSize:11];
        [daiDaiJieSuanBt.layer setMasksToBounds:YES];
        [daiDaiJieSuanBt.layer setCornerRadius:4];
        daiDaiJieSuanBt.backgroundColor = kRGBColor(242, 242, 242);
        [daiDaiJieSuanBt setTitle:@"待结算" forState:(UIControlStateNormal)];
        [daiDaiJieSuanBt setTitleColor:kRGBColor(139, 87, 42) forState:(UIControlStateNormal)];
        [baiView addSubview:daiDaiJieSuanBt];
        [daiDaiJieSuanBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(anWight);
            make.height.mas_equalTo(anHeight);
            make.centerY.mas_equalTo(baiView);
            make.left.mas_equalTo((kWindowW-anWight*4)/5*4+anWight*3);
        }];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(selfViewTouch:)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

-(void)dianJiAnNiuBtChick:(UIButton *)sender
{
    
    [self yingCangViwe];
    if (self.indexPage == 0 && sender == daiShiGongBt) {
        return;
    }
    if (self.indexPage == 1 && sender == yiWanChengBt) {
        return;
    }
    if (self.indexPage == 2 && sender == daiChuChangBt) {
        return;
    }
    if (self.indexPage == 3 && sender == daiDaiJieSuanBt) {
        return;
    }
    
    if (sender == daiShiGongBt) {
        self.indexPage = 0;
    }
    if (sender == yiWanChengBt) {
        self.indexPage = 1;
    }
    if (sender == daiChuChangBt) {
        self.indexPage = 2;
    }
    if (sender == daiDaiJieSuanBt) {
        self.indexPage = 3;
    }
    
    self.dianJiAnNiuBtChickBlock(self.indexPage);
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

- (void)selfViewTouch:(id)sender
{
    [self yingCangViwe];
}

-(void)yingCangViwe
{
    self.yingCangViweBlock();
    [UIView animateWithDuration:0.4 animations:^{
        CGPoint _center = self.center;
        if (_center.y > 0) {//显示状态
            _center.y -= CGRectGetHeight(self.frame);
        }
        self.center = _center;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)displayView//显示
{
    [UIView animateWithDuration:0.4 animations:^{
        self.hidden = NO;
        self.alpha = 1.0;
        
        CGPoint _center = self.center;
        if (_center.y < 0) {//显示状态
            _center.y += CGRectGetHeight(self.frame);
        }
        self.center = _center;
    } completion:^(BOOL finished) {
    }];
}



@end
