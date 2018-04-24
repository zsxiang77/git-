//
//  StoreRiLiView.m
//  cheDianZhang
//
//  Created by apple on 2018/4/22.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreRiLiView.h"

@implementation StoreRiLiView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self ==[super initWithFrame:frame])
    {
        self.backgroundColor = kColorWithRGB(0,0,0,0.3);
        self.riliView = [[CalenderView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, 806/2)];
        self.riliView.backgroundColor = [UIColor whiteColor];
        [self.riliView.layer setMasksToBounds:YES];
        [self.riliView.layer setCornerRadius:5];
           kWeakSelf(weakSelf)
        self.riliView.rilianHidenBlock = ^{
            weakSelf.hidden = YES;
        };
        [self addSubview:self.riliView];
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
    if ([touch.view isDescendantOfView:self.riliView]) {
        return NO;
    }
    return YES;
}
-(void)selfViewTouch:(UIButton*)sender
{
    self.hidden = YES;
}
@end
