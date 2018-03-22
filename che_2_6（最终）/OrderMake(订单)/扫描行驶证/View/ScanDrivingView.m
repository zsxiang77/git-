//
//  ScanDrivingView.m
//  cheDianZhang
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "ScanDrivingView.h"

@implementation ScanDrivingView

-(instancetype)init{
    self=[super init];
    if(self){
        self.frame=CGRectMake(0, 0,kWindowW , kWindowH);
        self.alpha=0.5;
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.4);
        view=[[UIView alloc]init];
        view.backgroundColor=[UIColor whiteColor];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(210);
            make.centerY.mas_equalTo(self);
        }];
        
        self.shangLable=[[UILabel alloc]init];
        self.shangLable.text=@"发发发";
       self.shangLable.textAlignment = NSTextAlignmentCenter;
        [view addSubview:self.shangLable];
        [self.shangLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(20);
        }];
        
        UIButton *leftBtn=[[UIButton alloc]init];
        [leftBtn setTitle:@"左边" forState:UIControlStateNormal];
        [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [leftBtn.layer setCornerRadius:10];
        [leftBtn.layer setBorderWidth:1];//设置边界的宽度
        
        [view addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view);
            make.left.mas_equalTo(40);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(100);
        }];
        
        UIButton *rightBtn=[[UIButton alloc]init];
        [rightBtn setTitle:@"左边" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [rightBtn.layer setCornerRadius:10];
        [rightBtn.layer setBorderWidth:1];//设置边界的宽度
        
        [view addSubview:rightBtn];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-40);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(100);
            make.centerY.mas_equalTo(leftBtn);
        }];
        
        UILabel * line=[[UILabel alloc]init];
        line.backgroundColor=[UIColor redColor];
        [view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(leftBtn.mas_bottom).mas_equalTo(20);
        }];
        
        self.xiaLable=[[UILabel alloc]init];
        self.xiaLable.text=@"hfahkahkfhakhf";
        [view addSubview:self.xiaLable];
        [self.xiaLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
        }];
        
        UIButton *xiaBtn=[[UIButton alloc]init];
        [xiaBtn setTitle:@"手动输入"  forState:UIControlStateNormal];
        [xiaBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [view addSubview:xiaBtn];
        [xiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.xiaLable);
            make.left.mas_equalTo(self.xiaLable.mas_right).mas_equalTo(5);
            make.right.mas_equalTo(-10);
        }];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(selfViewTouch:)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}
-(void)yingCangViwe
{
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:view]) {
        return NO;
    }
    return YES;
}

- (void)selfViewTouch:(id)sender
{
    [self yingCangViwe];
}
@end
