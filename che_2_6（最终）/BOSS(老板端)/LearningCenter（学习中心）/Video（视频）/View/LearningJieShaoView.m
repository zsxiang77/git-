//
//  LearningJieShaoView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/4/27.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningJieShaoView.h"

@implementation LearningJieShaoView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        mainView = [[UIView alloc]initWithFrame:CGRectMake(0, kWindowH-300, kWindowW, 300)];
        mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:mainView];
        
        headerLabel = [[UILabel alloc]init];
        headerLabel.textColor = kRGBColor(74, 74, 74);
        headerLabel.font = [UIFont systemFontOfSize:20];
        headerLabel.textAlignment = NSTextAlignmentCenter;
        [mainView addSubview:headerLabel];
        [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [mainView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(44);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        contentLabel = [[UILabel alloc]init];
        contentLabel.textColor = kRGBColor(74, 74, 74);
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:14];
        [mainView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.left.mas_equalTo(10);
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:mainView]) {
        return NO;
    }
    return YES;
}
-(void)selfViewTouch:(UIButton*)sender
{
    [self dismiss];
}

-(void)shuanXinDataWithTitle:(NSString *)title WithContent:(NSString *)content
{
    headerLabel.text = title;
    contentLabel.text = content;
    [self show];
}
//弹入视图
- (void)show
{
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    }];
}

//弹出视图
- (void)dismiss
{
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.bounds.size.width, self.bounds.size.height);
    }];
}
@end
