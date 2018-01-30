//
//  CPHFWeiHeaderView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/18.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "CPHFWeiHeaderView.h"
#import "BOSSCheDianZhangCommon.h"
#import "UIImageView+WebCache.h"


@implementation CPHFWeiHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont boldSystemFontOfSize:22];
        nameLabel.textColor = kRGBColor(74, 74, 74);
        [self addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.top.mas_equalTo(8);
        }];
        
        jingJiImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"boss_ic_urgency")];
        [self addSubview:jingJiImageView];
        [jingJiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(16);
            make.centerY.mas_equalTo(nameLabel);
            make.left.mas_equalTo(nameLabel.mas_right).mas_equalTo(6);
        }];
        
        zhongYaoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"boss_ic_important")];
        [self addSubview:zhongYaoImageView];
        [zhongYaoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(16);
            make.centerY.mas_equalTo(nameLabel);
            make.left.mas_equalTo(nameLabel.mas_right).mas_equalTo(38);
        }];
        
        statusLabel = [[UILabel alloc]init];
        statusLabel.textColor = kRGBColor(230, 67, 64);
        statusLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:statusLabel];
        [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-7);
            make.top.mas_equalTo(13);
        }];
        
        
        UILabel *fuzeLabel = [[UILabel alloc]init];
        fuzeLabel.textColor = kRGBColor(155, 155, 155);
        fuzeLabel.font = [UIFont systemFontOfSize:14];
        fuzeLabel.text = @"负责人：";
        [self addSubview:fuzeLabel];
        [fuzeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(7);
            make.top.mas_equalTo(82);
        }];
        
        fuzeRenLabel = [[UILabel alloc]init];
        fuzeRenLabel.font = [UIFont boldSystemFontOfSize:20];
        fuzeRenLabel.textColor = kRGBColor(74, 74, 74);
        [self addSubview:fuzeRenLabel];
        [fuzeRenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(fuzeLabel.mas_right).mas_equalTo(12);
            make.centerY.mas_equalTo(fuzeLabel);
        }];
        
        UIButton *modileBt = [[UIButton alloc]init];
        [modileBt addTarget:self action:@selector(modileBtChcik:) forControlEvents:(UIControlEventTouchUpInside)];
        [modileBt setBackgroundImage:DJImageNamed(@"boss_detail_modile") forState:(UIControlStateNormal)];
        [self addSubview:modileBt];
        [modileBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(fuzeRenLabel.mas_right).mas_equalTo(1);
            make.centerY.mas_equalTo(fuzeRenLabel);
            make.width.height.mas_equalTo(30);
        }];
        
        UILabel *daoQiLabel = [[UILabel alloc]init];
        daoQiLabel.textColor = kRGBColor(155, 155, 155);
        daoQiLabel.font = [UIFont systemFontOfSize:14];
        daoQiLabel.text = @"到期时间：";
        [self addSubview:daoQiLabel];
        [daoQiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(7);
            make.top.mas_equalTo(113);
        }];
        
        m_daoQiLabel = [[UILabel alloc]init];
        m_daoQiLabel.textColor = kRGBColor(155, 155, 155);
        m_daoQiLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:m_daoQiLabel];
        [m_daoQiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(daoQiLabel);
            make.left.mas_equalTo(daoQiLabel.mas_right).mas_equalTo(5);
        }];
        
        m_remainLabel = [[UILabel alloc]init];
        m_remainLabel.textColor = kRGBColor(155, 155, 155);
        m_remainLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:m_remainLabel];
        [m_remainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(115);
            make.right.mas_equalTo(-7);
        }];
        
        m_remainTupianImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"boss_detail_huo")];
        m_remainTupianImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:m_remainTupianImageView];
        [m_remainTupianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(m_remainLabel);
            make.right.mas_equalTo(m_remainLabel.mas_left);
            make.width.height.mas_equalTo(56);
        }];
        
        m_remainTupianLabel = [[UILabel alloc]init];
        m_remainTupianLabel.textColor = [UIColor whiteColor];
        m_remainTupianLabel.font = [UIFont boldSystemFontOfSize:25];
        m_remainTupianLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:m_remainTupianLabel];
        [m_remainTupianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(m_remainLabel).mas_equalTo(8);
            make.right.mas_equalTo(m_remainLabel.mas_left);
            make.width.height.mas_equalTo(56);
        }];
        
        UILabel *daoLabel = [[UILabel alloc]init];
        daoLabel.textColor = kRGBColor(155, 155, 155);
        daoLabel.font = [UIFont systemFontOfSize:10];
        daoLabel.text = @"倒计时";
        [self addSubview:daoLabel];
        [daoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(m_remainLabel);
            make.right.mas_equalTo(m_remainTupianLabel.mas_left);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(143);
        }];
        
        
        m_pingJieView = [[UIView alloc]initWithFrame:CGRectMake(0, 143, kWindowW, 132)];
        [self addSubview:m_pingJieView];
    }
    return self;
}


-(void)refreshData:(JobBoardDetailModel *)model
{
    self.zhuModel = model.info;
    JobBoardInfoModel *dict = model.info;
    nameLabel.text = dict.name;
    if ([dict.is_urgent boolValue] == YES &&[dict.is_heavy boolValue] == YES ) {
        jingJiImageView.hidden = NO;
        zhongYaoImageView.hidden = NO;
    }else if ([dict.is_urgent boolValue] == YES &&[dict.is_heavy boolValue] == NO ) {
        jingJiImageView.hidden = NO;
        zhongYaoImageView.hidden = YES;
    }else if ([dict.is_urgent boolValue] == NO &&[dict.is_heavy boolValue] == YES ) {
        jingJiImageView.hidden = YES;
        zhongYaoImageView.hidden = NO;
        [zhongYaoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(nameLabel.mas_right).mas_equalTo(6);
        }];
    }else{
        jingJiImageView.hidden = YES;
        zhongYaoImageView.hidden = YES;
    }
    
    if ([dict.status integerValue] == 0) {
        statusLabel.text = @"未处理";
        statusLabel.textColor = kRGBColor(230, 67, 64);
    }else if ([dict.status integerValue] == 1) {
        statusLabel.text = @"已处理";
        statusLabel.textColor = kRGBColor(98, 172, 13);
    }else
    {
        statusLabel.text = @"已过期";
        statusLabel.textColor = kRGBColor(230, 67, 64);
    }
    fuzeRenLabel.text = dict.person_name;
    m_daoQiLabel.text = dict.end_time;
    m_remainLabel.text = dict.unit;
    
    if ([dict.is_urgent boolValue] == YES ) {
        m_remainTupianImageView.hidden = NO;
        m_remainTupianLabel.textColor = [UIColor whiteColor];
    }else{
        m_remainTupianImageView.hidden = YES;
        m_remainTupianLabel.textColor = kRGBColor(74, 74, 74);
        [m_remainTupianLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(m_remainLabel);
            make.right.mas_equalTo(m_remainLabel.mas_left);
            make.width.height.mas_equalTo(30);
        }];
    }

    m_remainTupianLabel.text = dict.remain;
    m_pingJieView.hidden = YES;
    
    CGFloat jisuahei  = 276-130;
    
    /**
     task_type 0:客户流失 1:异常工单 2:差评回访 3:预约跟进 4:保养到期 5:保险到期 6:年检提醒 7:生日回访 8:询价追踪
     9:工单回访 10:全部任务
     */
