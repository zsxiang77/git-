//
//  LCBottomDianJiView.m
//  cheDianZhang
//
//  Created by apple on 2018/3/15.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LCBottomDianJiView.h"

@implementation LCBottomDianJiView

-(instancetype)init
{
    if (self = [super init]) {
        chuFaBt = [[UIButton alloc]init];
        chuFaBt.backgroundColor = [UIColor grayColor];
        
        [self addSubview:chuFaBt];
        [chuFaBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        dianJiBt = [[UIButton alloc]init];
        dianJiBt.backgroundColor = [UIColor whiteColor];
        [dianJiBt addTarget:self action:@selector(dianJiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        dianJiBt.hidden =NO;
        [self addSubview:dianJiBt];
        [self bringSubviewToFront:dianJiBt];
        [dianJiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(anzhaunSpenckClick2:)];
        longPress.minimumPressDuration = 10; //定义按的时间
        
        [self addGestureRecognizer:longPress];
    }
    return self;
}

-(void)dianJiBtChick:(UIButton *)sender
{
    dianJiBt.hidden = YES;
}

-(void)anzhaunSpenckClick2:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按开始");
    }else if (sender.state == UIGestureRecognizerStateEnded)
    {
//        self.changanYuyinBtn.backgroundColor=[UIColor whiteColor];
//        
//        NSLog(@"长按结束");
    }
}

@end
