//
//  JobBoardMenuView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/10.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "JobBoardMenuView.h"
#define kTypeButtonTag (33)

@implementation JobBoardMenuView

@synthesize myDelegate;
@synthesize selectTag;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorWithRGB(70, 70, 70, 0.4);
        
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
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

- (void)selfViewTouch:(id)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        CGPoint _center = self.contentView.center;
        if (_center.y > 0) {//显示状态
            _center.y -= CGRectGetHeight(self.contentView.frame);
        }
        self.contentView.center = _center;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    if (self.myDelegate && [self.myDelegate respondsToSelector:@selector(playTypeCancel:)]) {
        [self.myDelegate playTypeCancel:self];
    }
}
- (void)displayView//显示
{
    [UIView animateWithDuration:0.4 animations:^{
        self.hidden = NO;
        self.alpha = 1.0;
        
        CGPoint _center = self.contentView.center;
        if (_center.y < 0) {//显示状态
            _center.y += CGRectGetHeight(self.contentView.frame);
        }
        self.contentView.center = _center;
    } completion:^(BOOL finished) {
    }];
}


- (void)setMainViewWithArray:(NSArray*)topArray
{
    self.hidden = YES;
    
    self.topButtonArray = topArray;
    NSInteger topButtonCount = [topArray count];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kWindowW,44)];
    self.contentView.backgroundColor = kRGBColor(238, 238, 238);
    [self addSubview:self.contentView];
    for (int t = 0; t < topButtonCount; t++) {
        UIButton* topButton = [[UIButton alloc] initWithFrame:CGRectMake(t*(kWindowW/3), 0, kWindowW/3, 44)];
        topButton.tag = kTypeButtonTag + t;
        [topButton setTitleColor:kRGBColor(74, 74, 74) forState:UIControlStateNormal];
        [topButton setTitleColor:kZhuTiColor forState:UIControlStateSelected];
        [topButton setTitle:[topArray objectAtIndex:t] forState:UIControlStateNormal];
        topButton.titleLabel.font = [UIFont systemFontOfSize:20];
        if (t == selectTag) {
            topButton.selected = YES;
        }
        else
            topButton.selected = NO;
        [topButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:topButton];
    }
}

- (void)pressButton:(UIButton*)switchButton
{
    
    if (switchButton.selected == YES) {
        [self selfViewTouch:nil];//隐藏
    }else{
        for (int i = 0; i<3; i++) {
            UIButton *bt = [self.contentView viewWithTag:i + kTypeButtonTag];
            bt.titleLabel.font = [UIFont systemFontOfSize:20];
            bt.selected = NO;
        }
        
        switchButton.selected = YES;
        switchButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        selectTag = switchButton.tag - kTypeButtonTag;
        
        if (self.myDelegate && [self.myDelegate respondsToSelector:@selector(playTypeSelectWithTag:view:)]) {
            [self.myDelegate playTypeSelectWithTag:selectTag view:self];
        }
        [self selfViewTouch:nil];//隐藏
    }
}

//强制选中某个按钮
- (void)setButtonSelectWithIndex:(NSInteger)selectIndex
{
    for (int i = 0; i<3; i++) {
        UIButton *bt = [self.contentView viewWithTag:i + kTypeButtonTag];
        bt.titleLabel.font = [UIFont systemFontOfSize:20];
        bt.selected = NO;
    }
    
    UIButton* currentBtn = (UIButton*)[self.contentView viewWithTag:kTypeButtonTag + selectIndex];
    currentBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    currentBtn.selected = YES;
    
    selectTag = selectIndex;
    if (self.myDelegate && [self.myDelegate respondsToSelector:@selector(playTypeSelectWithTag:view:)]) {
        [self.myDelegate playTypeSelectWithTag:selectTag view:self];
    }
}

@end
