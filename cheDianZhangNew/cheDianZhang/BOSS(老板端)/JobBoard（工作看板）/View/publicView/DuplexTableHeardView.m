//
//  DuplexTableHeardView.m
//  StoryBoardDemo
//
//  Created by shen yan ping on 15/10/30.
//  Copyright © 2015年 寻医问药. All rights reserved.
//

#import "DuplexTableHeardView.h"
#import "SegmentButtonsView.h"

@implementation DuplexTableHeardView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (!self.isNoRecieveTouch)
    {
        if (CGRectContainsPoint(self.frame, point))
        {
            return YES;
        }
        return NO;
    }
    else
    {
        for (UIView *subView in self.subviews)
        {
            if (CGRectContainsPoint(subView.frame, point))
            {
                if([subView isKindOfClass:[UIButton class]] || [subView isKindOfClass:[SegmentButtonsView class]])
                    return YES;
            }
        }
        return NO;
    }
}

@end
