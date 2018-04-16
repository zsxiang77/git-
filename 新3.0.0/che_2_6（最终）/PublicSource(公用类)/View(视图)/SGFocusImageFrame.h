//
//  SGFocusImageFrame.h
//  ScrollViewLoop
//
//  Created by chen yueqing on 14-10-21.
//  Copyright (c) 2014年 Chinasofti. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SGFocusImageFrame;

#pragma mark - SGFocusImageFrameDelegate
@protocol SGFocusImageFrameDelegate <NSObject>
@optional
//item从1开始
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(NSInteger)item;
@end


@interface SGFocusImageFrame : UIView <UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    UILabel *youLabel;
    NSArray *titleArrays;
}

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate imageItems:(NSArray *)items isAuto:(BOOL)isAuto placeHolderImage:(UIImage*)holdImg pageSize:(float)pageSize withTiTle:(NSArray *)titles;

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate focusImageItems:(NSString *)items, ... NS_REQUIRES_NIL_TERMINATION;


@property (nonatomic, assign) id<SGFocusImageFrameDelegate> delegate;

//***定时器
@property (nonatomic, retain) NSTimer *timer;

@end