#pragma mark - 客户流失
    if([model.info.task_type integerValue] == 0)//客户流失
    {
        //删除cell的所有子视图
        while ([m_pingJieView.subviews lastObject] != nil)
        {
            [(UIView*)[m_pingJieView.subviews lastObject] removeFromSuperview];
        }
        m_pingJieView.frame = CGRectMake(0, jisuahei, kWindowW, dict.contents.count*40);
        jisuahei += dict.contents.count*40;
        
        for (int i = 0; i<dict.contents.count; i++){
            UILabel *baoZuoLabel = [[UILabel alloc]init];
            baoZuoLabel.font = [UIFont systemFontOfSize:17];
            baoZuoLabel.textColor = kRGBColor(155, 155, 155);
            [m_pingJieView addSubview:baoZuoLabel];
            [baoZuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(i*40);
                make.height.mas_equalTo(40);
                make.left.mas_equalTo(9);
            }];
            
            UILabel *baoYouLabel = [[UILabel alloc]init];
            baoYouLabel.font = [UIFont systemFontOfSize:17];
            baoYouLabel.textColor = kRGBColor(74, 74, 74);
            [m_pingJieView addSubview:baoYouLabel];
            [baoYouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(i*40);
                make.height.mas_equalTo(40);
                make.right.mas_equalTo(-9);
            }];
            
            NSDictionary *contents = dict.contents[i];
            baoZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"name")];
            baoYouLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"value")];
            if (i == 0) {
                
            }else if (i == 1) {
                
            }else if (i == 2) {
                
            }else if (i == 3) {
                
            }else if (i == 4) {
                
            }else if (i == 5) {
                baoYouLabel.textColor = kRGBColor(230, 67, 64);
            }
        }
    }
    
#pragma mark - 生日回访
    if([model.info.task_type integerValue] == 7)//生日回访
    {
        //删除cell的所有子视图
        while ([m_pingJieView.subviews lastObject] != nil)
        {
            [(UIView*)[m_pingJieView.subviews lastObject] removeFromSuperview];
        }
        m_pingJieView.frame = CGRectMake(0, jisuahei, kWindowW, dict.contents.count*40);
        jisuahei += dict.contents.count*40;
        
        for (int i = 0; i<dict.contents.count; i++){
            UILabel *baoZuoLabel = [[UILabel alloc]init];
            baoZuoLabel.font = [UIFont systemFontOfSize:17];
            baoZuoLabel.textColor = kRGBColor(155, 155, 155);
            [m_pingJieView addSubview:baoZuoLabel];
            [baoZuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(i*40);
                make.height.mas_equalTo(40);
                make.left.mas_equalTo(9);
            }];
            
            UILabel *baoYouLabel = [[UILabel alloc]init];
            baoYouLabel.font = [UIFont systemFontOfSize:17];
            baoYouLabel.textColor = kRGBColor(74, 74, 74);
            [m_pingJieView addSubview:baoYouLabel];
            [baoYouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(i*40);
                make.height.mas_equalTo(40);
                make.right.mas_equalTo(-9);
            }];
            
            NSDictionary *contents = dict.contents[i];
            baoZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"name")];
            baoYouLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"value")];
            if ([[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"key")] isEqualToString:@"user_type"]) {
                baoYouLabel.hidden = YES;
                UIImageView *im  = [[UIImageView alloc]initWithImage:DJImageNamed([NSString stringWithFormat:@"boss_dengJi_%@",KISDictionaryHaveKey(contents, @"value")])];
                [m_pingJieView addSubview:im];
                [im mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(i*40+10);
                    make.height.mas_equalTo(20);
                    make.width.mas_equalTo(20);
                    make.right.mas_equalTo(-9);
                }];
            }
            
            if ([[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"key")] isEqualToString:@"consume_money"]) {
                baoYouLabel.textColor = kRGBColor(230, 67, 64);
            }
        }
    }
    /**
     task_type 0:客户流失 1:异常工单 2:差评回访 3:预约跟进 4:保养到期 5:保险到期 6:年检提醒 7:生日回访 8:询价追踪
     9:工单回访 10:全部任务
     */
#pragma mark - 保养到期
    if([model.info.task_type integerValue] == 4)//生日回访
    {
        //删除cell的所有子视图
        while ([m_pingJieView.subviews lastObject] != nil)
        {
            [(UIView*)[m_pingJieView.subviews lastObject] removeFromSuperview];
        }
        m_pingJieView.frame = CGRectMake(0, jisuahei, kWindowW, dict.contents.count*40);
        CGFloat baocunheight = jisuahei;
        
        CGFloat zongHeight = 0;
        
        for (int i = 0; i<dict.contents.count; i++){
            
            NSDictionary *contents = dict.contents[i];
            
            NSString *keyStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"key")];
            CGFloat xiangzuowight = 0;
            if ([keyStr isEqualToString:@"order_subjects"]) {
                UILabel *baoZuoLabel2 = [[UILabel alloc]init];
                baoZuoLabel2.font = [UIFont systemFontOfSize:17];
                baoZuoLabel2.textColor = kRGBColor(155, 155, 155);
                [m_pingJieView addSubview:baoZuoLabel2];
                [baoZuoLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(zongHeight);
                    make.height.mas_equalTo(40);
                    make.left.mas_equalTo(9);
                }];
                NSDictionary *contents2 = dict.contents[i];
                baoZuoLabel2.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents2, @"name")];
                NSString *contents2value = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents2, @"value")];
                NSArray *contents2Array = [contents2value componentsSeparatedByString:@"&"];
                
                if ([contents2Array isKindOfClass:[NSArray class]]&&contents2Array.count>0) {
                    for (int h = 0; h<contents2Array.count; h++) {
                        UILabel *yuyueLabel = [[UILabel alloc]init];
                        yuyueLabel.font = [UIFont systemFontOfSize:14];
                        yuyueLabel.textColor = kZhuTiColor;
                        yuyueLabel.tag = 500 + h;
                        yuyueLabel.numberOfLines = 0;
                        yuyueLabel.text = contents2Array[h];
                        [m_pingJieView addSubview:yuyueLabel];
                        [yuyueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.mas_equalTo(-18-xiangzuowight);
                            make.top.mas_equalTo(zongHeight);
                            make.height.mas_equalTo(40);
                            make.left.mas_greaterThanOrEqualTo(110);
                        }];
                        CGSize wordSize = DAJIANG_MULTILINE_TEXTSIZE(contents2Array[h], DJSystemFont(14), CGSizeMake(kWindowW-20, 20));
                        xiangzuowight += (wordSize.width + 36);
                        if (xiangzuowight>kWindowW-180) {
                            xiangzuowight = 0;
                            zongHeight += 40;
                        }
                        
                        UIView *backView = [[UIView alloc]init];
                        backView.backgroundColor = kColorWithRGB(74, 144, 226, 0.15);
                        [backView.layer setMasksToBounds:YES];
                        [backView.layer setCornerRadius:2];
                        [backView.layer setBorderWidth:0.5];
                        [backView.layer setBorderColor:kRGBColor(74, 144, 226).CGColor];
                        [m_pingJieView addSubview:backView];
                        if (yuyueLabel.text.length<=0) {
                            backView.hidden = YES;
                        }
                        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(yuyueLabel.mas_left).mas_equalTo(-8);
                            make.right.mas_equalTo(yuyueLabel.mas_right).mas_equalTo(8);
                            make.height.mas_equalTo(25);
                            make.center.mas_equalTo(yuyueLabel);
                        }];
                        [m_pingJieView bringSubviewToFront:yuyueLabel];
                    }
                    zongHeight += 40;
                }
            }else{
                UILabel *baoZuoLabel = [[UILabel alloc]init];
                baoZuoLabel.font = [UIFont systemFontOfSize:17];
                baoZuoLabel.textColor = kRGBColor(155, 155, 155);
                [m_pingJieView addSubview:baoZuoLabel];
                [baoZuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(zongHeight);
                    make.height.mas_equalTo(40);
                    make.left.mas_equalTo(9);
                }];
                
                UILabel *baoYouLabel = [[UILabel alloc]init];
                baoYouLabel.font = [UIFont systemFontOfSize:17];
                baoYouLabel.numberOfLines = 0;
                baoYouLabel.textColor = kRGBColor(74, 74, 74);
                [m_pingJieView addSubview:baoYouLabel];
                [baoYouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(zongHeight);
                    make.height.mas_equalTo(40);
                    make.right.mas_equalTo(-9);
                    make.left.mas_greaterThanOrEqualTo(110);
                }];
                
                
                NSDictionary *contents = dict.contents[i];
                baoZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"name")];
                baoYouLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"value")];
                if ([[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"key")] isEqualToString:@"remark"]) {
                    baoYouLabel.font = [UIFont systemFontOfSize:14];
                }
                zongHeight += 40;
            }
            NPrintLog(@"zongHeights%f",zongHeight);
        }
        jisuahei += zongHeight;
        m_pingJieView.frame = CGRectMake(0, baocunheight, kWindowW, jisuahei-baocunheight);
    }
    /**
     task_type 0:客户流失 1:异常工单 2:差评回访 3:预约跟进 4:保养到期 5:保险到期 6:年检提醒 7:生日回访 8:询价追踪
     9:工单回访 10:全部任务
     */
