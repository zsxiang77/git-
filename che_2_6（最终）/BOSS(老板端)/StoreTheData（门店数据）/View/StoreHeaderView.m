//
//  StoreHeaderView.m
//  cheDianZhang
//
//  Created by apple on 2018/4/22.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreHeaderView.h"

@implementation StoreHeaderView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        UIButton * btn = [[UIButton alloc]init];
        [btn setBackgroundImage:[UIImage imageNamed:@"shijianTuPian"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(riliClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(6);
            make.width.height.mas_equalTo(40);
        }];
        
        self.timeDateLable = [[UILabel alloc]init];
        self.timeDateLable.font = [UIFont systemFontOfSize:12];
        [self.timeDateLable setTextColor:[UIColor blackColor]];
        self.timeDateLable.text = @"hakhfkahfk";
        [self addSubview:self.timeDateLable];
        [self.timeDateLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(btn.mas_right).mas_equalTo(8);
            make.centerY.mas_equalTo(btn);
        }];
        
        UIView * rightView = [[UIView alloc]init];
        [rightView.layer setMasksToBounds:YES];
        [rightView.layer setBorderWidth:0.5];
        [rightView.layer setBorderColor:kLineBgColor.CGColor];
        [rightView.layer setCornerRadius:25/2];
        [self addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(270/2);
            make.centerY.mas_equalTo(self.timeDateLable);
            make.right.mas_equalTo(-10);
        }];
        for (int i=0; i<3; i++) {
            UIButton * btnse = [[UIButton alloc]init];
            btnse.frame = CGRectMake(270/2/3*i, 0, 270/2/3, 25);
            btnse.titleLabel.font = [UIFont systemFontOfSize: 14];
            [btnse.layer setMasksToBounds:YES];
            [btnse.layer setCornerRadius:25/2];
            btnse.tag = 400+i;
            [btnse addTarget:self action:@selector(qiehuanshijian:) forControlEvents:(UIControlEventTouchUpInside)];
            [btnse setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
            [btnse setTitleColor:kRGBColor(255, 255, 255)forState:(UIControlStateSelected)];
            [btnse setBackgroundImage:[UIImage imageWithColor:kZhuTiColor] forState:UIControlStateSelected];
            [btnse setBackgroundImage:[UIImage imageWithColor:kRGBColor(255, 255, 255)] forState:UIControlStateNormal];
            [rightView addSubview: btnse];
            if(i==0){
                [btnse setTitle:@"周" forState:(UIControlStateNormal)];
                [btnse setTitle:@"周" forState:(UIControlStateSelected)];
                btnse .selected = YES;
            }else if(i==1){
                [btnse setTitle:@"月" forState:(UIControlStateNormal)];
                [btnse setTitle:@"月" forState:(UIControlStateSelected)];
            }else{
                [btnse setTitle:@"季" forState:(UIControlStateNormal)];
                [btnse setTitle:@"季" forState:(UIControlStateSelected)];
            }
        }
        
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 54, kWindowW, 310)];
        [self addSubview:scrollView];
        
        UIView * viewBiao = [[UIView alloc]initWithFrame:CGRectMake(12, 0, kWindowW-12-28, 552/2)];
        [viewBiao.layer setCornerRadius:5];
        [viewBiao.layer setBorderWidth:1];
        [viewBiao.layer setBorderColor:kRGBColor(192,218,254).CGColor];
        viewBiao.layer.shadowColor = kRGBColor(192,218,254).CGColor;//shadowColor阴影颜色
        viewBiao.layer.shadowOpacity = 0.5;
        viewBiao.layer.shadowRadius = 2;// 阴影扩散的范围控制
        viewBiao.layer.shadowOffset = CGSizeMake(0,6);// 阴影的范围
        [scrollView addSubview:viewBiao];
        
        anNniuView = [[UIView alloc]init];
        [anNniuView.layer setMasksToBounds:YES];
        [anNniuView.layer setBorderWidth:0.5];
        [anNniuView.layer setBorderColor:kLineBgColor.CGColor];
        [anNniuView.layer setCornerRadius:10];
        [self addSubview:anNniuView];
        [anNniuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-7);
            make.height.mas_equalTo(32);
            make.width.mas_equalTo(186/2);
        }];
        UILabel *btnLine =[[UILabel alloc]init];
        btnLine .backgroundColor = kLineBgColor;
        [anNniuView addSubview:btnLine];
        [btnLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(anNniuView);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(14);
            make.left.mas_equalTo(92/2);
        }];
        for (int i=0 ; i<2; i++) {
            UIButton * buttonTwo = [[UIButton alloc]init];
            buttonTwo.titleLabel.font = [UIFont systemFontOfSize:14];
            [buttonTwo addTarget:self action:@selector(xuanzeRenYuanBtn:) forControlEvents:(UIControlEventTouchUpInside)];
            buttonTwo.tag = 500+i;
            [buttonTwo setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
            [buttonTwo setTitleColor:kZhuTiColor forState:(UIControlStateSelected)];
            [anNniuView addSubview:buttonTwo];
            if(i==0){
                [buttonTwo setTitle:@"事项" forState:(UIControlStateNormal)];
                [buttonTwo setTitle:@"事项" forState:(UIControlStateSelected)];
                buttonTwo.frame = CGRectMake(0, 0, 92/2, 32);
                buttonTwo.selected = YES;
            }else{
                [buttonTwo setTitle:@"人员" forState:(UIControlStateNormal)];
                [buttonTwo setTitle:@"人员" forState:(UIControlStateSelected)];
                buttonTwo.frame = CGRectMake(92/2+1, 0, 92/2, 32);
            }
        }
        
        UILabel * lableTite = [[UILabel alloc]init];
        lableTite.backgroundColor = kLineBgColor;
        [self addSubview:lableTite];
        [lableTite mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}
-(void)qiehuanshijian:(UIButton*)sender
{
    if (sender.selected == YES) {
        return;
    }
    for (int i =0; i<3; i++) {
        UIButton *bt = [self viewWithTag:400+i];
        bt.selected = NO;
    }
    sender.selected =! sender.selected;
}
-(void)xuanzeRenYuanBtn:(UIButton *)sender
{
    if (sender.selected == YES) {
        return;
    }
    for (int i =0; i<2; i++) {
        UIButton *bt = [anNniuView viewWithTag:500+i];
        bt.selected = NO;
    }
    sender.selected =! sender.selected;

}

-(void)riliClick:(UIButton *)sender
{
    self.showRiLiBlock();
}
@end
