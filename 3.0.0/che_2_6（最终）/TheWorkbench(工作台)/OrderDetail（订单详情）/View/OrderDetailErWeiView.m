//
//  OrderDetailErWeiView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/1.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "OrderDetailErWeiView.h"
#import "CheDianZhangCommon.h"

@implementation OrderDetailErWeiView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *dingweiView = [[UIView alloc]init];
        dingweiView.frame = CGRectMake(kWindowW-5-281, 45, 281, 284);
        [self addSubview:dingweiView];
        
        UIImageView *imb = [[UIImageView alloc]initWithImage:DJImageNamed(@"orderDetail_erWeiBei")];
        [dingweiView addSubview:imb];
        [imb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        self.erWeiImageView = [[UIImageView alloc]init];
        [dingweiView addSubview:self.erWeiImageView];
        [self.erWeiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(dingweiView);
            make.bottom.mas_equalTo(-50);
            make.width.height.mas_equalTo(187);
        }];
        
        UILabel *shuoMLabel = [[UILabel alloc]init];
        shuoMLabel.font = [UIFont systemFontOfSize:13];
        shuoMLabel.text = @"请提醒客户扫描查看工单详情";
        shuoMLabel.textColor = kRGBColor(74, 74, 74);
        [dingweiView addSubview:shuoMLabel];
        [shuoMLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(dingweiView);
            make.top.mas_equalTo(self.erWeiImageView.mas_bottom).mas_equalTo(5);
        }];
        
        
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(selfViewTouch:)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}


- (void)selfViewTouch:(id)sender
{
    [self yingCangViwe];
}
-(void)yingCangViwe
{
    [UIView animateWithDuration:0.4 animations:^{
//        CGPoint _center = self.center;
//        if (_center.y > 0) {//显示状态
//            _center.y -= CGRectGetHeight(self.frame);
//        }
//        self.center = _center;
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
        
//        CGPoint _center = self.center;
//        if (_center.y < 0) {//显示状态
//            _center.y += CGRectGetHeight(self.frame);
//        }
//        self.center = _center;
    } completion:^(BOOL finished) {
    }];
}

@end