#pragma mark - 询价追踪
    if([model.info.task_type integerValue] == 8)//询价追踪
    {
        //删除cell的所有子视图
        while ([m_pingJieView.subviews lastObject] != nil)
        {
            [(UIView*)[m_pingJieView.subviews lastObject] removeFromSuperview];
        }
        m_pingJieView.frame = CGRectMake(0, jisuahei, kWindowW, dict.contents.count*40);
        CGFloat baocunheight = jisuahei;
        
        CGFloat zongHeight = 0;
        
        for (int i = 0; i<dict.contents.count; i++){
            
            NSDictionary *contents = dict.contents[i];
            
            NSString *keyStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"key")];
            CGFloat xiangzuowight = 0;
            if ([keyStr isEqualToString:@"order_subjects"]) {
                UILabel *baoZuoLabel2 = [[UILabel alloc]init];
                baoZuoLabel2.font = [UIFont systemFontOfSize:17];
                baoZuoLabel2.textColor = kRGBColor(155, 155, 155);
                [m_pingJieView addSubview:baoZuoLabel2];
                [baoZuoLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(zongHeight);
                    make.height.mas_equalTo(40);
                    make.left.mas_equalTo(9);
                }];
                NSDictionary *contents2 = dict.contents[i];
                baoZuoLabel2.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents2, @"name")];
                NSString *contents2value = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents2, @"value")];
                NSArray *contents2Array = [contents2value componentsSeparatedByString:@"&"];
                
                if ([contents2Array isKindOfClass:[NSArray class]]&&contents2Array.count>0) {
                    for (int h = 0; h<contents2Array.count; h++) {
                        UILabel *yuyueLabel = [[UILabel alloc]init];
                        yuyueLabel.font = [UIFont systemFontOfSize:14];
                        yuyueLabel.textColor = kZhuTiColor;
                        yuyueLabel.tag = 500 + h;
                        yuyueLabel.numberOfLines = 0;
                        yuyueLabel.text = contents2Array[h];
                        [m_pingJieView addSubview:yuyueLabel];
                        [yuyueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.mas_equalTo(-18-xiangzuowight);
                            make.top.mas_equalTo(zongHeight);
                            make.height.mas_equalTo(40);
                            make.left.mas_greaterThanOrEqualTo(110);
                        }];
                        CGSize wordSize = DAJIANG_MULTILINE_TEXTSIZE(contents2Array[h], DJSystemFont(14), CGSizeMake(kWindowW-20, 20));
                        xiangzuowight += (wordSize.width + 36);
                        if (xiangzuowight>kWindowW-180) {
                            xiangzuowight = 0;
                            zongHeight += 40;
                        }
                        
                        UIView *backView = [[UIView alloc]init];
                        backView.backgroundColor = kColorWithRGB(74, 144, 226, 0.15);
                        [backView.layer setMasksToBounds:YES];
                        [backView.layer setCornerRadius:2];
                        [backView.layer setBorderWidth:0.5];
                        [backView.layer setBorderColor:kRGBColor(74, 144, 226).CGColor];
                        [m_pingJieView addSubview:backView];
                        if (yuyueLabel.text.length<=0) {
                            backView.hidden = YES;
                        }
                        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(yuyueLabel.mas_left).mas_equalTo(-8);
                            make.right.mas_equalTo(yuyueLabel.mas_right).mas_equalTo(8);
                            make.height.mas_equalTo(25);
                            make.center.mas_equalTo(yuyueLabel);
                        }];
                        [m_pingJieView bringSubviewToFront:yuyueLabel];
                    }
                    zongHeight += 40;
                }
            }else{
                UILabel *baoZuoLabel = [[UILabel alloc]init];
                baoZuoLabel.font = [UIFont systemFontOfSize:17];
                baoZuoLabel.textColor = kRGBColor(155, 155, 155);
                [m_pingJieView addSubview:baoZuoLabel];
                [baoZuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(zongHeight);
                    make.height.mas_equalTo(40);
                    make.left.mas_equalTo(9);
                }];
                
                UILabel *baoYouLabel = [[UILabel alloc]init];
                baoYouLabel.font = [UIFont systemFontOfSize:17];
                baoYouLabel.numberOfLines = 0;
                baoYouLabel.textColor = kRGBColor(74, 74, 74);
                [m_pingJieView addSubview:baoYouLabel];
                [baoYouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(zongHeight);
                    make.height.mas_equalTo(40);
                    make.right.mas_equalTo(-9);
                    make.left.mas_greaterThanOrEqualTo(110);
                }];
                
                
                NSDictionary *contents = dict.contents[i];
                baoZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"name")];
                baoYouLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"value")];
                if ([[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"key")] isEqualToString:@"remark"]) {
                    baoYouLabel.font = [UIFont systemFontOfSize:14];
                }
                zongHeight += 40;
            }
            NPrintLog(@"zongHeights%f",zongHeight);
        }
        jisuahei += zongHeight;
        m_pingJieView.frame = CGRectMake(0, baocunheight, kWindowW, jisuahei-baocunheight);
    }
    /**
     task_type 0:客户流失 1:异常工单 2:差评回访 3:预约跟进 4:保养到期 5:保险到期 6:年检提醒 7:生日回访 8:询价追踪
     9:工单回访 10:全部任务
     */
