//
//  BJDC_headerTitleView.m
//  DaJiang365
//
//  Created by 周岁祥 on 17/3/29.
//  Copyright © 2017年 泰宇. All rights reserved.
//

#import "BJDC_headerTitleView.h"
#import "BOSSCheDianZhangCommon.h"
@interface BJDC_headerTitleView ()


@end

@implementation BJDC_headerTitleView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs withhasAppointmentBetShow:(NSInteger)has{
    if (self = [super initWithFrame:frame]) {
        CGFloat anNIuWight = kWindowW/5;
        for (int i = 0; i<childVcs.count; i++) {
            NSDictionary *dict = childVcs[i];
            
            UIView *dingweiView = [[UIView alloc]initWithFrame:CGRectMake(i*anNIuWight, 0, anNIuWight, 61)];
            dingweiView.tag = 500+i;
            [self addSubview:dingweiView];
            UILabel *shangLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, anNIuWight, 25)];
            shangLabel.font = [UIFont systemFontOfSize:12];
            shangLabel.textAlignment = NSTextAlignmentCenter;
            shangLabel.tag = 100;
            shangLabel.text = KISDictionaryHaveKey(dict, @"shang");
            [dingweiView addSubview:shangLabel];
            
            UILabel *xiaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, anNIuWight, 25)];
            xiaLabel.font = [UIFont systemFontOfSize:12];
            xiaLabel.textAlignment = NSTextAlignmentCenter;
            xiaLabel.tag = 200;
            xiaLabel.text = KISDictionaryHaveKey(dict, @"xia");
            [dingweiView addSubview:xiaLabel];
            
            UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 53, anNIuWight, 2)];
            line.backgroundColor = kZhuTiColor;
            line.hidden = YES;
            line.tag = 300;
            [dingweiView addSubview:line];
            
            UIButton *dingweiBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, anNIuWight, 55)];
            dingweiBt.tag = 600+i;
            [dingweiBt addTarget:self action:@selector(dingweiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
            [dingweiView addSubview:dingweiBt];
            if (i == 0) {
                shangLabel.textColor = kZhuTiColor;
                xiaLabel.textColor = kZhuTiColor;
                line.hidden = NO;
            }
        }
    }
    return self;
}

-(void)dingweiBtChick:(UIButton *)sender
{
    for (int i = 0; i<6; i++) {
        UIView *dingweiView = [self viewWithTag:500+i];
        UILabel *shangLabel = [dingweiView viewWithTag:100];
        shangLabel.textColor = kRGBColor(74, 74, 74);
        UILabel *xiaLabel = [dingweiView viewWithTag:200];
        xiaLabel.textColor = kRGBColor(155, 155, 155);
        UILabel *line = [dingweiView viewWithTag:300];
        line.hidden = YES;
    }
    
    NSInteger xuanzhong = sender.tag - 600;
    UIView *dingweiView2 = [self viewWithTag:500+xuanzhong];
    UILabel *shangLabel = [dingweiView2 viewWithTag:100];
    shangLabel.textColor = kZhuTiColor;
    UILabel *xiaLabel = [dingweiView2 viewWithTag:200];
    xiaLabel.textColor = kZhuTiColor;
    UILabel *line = [dingweiView2 viewWithTag:300];
    line.hidden = NO;
    self.selectIndex = xuanzhong;
    self.selectFanHui(xuanzhong);
}

-(void)qingZhiXuanZHong:(NSInteger)inex
{
    for (int i = 0; i<6; i++) {
        UIView *dingweiView = [self viewWithTag:500+i];
        UILabel *shangLabel = [dingweiView viewWithTag:100];
        shangLabel.textColor = kRGBColor(74, 74, 74);
        UILabel *xiaLabel = [dingweiView viewWithTag:200];
        xiaLabel.textColor = kRGBColor(155, 155, 155);
        UILabel *line = [dingweiView viewWithTag:300];
        line.hidden = YES;
    }
    NSInteger xuanzhong = inex;
    UIView *dingweiView2 = [self viewWithTag:500+xuanzhong];
    UILabel *shangLabel = [dingweiView2 viewWithTag:100];
    shangLabel.textColor = kZhuTiColor;
    UILabel *xiaLabel = [dingweiView2 viewWithTag:200];
    xiaLabel.textColor = kZhuTiColor;
    UILabel *line = [dingweiView2 viewWithTag:300];
    line.hidden = NO;
    self.selectIndex = xuanzhong;
}


#pragma mark - public helper
- (void)reloadTitlesWithNewTitles:(NSArray *)titles
{
    for (int i = 0; i<6; i++) {
        UIView *dingweiView = [self viewWithTag:500+i];
        UILabel *xiaLabel = [dingweiView viewWithTag:200];
        xiaLabel.text = titles[i];
    }
}



@end
