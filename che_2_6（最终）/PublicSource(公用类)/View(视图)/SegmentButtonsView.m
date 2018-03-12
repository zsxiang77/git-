//
//  SegmentButtonsView.m
//  adult
//
//  Created by shen yan ping on 15/11/6.
//  Copyright (c) 2015年 AiMeng. All rights reserved.
//

#import "SegmentButtonsView.h"
#import "CheDianZhangCommon.h"
#import <UIKit/UIKit.h>

@implementation SegmentButtonsView

- (instancetype)initWithFrame:(CGRect)frame buttonTitles:(NSArray*)buttons
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        NSMutableArray* btns = [[NSMutableArray alloc] init];
        for (int i = 0; i < [buttons count]; i++) {
            UIButton* mySegBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWindowW/[buttons count]*i, 0, kWindowW/[buttons count], CGRectGetHeight(frame))];
            [mySegBtn setTitleColor:kColorWithRGB(51, 51, 51, 1.0) forState:UIControlStateNormal];
            [mySegBtn setTitleColor:kZhuTiColor forState:UIControlStateSelected];
            [mySegBtn setTitle:buttons[i] forState:UIControlStateNormal];
            [mySegBtn setTitle:buttons[i] forState:UIControlStateSelected];
            mySegBtn.backgroundColor = [UIColor clearColor];
            mySegBtn.titleLabel.font = DJSystemFont(15.0);
            mySegBtn.tag = i+1;
            [mySegBtn addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [btns addObject:mySegBtn];
            
            [self addSubview:mySegBtn];
            if (i == 0) {
                mySegBtn.selected = YES;
                self.selectIndex = 0;
            }
        }
        self.buttonArray = btns;
        
        UILabel* line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame)-0.5, CGRectGetWidth(frame), 0.5)];
        line.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
        [self addSubview:line];
        
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame)-1.5, kWindowW/[buttons count], 1.5)];
        self.bottomView.backgroundColor = kZhuTiColor;
        [self addSubview:self.bottomView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame buttonArray:(NSArray*)buttons bottomView:(UIView*)bomView
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
//        UILabel* line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 0.5)];
//        line.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
//        [self addSubview:line];
        
        self.bottomView = bomView;
        self.buttonArray = buttons;
        
        for (UIButton* tempBtn in self.buttonArray) {
            [self addSubview:tempBtn];
        }
        [self addSubview:self.bottomView];
        
        self.selectIndex = 0;
    }
    return self;
}

- (instancetype)initWithFrame2:(CGRect)frame buttonArray:(NSArray*)buttons bottomView:(UIView*)bomView
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel* line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 0.5)];
        line.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [self addSubview:line];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 39, kWindowW, 1)];
        line2.backgroundColor = kLineBgColor;
        [self addSubview:line2];
        
        self.bottomView = bomView;
        self.buttonArray = buttons;
        
        for (UIButton* tempBtn in self.buttonArray) {
            [self addSubview:tempBtn];
        }
        [self addSubview:self.bottomView];
        
        self.selectIndex = 0;
    }
    return self;
    
}


- (void)SGBscrollViewDidEndDecelerating:(NSInteger)page
{
    for(int i = 0; i < [self.buttonArray count]; i++){
        UIButton* btn = [self.buttonArray objectAtIndex:i];
        if (i == page) {
            btn.selected = YES;
            self.selectIndex = page;
            if (self.buttonIndex) {
                self.buttonIndex(page);
            }
        }
        else
            btn.selected = NO;
    }
}
- (void)SGBscrollViewDidScroll2:(UIScrollView *)scrollView
{
    CGPoint offsetofScrollView = scrollView.contentOffset;
    CGRect bottomRect = self.bottomView.frame;
    NSUInteger count = [self.buttonArray count];
    bottomRect.origin.x = ((CGRectGetWidth(self.frame)/count) - CGRectGetWidth(self.bottomView.frame))/2.0 + offsetofScrollView.x/count;//起始x＋
    self.bottomView.frame = bottomRect;
}

- (void)SGBscrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offsetofScrollView = scrollView.contentOffset;
    CGRect bottomRect = self.bottomView.frame;
    NSUInteger count = [self.buttonArray count];
    CGFloat jisuanKuai = (105/2)+35/2+29;
    bottomRect.origin.x = ((CGRectGetWidth(self.frame)/count) - CGRectGetWidth(self.bottomView.frame))/2.0 +(offsetofScrollView.x/kWindowW)*jisuanKuai-8;
//    bottomRect.origin.x = ((CGRectGetWidth(self.frame)/count) - CGRectGetWidth(self.bottomView.frame))/2.0 + offsetofScrollView.x/count;//起始x＋
    self.bottomView.frame = bottomRect;
}
- (void)SGBscrollViewDidScroll3:(UIScrollView *)scrollView
{
    CGPoint offsetofScrollView = scrollView.contentOffset;
    CGRect bottomRect = self.bottomView.frame;
    NSUInteger count = [self.buttonArray count];
//    CGFloat jisuanKuai = (105/2)+35/2+29;
//    bottomRect.origin.x = ((CGRectGetWidth(self.frame)/count) - CGRectGetWidth(self.bottomView.frame))/2.0 +(offsetofScrollView.x/kWindowW)*jisuanKuai-8;
    bottomRect.origin.x = ((CGRectGetWidth(self.frame)/count) - CGRectGetWidth(self.bottomView.frame))/2.0 + offsetofScrollView.x/count;//起始x＋
    self.bottomView.frame = bottomRect;
}

- (void)setButtonSelectedWithIndex:(NSInteger)index
{
    self.selectIndex = index;
    [self SGBscrollViewDidEndDecelerating:index];
    
    CGRect bottomRect = self.bottomView.frame;
    NSUInteger count = [self.buttonArray count];
    bottomRect.origin.x = ((CGRectGetWidth(self.frame)/count) - CGRectGetWidth(self.bottomView.frame))/2.0 + CGRectGetWidth(self.frame)*index/count;//起始x＋
    self.bottomView.frame = bottomRect;
}

- (void)segmentButtonClick:(UIButton*)sender
{
    NSInteger tag = sender.tag-1;
    [self SGBscrollViewDidEndDecelerating:tag];
}
@end