#pragma mark - 异常工单
    if([model.info.task_type integerValue] == 1)//异常工单
    {
        //删除cell的所有子视图
        while ([m_pingJieView.subviews lastObject] != nil)
        {
            [(UIView*)[m_pingJieView.subviews lastObject] removeFromSuperview];
        }
        m_pingJieView.frame = CGRectMake(0, jisuahei, kWindowW, dict.contents.count*40);
        jisuahei += dict.contents.count*40;
        
        for (int i = 0; i<dict.contents.count; i++){
            UILabel *baoZuoLabel = [[UILabel alloc]init];
            baoZuoLabel.font = [UIFont systemFontOfSize:17];
            baoZuoLabel.textColor = kRGBColor(155, 155, 155);
            [m_pingJieView addSubview:baoZuoLabel];
            [baoZuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(i*40);
                make.height.mas_equalTo(40);
                make.left.mas_equalTo(9);
            }];
            
            UILabel *baoYouLabel = [[UILabel alloc]init];
            baoYouLabel.font = [UIFont systemFontOfSize:17];
            baoYouLabel.textColor = kRGBColor(74, 74, 74);
            [m_pingJieView addSubview:baoYouLabel];
            [baoYouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(i*40);
                make.height.mas_equalTo(40);
                make.right.mas_equalTo(-9);
            }];
            
            NSDictionary *contents = dict.contents[i];
            baoZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"name")];
            baoYouLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"value")];
        }
    }
    
    #pragma mark - 保险到期
    if([model.info.task_type integerValue] == 5)
    {
        //删除cell的所有子视图
        while ([m_pingJieView.subviews lastObject] != nil)
        {
            [(UIView*)[m_pingJieView.subviews lastObject] removeFromSuperview];
        }
        m_pingJieView.frame = CGRectMake(0, jisuahei, kWindowW, dict.contents.count*40);
        jisuahei += dict.contents.count*40;
        
        for (int i = 0; i<dict.contents.count; i++) {
            UILabel *baoZuoLabel = [[UILabel alloc]init];
            baoZuoLabel.font = [UIFont systemFontOfSize:17];
            baoZuoLabel.textColor = kRGBColor(155, 155, 155);
            [m_pingJieView addSubview:baoZuoLabel];
            [baoZuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(i*40);
                make.height.mas_equalTo(40);
                make.left.mas_equalTo(9);
            }];
            
            UILabel *baoYouLabel = [[UILabel alloc]init];
            baoYouLabel.font = [UIFont systemFontOfSize:17];
            baoYouLabel.textColor = kRGBColor(74, 74, 74);
            [m_pingJieView addSubview:baoYouLabel];
            [baoYouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(i*40);
                make.height.mas_equalTo(40);
                make.right.mas_equalTo(-9);
            }];
            
            
            
            if (i == 0) {
                NSDictionary *contents = dict.contents[1];
                baoZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"name")];
                baoYouLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"value")];
                UIImageView *baoImage = [[UIImageView alloc]init];
                NSDictionary *contents0 = dict.contents[0];
                [baoImage  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents0, @"value")]] placeholderImage:DJImageNamed(@"")];
                [m_pingJieView addSubview:baoImage];
                [baoImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(41);
                    make.height.mas_equalTo(16);
                    make.right.mas_equalTo(baoYouLabel.mas_left).mas_equalTo(-5);
                    make.centerY.mas_equalTo(baoYouLabel);
                }];
                
            }else if (i == 1) {
                NSDictionary *contents = dict.contents[2];
                baoZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"name")];
                baoYouLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"value")];
            }
        }
        
    }
    
    /**
     task_type 0:客户流失 1:异常工单 2:差评回访 3:预约跟进 4:保养到期 5:保险到期 6:年检提醒 7:生日回访 8:询价追踪
     9:工单回访 10:全部任务
     */
#pragma mark - 差评回访或工单回访
    if([model.info.task_type integerValue] == 2|| [model.info.task_type integerValue] == 9)
    {
        //删除cell的所有子视图
        while ([m_pingJieView.subviews lastObject] != nil)
        {
            [(UIView*)[m_pingJieView.subviews lastObject] removeFromSuperview];
        }
        m_pingJieView.frame = CGRectMake(0, jisuahei, kWindowW, 0);
        CGFloat dingWeiHeight = 0;
        
        for (int i = 0; i<dict.contents.count; i++) {
            NSString *keyStr = KISDictionaryHaveKey(dict.contents[i], @"key");
            
            UILabel *baoZuoLabel = [[UILabel alloc]init];
            if ([keyStr isEqualToString:@"comments"]) {
                baoZuoLabel.font = [UIFont systemFontOfSize:17];
                baoZuoLabel.textColor = kRGBColor(155, 155, 155);
            }else{
                baoZuoLabel.font = [UIFont systemFontOfSize:14];
                baoZuoLabel.textColor = kRGBColor(245, 166, 35);
            }
            
            [m_pingJieView addSubview:baoZuoLabel];
            [baoZuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(dingWeiHeight);
                make.height.mas_equalTo(40);
                make.left.mas_equalTo(9);
            }];
            baoZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict.contents[i], @"name")];
            dingWeiHeight += 40;
            
            NSString * jsonString = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict.contents[i], @"value")];
            
            if (jsonString.length>0) {
                NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                NSDictionary *baoZuoLabelvalue = dic;
                if ([NSString stringWithFormat:@"%@",KISDictionaryHaveKey(baoZuoLabelvalue, @"com_star")].length>0) {
                    [self setWuKeXing:baoZuoLabelvalue withNewView:m_pingJieView withxiangshangHeght:dingWeiHeight-40];
                }
                
                if ([NSString stringWithFormat:@"%@",KISDictionaryHaveKey(baoZuoLabelvalue, @"remark")].length>0) {
                    UILabel *beiZhuiLabel = [[UILabel alloc]init];
                    beiZhuiLabel.font = [UIFont systemFontOfSize:14];
                    beiZhuiLabel.textColor = kRGBColor(74, 74, 74);
                    beiZhuiLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(baoZuoLabelvalue, @"remark")];
                    beiZhuiLabel.numberOfLines = 0;
                    [m_pingJieView addSubview:beiZhuiLabel];
                    [beiZhuiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(dingWeiHeight);
                        make.height.mas_equalTo(40);
                        make.right.mas_equalTo(-9);
                        make.left.mas_equalTo(9);
                    }];
                    dingWeiHeight += 40;
                }
                if ([NSString stringWithFormat:@"%@",KISDictionaryHaveKey(baoZuoLabelvalue, @"images")].length>0) {
                    
                    NSArray *contents2Array = [[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(baoZuoLabelvalue, @"images")] componentsSeparatedByString:@","];
                    UIScrollView *pjScrollView = [[UIScrollView alloc]init];
                    
                    [m_pingJieView addSubview:pjScrollView];
                    [pjScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(10);
                        make.right.mas_equalTo(-10);
                        make.top.mas_equalTo(dingWeiHeight);
                        make.height.mas_equalTo(69);
                    }];
                    dingWeiHeight += 69;
                    
                    [self zuoYouScrollViewBuju:contents2Array withScrllow:pjScrollView];
                    
                }
            }
            
        }
        m_pingJieView.frame = CGRectMake(0, jisuahei, kWindowW, dingWeiHeight);
        jisuahei += dingWeiHeight;
    }
    
    /**
     task_type 0:客户流失 1:异常工单 2:差评回访 3:预约跟进 4:保养到期 5:保险到期 6:年检提醒 7:生日回访 8:询价追踪
     9:工单回访 10:全部任务
     */
