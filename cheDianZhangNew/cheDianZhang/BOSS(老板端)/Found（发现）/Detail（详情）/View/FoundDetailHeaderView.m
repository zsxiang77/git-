//
//  FoundDetailHeaderView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/24.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "FoundDetailHeaderView.h"

@implementation FoundDetailHeaderView

-(instancetype)init{
    if (self = [super init]) {
        m_titleLable = [[UILabel alloc]init];
        m_titleLable.numberOfLines = 0;
        m_titleLable.font = [UIFont systemFontOfSize:20];
        m_titleLable.textColor = kRGBColor(51, 51, 51);
        [self addSubview:m_titleLable];
        [m_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        
        m_nameLable = [[UILabel alloc]init];
        m_nameLable.textColor = kRGBColor(157, 157, 157);
        m_nameLable.font = [UIFont systemFontOfSize:13];
        [self addSubview:m_nameLable];
        [m_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(m_titleLable.mas_bottom).mas_equalTo(5);
        }];
        
        m_dateLable = [[UILabel alloc]init];
        m_dateLable.textColor = kRGBColor(157, 157, 157);
        m_dateLable.font = [UIFont systemFontOfSize:13];
        [self addSubview:m_dateLable];
        [m_dateLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(m_nameLable.mas_right).mas_equalTo(20);
            make.top.mas_equalTo(m_titleLable.mas_bottom).mas_equalTo(5);
        }];
        
        
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 102, kWindowW, 190)];
        self.webViewimb = [[UIImageView alloc]initWithImage:DJImageNamed(@"Boss_fond_beijing")];
        self.webViewimb.frame = CGRectMake(0, 0, kWindowW, 190);
        [self.webView addSubview:self.webViewimb];
        self.webView.scrollView.scrollEnabled = NO;
        self.webView.UIDelegate = self;
        self.webView.navigationDelegate = self;
        [self addSubview:self.webView];
        
        m_dianZanBt = [[UIButton alloc]init];
        [m_dianZanBt.layer setMasksToBounds:YES];
        [m_dianZanBt.layer setCornerRadius:17];
        [m_dianZanBt setTitleColor:kRGBColor(155, 155, 155) forState:(UIControlStateNormal)];
        [m_dianZanBt setTitleColor:kRGBColor(208, 27, 1) forState:(UIControlStateSelected)];
        [m_dianZanBt setImage:DJImageNamed(@"boss_Found_dianZan_select") forState:(UIControlStateSelected)];
        [m_dianZanBt setImage:DJImageNamed(@"boss_Found_dianZan") forState:(UIControlStateNormal)];
        [m_dianZanBt addTarget:self action:@selector(dianZanBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        m_dianZanBt.imageEdgeInsets = UIEdgeInsetsMake(8, 5, 8, 13);
        [m_dianZanBt.layer setBorderColor:kLineBgColor.CGColor];
        [m_dianZanBt.layer setBorderWidth:0.5];
        [self addSubview:m_dianZanBt];
        [m_dianZanBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.webView.mas_bottom).mas_equalTo(10);
            make.width.mas_equalTo(109);
            make.height.mas_equalTo(34);
        }];
        
        UIView *boView = [[UIView alloc]init];
        boView.backgroundColor = kRGBColor(242, 247, 255);
        [self addSubview:boView];
        [boView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(0);
            make.height.mas_equalTo(28);
        }];
        
        m_zanNumberLable = [[UILabel alloc]init];
        m_zanNumberLable.font = [UIFont systemFontOfSize:14];
        m_zanNumberLable.textColor = kRGBColor(117, 117, 117);
        [boView addSubview:m_zanNumberLable];
        [m_zanNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(boView);
            make.left.mas_equalTo(10);
        }];
        
        
        m_pingNumberLable = [[UILabel alloc]init];
        m_pingNumberLable.font = [UIFont systemFontOfSize:14];
        m_pingNumberLable.textColor = kRGBColor(117, 117, 117);
        [boView addSubview:m_pingNumberLable];
        [m_pingNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(boView);
            make.left.mas_equalTo(m_zanNumberLable.mas_right).mas_equalTo(18);
        }];
        
        m_yueDuNumberLable = [[UILabel alloc]init];
        m_yueDuNumberLable.font = [UIFont systemFontOfSize:14];
        m_yueDuNumberLable.textColor = kRGBColor(117, 117, 117);
        [boView addSubview:m_yueDuNumberLable];
        [m_yueDuNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(boView);
            make.left.mas_equalTo(m_pingNumberLable.mas_right).mas_equalTo(18);
        }];
        
    }
    return self;
}

-(void)dianZanBtChick:(UIButton *)sender
{
    self.dianZanBtChickBlock();
}

-(void)setanniuDianJidata:(FoundDetailModel *)model{
    m_dianZanBt.selected = [model.is_praise boolValue];
    if ([model.is_praise boolValue] == YES) {
        [m_dianZanBt.layer setBorderColor:kRGBColor(208, 2, 27).CGColor];
    }else{
        [m_dianZanBt.layer setBorderColor:kRGBColor(155, 155, 155).CGColor];
    }
    [m_dianZanBt setTitle:model.praisenum forState:(UIControlStateNormal)];
    m_zanNumberLable.text = [NSString stringWithFormat:@"赞 %@",model.praisenum];
}

-(void)refleshdata:(FoundDetailModel *)model withBuju:(BOOL)buju
{
    CGFloat jisuanHei = 102;
    
    m_titleLable.text = model.title;
    m_nameLable.text = model.author;
    m_dateLable.text = model.time;

    
    if (buju == YES) {
        [self webViewDidFinishLoad:self.webView];
    }else{
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.content]]];
    }
    
    
    jisuanHei += self.webView.frame.size.height;
    
    m_dianZanBt.selected = [model.is_praise boolValue];
    if ([model.is_praise boolValue] == YES) {
        [m_dianZanBt.layer setBorderColor:kRGBColor(208, 2, 27).CGColor];
    }else{
        [m_dianZanBt.layer setBorderColor:kRGBColor(155, 155, 155).CGColor];
    }
    [m_dianZanBt setTitle:model.praisenum forState:(UIControlStateNormal)];
    
    m_zanNumberLable.text = [NSString stringWithFormat:@"赞 %@",model.praisenum];
    m_pingNumberLable.text = [NSString stringWithFormat:@"评论 %@",model.commentnum];
    m_yueDuNumberLable.text = [NSString stringWithFormat:@"阅读量 %@",model.readnum];
    
    jisuanHei += (34+23+30);
    
    self.frame = CGRectMake(0, 0, kWindowW, jisuanHei);
    
}
//根据webview内嵌的scrollView的contentSize.height去计算高度：
-(void)webViewDidFinishLoad:(WKWebView *)webView {
    
    CGFloat height = 0.0;
    [webView sizeToFit];
    height = webView.scrollView.contentSize.height;
    CGRect webFrame = webView.frame;
    webFrame.size.height = height;
    webView.frame = webFrame;
}


@end