#pragma mark - 预约跟进
    if([model.info.task_type integerValue] == 3)//异常工单
    {
        //删除cell的所有子视图
        while ([m_pingJieView.subviews lastObject] != nil)
        {
            [(UIView*)[m_pingJieView.subviews lastObject] removeFromSuperview];
        }
        m_pingJieView.frame = CGRectMake(0, jisuahei, kWindowW, 80);
        
        CGFloat dingFloat = 0;
        
        for (int i = 0; i<dict.contents.count; i++){
            NSDictionary *neDict = dict.contents[i];
            NSString *keyStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(neDict, @"key")];
            if ([keyStr isEqualToString:@"appoint_time"] || [keyStr isEqualToString:@"arrival_time"]) {
                UILabel *baoZuoLabel = [[UILabel alloc]init];
                baoZuoLabel.font = [UIFont systemFontOfSize:17];
                baoZuoLabel.textColor = kRGBColor(155, 155, 155);
                [m_pingJieView addSubview:baoZuoLabel];
                [baoZuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(i*40);
                    make.height.mas_equalTo(40);
                    make.left.mas_equalTo(9);
                }];
                
                UILabel *baoYouLabel = [[UILabel alloc]init];
                baoYouLabel.font = [UIFont systemFontOfSize:17];
                baoYouLabel.textColor = kRGBColor(74, 74, 74);
                [m_pingJieView addSubview:baoYouLabel];
                [baoYouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(i*40);
                    make.height.mas_equalTo(40);
                    make.right.mas_equalTo(-9);
                }];
                
                NSDictionary *contents = dict.contents[i];
                baoZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"name")];
                baoYouLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"value")];
                dingFloat += 40;
            }
            
            
            if ([keyStr isEqualToString:@"order_subjects"]) {
                UILabel *baoZuoLabel2 = [[UILabel alloc]init];
                baoZuoLabel2.font = [UIFont systemFontOfSize:17];
                baoZuoLabel2.textColor = kRGBColor(155, 155, 155);
                [m_pingJieView addSubview:baoZuoLabel2];
                [baoZuoLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(dingFloat);
                    make.height.mas_equalTo(40);
                    make.left.mas_equalTo(9);
                }];
                NSDictionary *contents2 = dict.contents[2];
                baoZuoLabel2.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents2, @"name")];
                NSString *contents2value = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents2, @"value")];
                NSArray *contents2Array = [contents2value componentsSeparatedByString:@"&"];
                CGFloat xiangzuowight = 0;
                CGFloat xiangzuoheight = 0;
                if ([contents2Array isKindOfClass:[NSArray class]]&&contents2Array.count>0) {
                    for (int h = 0; h<contents2Array.count; h++) {
                        UILabel *yuyueLabel = [[UILabel alloc]init];
                        yuyueLabel.font = [UIFont systemFontOfSize:14];
                        yuyueLabel.textColor = kZhuTiColor;
                        yuyueLabel.tag = 500 + h;
                        yuyueLabel.numberOfLines = 0;
                        yuyueLabel.text = contents2Array[h];
                        [m_pingJieView addSubview:yuyueLabel];
                        [yuyueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.mas_equalTo(-18-xiangzuowight);
                            make.top.mas_equalTo(dingFloat+xiangzuoheight);
                            make.height.mas_equalTo(40);
                            make.left.mas_greaterThanOrEqualTo(110);
                        }];
                        CGSize wordSize = DAJIANG_MULTILINE_TEXTSIZE(contents2Array[h], DJSystemFont(14), CGSizeMake(kWindowW-20, 20));
                        xiangzuowight += (wordSize.width + 36);
                        if (xiangzuowight>kWindowW-180) {
                            xiangzuowight = 0;
                            xiangzuoheight += 40;
                        }
                        
                        UIView *backView = [[UIView alloc]init];
                        backView.backgroundColor = kColorWithRGB(74, 144, 226, 0.15);
                        [backView.layer setMasksToBounds:YES];
                        [backView.layer setCornerRadius:2];
                        [backView.layer setBorderWidth:0.5];
                        [backView.layer setBorderColor:kRGBColor(74, 144, 226).CGColor];
                        [m_pingJieView addSubview:backView];
                        if (yuyueLabel.text.length<=0) {
                            backView.hidden = YES;
                        }
                        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(yuyueLabel.mas_left).mas_equalTo(-8);
                            make.right.mas_equalTo(yuyueLabel.mas_right).mas_equalTo(8);
                            make.height.mas_equalTo(25);
                            make.center.mas_equalTo(yuyueLabel);
                        }];
                        [m_pingJieView bringSubviewToFront:yuyueLabel];
                    }
                    
                    dingFloat += (xiangzuoheight+40);
                    
                }else{
                    
                    dingFloat += 40;
                }
            }
            if ([keyStr isEqualToString:@"remark"]) {
                UILabel *baoZuoLabel = [[UILabel alloc]init];
                baoZuoLabel.font = [UIFont systemFontOfSize:17];
                baoZuoLabel.textColor = kRGBColor(155, 155, 155);
                [m_pingJieView addSubview:baoZuoLabel];
                [baoZuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(dingFloat);
                    make.height.mas_equalTo(40);
                    make.left.mas_equalTo(9);
                }];
                
                UILabel *baoYouLabel = [[UILabel alloc]init];
                baoYouLabel.font = [UIFont systemFontOfSize:17];
                baoYouLabel.textColor = kRGBColor(74, 74, 74);
                baoYouLabel.textAlignment = NSTextAlignmentRight;
                baoYouLabel.numberOfLines = 2;
                baoYouLabel.adjustsFontSizeToFitWidth = YES;
                [m_pingJieView addSubview:baoYouLabel];
                [baoYouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(dingFloat);
                    make.height.mas_equalTo(40);
                    make.right.mas_equalTo(-9);
                    make.left.mas_greaterThanOrEqualTo(110);
                }];
                
                NSDictionary *contents = dict.contents[i];
                baoZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"name")];
                baoYouLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"value")];
                dingFloat += 40;
            }
        }
        m_pingJieView.frame = CGRectMake(0, jisuahei, kWindowW, dingFloat);
        jisuahei += dingFloat;
        
    }
    
    /**
     task_type 0:客户流失 1:异常工单 2:差评回访 3:预约跟进 4:保养到期 5:保险到期 6:年检提醒 7:生日回访 8:询价追踪
     9:工单回访 10:全部任务
     */
    if([model.info.task_type integerValue] == 2)
    {
        if ([dict.contents isKindOfClass:[NSDictionary class]]) {
            NSDictionary *contents = dict.contents[0];
            if ([contents isKindOfClass:[NSDictionary class]]) {
                if ([model.info.task_type integerValue] == 2) {
                    //删除cell的所有子视图
                    while ([m_pingJieView.subviews lastObject] != nil)
                    {
                        [(UIView*)[m_pingJieView.subviews lastObject] removeFromSuperview];
                    }
                }

            }

        }
    }
    
    m_pingJieView.hidden = NO;
    self.frame = CGRectMake(0, 0, kWindowW, jisuahei);
}


#pragma mark - 年检提醒
-(void)refreshDataNianJian:(JobBoardDetailModel *)model withZhanHe:(BOOL)zhanHe
{
    self.zhuModel = model.info;
    JobBoardInfoModel *dict = model.info;
    nameLabel.text = dict.name;
    if ([dict.is_urgent boolValue] == YES &&[dict.is_heavy boolValue] == YES ) {
        jingJiImageView.hidden = NO;
        zhongYaoImageView.hidden = NO;
    }else if ([dict.is_urgent boolValue] == YES &&[dict.is_heavy boolValue] == NO ) {
        jingJiImageView.hidden = NO;
        zhongYaoImageView.hidden = YES;
    }else if ([dict.is_urgent boolValue] == NO &&[dict.is_heavy boolValue] == YES ) {
        jingJiImageView.hidden = YES;
        zhongYaoImageView.hidden = NO;
        [zhongYaoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(nameLabel.mas_right).mas_equalTo(6);
        }];
    }else{
        jingJiImageView.hidden = YES;
        zhongYaoImageView.hidden = YES;
    }
    
    if ([dict.status integerValue] == 0) {
        statusLabel.text = @"未处理";
        statusLabel.textColor = kRGBColor(230, 67, 64);
    }else if ([dict.status integerValue] == 1) {
        statusLabel.text = @"已处理";
        statusLabel.textColor = kRGBColor(98, 172, 13);
    }else
    {
        statusLabel.text = @"已过期";
        statusLabel.textColor = kRGBColor(230, 67, 64);
    }
    fuzeRenLabel.text = dict.person_name;
    m_daoQiLabel.text = dict.end_time;
    m_remainLabel.text = dict.unit;
    
    if ([dict.is_urgent boolValue] == YES ) {
        m_remainTupianImageView.hidden = NO;
        m_remainTupianLabel.textColor = [UIColor whiteColor];
    }else{
        m_remainTupianImageView.hidden = YES;
        m_remainTupianLabel.textColor = kRGBColor(74, 74, 74);
        [m_remainTupianLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(m_remainLabel);
            make.right.mas_equalTo(m_remainLabel.mas_left);
            make.width.height.mas_equalTo(30);
        }];
    }
    
    m_remainTupianLabel.text = dict.remain;
    m_pingJieView.hidden = YES;
    
    CGFloat jisuahei  = 276-130;
    
    /**
     task_type 0:客户流失 1:异常工单 2:差评回访 3:预约跟进 4:保养到期 5:保险到期 6:年检提醒 7:生日回访 8:询价追踪
     9:工单回访 10:全部任务
     */

    if([model.info.task_type integerValue] == 6)//年检提醒
    {
        //删除cell的所有子视图
        while ([m_pingJieView.subviews lastObject] != nil)
        {
            [(UIView*)[m_pingJieView.subviews lastObject] removeFromSuperview];
        }
        
        if (model.info.contents.count == 1) {
            m_pingJieView.frame = CGRectMake(0, jisuahei, kWindowW, 40);
            jisuahei += 40;
            for (int i = 0; i<1; i++){
                UILabel *baoZuoLabel = [[UILabel alloc]init];
                baoZuoLabel.font = [UIFont systemFontOfSize:17];
                baoZuoLabel.textColor = kRGBColor(155, 155, 155);
                [m_pingJieView addSubview:baoZuoLabel];
                [baoZuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(i*40);
                    make.height.mas_equalTo(40);
                    make.left.mas_equalTo(9);
                }];
                
                UILabel *baoYouLabel = [[UILabel alloc]init];
                baoYouLabel.font = [UIFont systemFontOfSize:17];
                baoYouLabel.textColor = kRGBColor(74, 74, 74);
                [m_pingJieView addSubview:baoYouLabel];
                [baoYouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(i*40);
                    make.height.mas_equalTo(40);
                    make.right.mas_equalTo(-9);
                }];
                
                NSDictionary *contents = dict.contents[i];
                baoZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"name")];
                baoYouLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents, @"value")];
            }
        }else{
            NSDictionary *contents0 = model.info.contents[0];
            NSDictionary *contents2 = model.info.contents[1];
            UIButton *zhanHeBt = [[UIButton alloc]init];
            [zhanHeBt addTarget:self action:@selector(zhanHeBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
            [zhanHeBt setTitle:@"展开" forState:(UIControlStateNormal)];
            zhanHeBt.selected = zhanHe;
            [zhanHeBt setTitle:@"收起" forState:(UIControlStateSelected)];
            zhanHeBt.titleLabel.font = [UIFont systemFontOfSize:14];
            [zhanHeBt setTitleColor:kRGBColor(155, 155, 155) forState:(UIControlStateNormal)];
            if (zhanHe == NO) {
                m_pingJieView.frame = CGRectMake(0, jisuahei, kWindowW, 176);
                jisuahei += 176;
                
                UILabel *nline = [[UILabel alloc]init];
                nline.backgroundColor = kRGBColor(217, 217, 217);
                [m_pingJieView addSubview:nline];
                [nline mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(10);
                    make.right.mas_equalTo(0);
                    make.top.mas_equalTo(40);
                    make.height.mas_equalTo(1);
                }];
                
                UILabel *baoZuoLabel = [[UILabel alloc]init];
                baoZuoLabel.font = [UIFont systemFontOfSize:17];
                baoZuoLabel.textColor = kRGBColor(155, 155, 155);
                [m_pingJieView addSubview:baoZuoLabel];
                [baoZuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.height.mas_equalTo(40);
                    make.left.mas_equalTo(9);
                }];
                
                UILabel *baoYouLabel = [[UILabel alloc]init];
                baoYouLabel.font = [UIFont systemFontOfSize:17];
                baoYouLabel.textColor = kRGBColor(74, 74, 74);
                [m_pingJieView addSubview:baoYouLabel];
                [baoYouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.height.mas_equalTo(40);
                    make.right.mas_equalTo(-9);
                }];
                baoZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents0, @"name")];
                baoYouLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents0, @"value")];
                
                UILabel *baoZuoLabel2 = [[UILabel alloc]init];
                baoZuoLabel2.font = [UIFont systemFontOfSize:17];
                baoZuoLabel2.textColor = kRGBColor(155, 155, 155);
                [m_pingJieView addSubview:baoZuoLabel2];
                [baoZuoLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(40);
                    make.height.mas_equalTo(40);
                    make.left.mas_equalTo(9);
                }];
                baoZuoLabel2.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents2, @"name")];
                UIView *baoZuoLabel2View = [[UIView alloc]init];
                baoZuoLabel2View.backgroundColor = kRGBColor(243, 246, 255);
                [baoZuoLabel2View.layer setMasksToBounds:YES];
                [baoZuoLabel2View.layer setBorderColor:kRGBColor(217, 217, 217).CGColor];
                [baoZuoLabel2View.layer setBorderWidth:0.5];
                [m_pingJieView addSubview:baoZuoLabel2View];
                [baoZuoLabel2View mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(8);
                    make.right.mas_equalTo(-8);
                    make.top.mas_equalTo(80);
                    make.height.mas_equalTo(80);
                }];
                
                UILabel *huiLine = [[UILabel alloc]init];
                huiLine.backgroundColor = kRGBColor(217, 217, 217);
                [baoZuoLabel2View addSubview:huiLine];
                [huiLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(10);
                    make.right.mas_equalTo(-10);
                    make.top.mas_equalTo(40);
                    make.height.mas_equalTo(1);
                }];
                
                
                NSString * jsonString = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents2, @"value")];
                
                if (jsonString.length>0) {
                    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                     NSDictionary *baoZuoLabelvalue = dic;
                    if ([baoZuoLabelvalue isKindOfClass:[NSDictionary class]]) {
                        UILabel *annualla1 = [[UILabel alloc]init];
                        annualla1.font = [UIFont systemFontOfSize:17];
                        annualla1.textColor = kRGBColor(74, 74, 74);
                        annualla1.text = @"总扣分";
                        [baoZuoLabel2View addSubview:annualla1];
                        [annualla1 mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(10);
                            make.top.mas_equalTo(0);
                            make.height.mas_equalTo(40);
                        }];
                        
                        UILabel *annualla2 = [[UILabel alloc]init];
                        annualla2.font = [UIFont systemFontOfSize:17];
                        annualla2.textColor = kRGBColor(98, 172, 13);
                        annualla2.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(baoZuoLabelvalue, @"total_count")];;
                        [baoZuoLabel2View addSubview:annualla2];
                        [annualla2 mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(annualla1.mas_right).mas_equalTo(5);
                            make.top.mas_equalTo(0);
                            make.height.mas_equalTo(40);
                        }];
                        
                        UILabel *annualla3 = [[UILabel alloc]init];
                        annualla3.font = [UIFont systemFontOfSize:17];
                        annualla3.textColor = kRGBColor(230, 67, 64);
                        annualla3.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(baoZuoLabelvalue, @"fee")];
                        [baoZuoLabel2View addSubview:annualla3];
                        [annualla3 mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.mas_equalTo(-10);
                            make.top.mas_equalTo(0);
                            make.height.mas_equalTo(40);
                        }];
                        
                        UILabel *annualla4 = [[UILabel alloc]init];
                        annualla4.font = [UIFont systemFontOfSize:17];
                        annualla4.textColor = kRGBColor(74, 74, 74);
                        annualla4.text = @"总罚款";;
                        [baoZuoLabel2View addSubview:annualla4];
                        [annualla4 mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.mas_equalTo(annualla3.mas_left).mas_equalTo(-5);
                            make.top.mas_equalTo(0);
                            make.height.mas_equalTo(40);
                        }];
                        
                        [baoZuoLabel2View addSubview:zhanHeBt];
                        [zhanHeBt mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.right.mas_equalTo(0);
                            make.top.mas_equalTo(40);
                            make.height.mas_equalTo(40);
                        }];
                    }
                }
            }else{
                
                CGFloat jsonStringHeight = 0;
                NSString * jsonString = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents2, @"value")];
                
                NSArray *jsonStringArray = [[NSArray alloc]init];
                
                if (jsonString.length>0) {
                    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                    NSDictionary *baoZuoLabelvalue = dic;
                    
                    NSArray *annual_detail = KISDictionaryHaveKey(baoZuoLabelvalue, @"annual_detail");
                    jsonStringArray = annual_detail;
                    if (annual_detail.count>0) {
                        jsonStringHeight += 80;
                        jsonStringHeight += annual_detail.count*80;
                    }
                }
                
                m_pingJieView.frame = CGRectMake(0, jisuahei, kWindowW, 80+jsonStringHeight+13);
                jisuahei += (80+jsonStringHeight+13);
                
                UILabel *nline = [[UILabel alloc]init];
                nline.backgroundColor = kRGBColor(217, 217, 217);
                [m_pingJieView addSubview:nline];
                [nline mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(10);
                    make.right.mas_equalTo(0);
                    make.top.mas_equalTo(40);
                    make.height.mas_equalTo(1);
                }];
                
                UILabel *baoZuoLabel = [[UILabel alloc]init];
                baoZuoLabel.font = [UIFont systemFontOfSize:17];
                baoZuoLabel.textColor = kRGBColor(155, 155, 155);
                [m_pingJieView addSubview:baoZuoLabel];
                [baoZuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.height.mas_equalTo(40);
                    make.left.mas_equalTo(9);
                }];
                
                UILabel *baoYouLabel = [[UILabel alloc]init];
                baoYouLabel.font = [UIFont systemFontOfSize:17];
                baoYouLabel.textColor = kRGBColor(74, 74, 74);
                [m_pingJieView addSubview:baoYouLabel];
                [baoYouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.height.mas_equalTo(40);
                    make.right.mas_equalTo(-9);
                }];
                baoZuoLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents0, @"name")];
                baoYouLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents0, @"value")];
                
                UILabel *baoZuoLabel2 = [[UILabel alloc]init];
                baoZuoLabel2.font = [UIFont systemFontOfSize:17];
                baoZuoLabel2.textColor = kRGBColor(155, 155, 155);
                [m_pingJieView addSubview:baoZuoLabel2];
                [baoZuoLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(40);
                    make.height.mas_equalTo(40);
                    make.left.mas_equalTo(9);
                }];
                baoZuoLabel2.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(contents2, @"name")];
                UIView *baoZuoLabel2View = [[UIView alloc]init];
                baoZuoLabel2View.backgroundColor = kRGBColor(243, 246, 255);
                [baoZuoLabel2View.layer setMasksToBounds:YES];
                [baoZuoLabel2View.layer setBorderColor:kRGBColor(217, 217, 217).CGColor];
                [baoZuoLabel2View.layer setBorderWidth:0.5];
                [m_pingJieView addSubview:baoZuoLabel2View];
                [baoZuoLabel2View mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(8);
                    make.right.mas_equalTo(-8);
                    make.top.mas_equalTo(80);
                    make.height.mas_equalTo(jsonStringHeight);
                }];
                
                if (jsonStringArray.count>0) {
                    for (int i = 0; i<jsonStringArray.count+2; i++) {
                        if (i>0&&i<jsonStringArray.count+2) {
                            UILabel *huiLine = [[UILabel alloc]init];
                            huiLine.backgroundColor = kRGBColor(217, 217, 217);
                            [baoZuoLabel2View addSubview:huiLine];
                            [huiLine mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.left.mas_equalTo(10);
                                make.right.mas_equalTo(-10);
                                make.top.mas_equalTo(40+(i-1)*80);
                                make.height.mas_equalTo(1);
                            }];
                            if (i<jsonStringArray.count+1){
                                UIView *dingweiVi = [[UIView alloc]init];
                                [baoZuoLabel2View addSubview:dingweiVi];
                                [dingweiVi mas_makeConstraints:^(MASConstraintMaker *make) {
                                    make.left.right.mas_equalTo(0);
                                    make.top.mas_equalTo(40+(i-1)*80);
                                    make.height.mas_equalTo(80);
                                }];
                                [self setNianJian:dingweiVi withDict:jsonStringArray[i-1]];
                            }
                            
                        }
                        if (i == 0) {
                            NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                            NSDictionary *baoZuoLabelvalue = dic;
                            if ([baoZuoLabelvalue isKindOfClass:[NSDictionary class]]) {
                                UILabel *annualla1 = [[UILabel alloc]init];
                                annualla1.font = [UIFont systemFontOfSize:17];
                                annualla1.textColor = kRGBColor(74, 74, 74);
                                annualla1.text = @"总扣分";
                                [baoZuoLabel2View addSubview:annualla1];
                                [annualla1 mas_makeConstraints:^(MASConstraintMaker *make) {
                                    make.left.mas_equalTo(10);
                                    make.top.mas_equalTo(0);
                                    make.height.mas_equalTo(40);
                                }];
                                
                                UILabel *annualla2 = [[UILabel alloc]init];
                                annualla2.font = [UIFont systemFontOfSize:17];
                                annualla2.textColor = kRGBColor(98, 172, 13);
                                annualla2.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(baoZuoLabelvalue, @"total_count")];;
                                [baoZuoLabel2View addSubview:annualla2];
                                [annualla2 mas_makeConstraints:^(MASConstraintMaker *make) {
                                    make.left.mas_equalTo(annualla1.mas_right).mas_equalTo(5);
                                    make.top.mas_equalTo(0);
                                    make.height.mas_equalTo(40);
                                }];
                                
                                UILabel *annualla3 = [[UILabel alloc]init];
                                annualla3.font = [UIFont systemFontOfSize:17];
                                annualla3.textColor = kRGBColor(230, 67, 64);
                                annualla3.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(baoZuoLabelvalue, @"fee")];
                                [baoZuoLabel2View addSubview:annualla3];
                                [annualla3 mas_makeConstraints:^(MASConstraintMaker *make) {
                                    make.right.mas_equalTo(-10);
                                    make.top.mas_equalTo(0);
                                    make.height.mas_equalTo(40);
                                }];
                                
                                UILabel *annualla4 = [[UILabel alloc]init];
                                annualla4.font = [UIFont systemFontOfSize:17];
                                annualla4.textColor = kRGBColor(74, 74, 74);
                                annualla4.text = @"总罚款";;
                                [baoZuoLabel2View addSubview:annualla4];
                                [annualla4 mas_makeConstraints:^(MASConstraintMaker *make) {
                                    make.right.mas_equalTo(annualla3.mas_left).mas_equalTo(-5);
                                    make.top.mas_equalTo(0);
                                    make.height.mas_equalTo(40);
                                }];
                                
                                
                            }
                        }else if(i == jsonStringArray.count+1){
                            [baoZuoLabel2View addSubview:zhanHeBt];
                            [zhanHeBt mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.left.right.mas_equalTo(0);
                                make.top.mas_equalTo(jsonStringHeight-40);
                                make.height.mas_equalTo(40);
                            }];
                        }
                    }
                }
                
            }
        }
    }
    m_pingJieView.hidden = NO;
    self.frame = CGRectMake(0, 0, kWindowW, jisuahei);
}
-(void)zhanHeBtChick:(UIButton *)sender
{
    self.nianJianTiXingBlcok();
}

-(void)setNianJian:(UIView *)vi withDict:(NSDictionary *)dict{
    UILabel *dateLabel = [[UILabel alloc]init];
    dateLabel.font = [UIFont systemFontOfSize:14];
    dateLabel.textColor = kRGBColor(74, 74, 74);
    dateLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"time")];
    [vi addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *dateLabel2 = [[UILabel alloc]init];
    dateLabel2.font = [UIFont systemFontOfSize:15];
    dateLabel2.textColor = kRGBColor(74, 74, 74);
    dateLabel2.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"name")];
    [vi addSubview:dateLabel2];
    [dateLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *dateLabel3 = [[UILabel alloc]init];
    dateLabel3.font = [UIFont systemFontOfSize:15];
    dateLabel3.textColor = kRGBColor(74, 74, 74);
    NSString *fee = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"fee")];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"罚款%@元",fee]];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, fee.length)];
    dateLabel3.attributedText = att;
    [vi addSubview:dateLabel3];
    [dateLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *dateLabel4 = [[UILabel alloc]init];
    dateLabel4.font = [UIFont systemFontOfSize:14];
    dateLabel4.textColor = kRGBColor(98, 172, 13);
    dateLabel4.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"count")];
    [vi addSubview:dateLabel4];
    [dateLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(dateLabel3);
        make.right.mas_equalTo(dateLabel3.mas_left).mas_equalTo(-5);
    }];
}

#pragma mark - 差评回访
-(void)setWuKeXing:(NSDictionary *)valueDict withNewView:(UIView *)senderView withxiangshangHeght:(CGFloat)hei
{
    NSInteger stars = [KISDictionaryHaveKey(valueDict, @"com_star") integerValue];
    UIView *headView = [[UIView alloc]init];
    [senderView addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hei);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(25*7);
    }];
    for (int i= 0; i<5; i++) {
        
        
        UIImageView *im = [[UIImageView alloc]init];
        [headView addSubview:im];
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-(10+(15+8)*i));
            make.centerY.mas_equalTo(headView);
            make.width.height.mas_equalTo(15);
        }];
        if (stars == 0) {
            im.image = DJImageNamed(@"boss_detail_xing");
        }else if (stars == 1)
        {
            if (i==4) {
                im.image = DJImageNamed(@"boss_detail_xing_select");
            }else{
                im.image = DJImageNamed(@"boss_detail_xing");
            }
        }else if (stars == 2)
        {
            if (i==4||i==3) {
                im.image = DJImageNamed(@"boss_detail_xing_select");
            }else{
                im.image = DJImageNamed(@"boss_detail_xing");
            }
        }else if (stars == 3)
        {
            if (i==4||i==3 ||i==2 ) {
                im.image = DJImageNamed(@"boss_detail_xing_select");
            }else{
                im.image = DJImageNamed(@"boss_detail_xing");
            }
        }else if (stars == 4)
        {
            if (i==4||i==3 ||i==2 ||i==1) {
                im.image = DJImageNamed(@"boss_detail_xing_select");
            }else{
                im.image = DJImageNamed(@"boss_detail_xing");
            }
        }else{
            im.image = DJImageNamed(@"boss_detail_xing_select");
        }
    }
}
-(void)zuoYouScrollViewBuju:(NSArray *)images withScrllow:(UIScrollView *)scrollView
{
    for (int i = 0; i<images.count; i++) {
        UIImageView *maImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*70, 0, 60, 60)];
        maImageView.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:maImageView];
        [maImageView  sd_setImageWithURL:[NSURL URLWithString:images[i]] placeholderImage:DJImageNamed(@"ic_launcher")];
    }
    scrollView.contentSize = CGSizeMake((images.count)*70, 60);
}

-(void)modileBtChcik:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.zhuModel.person_concat]]];
}

@end
