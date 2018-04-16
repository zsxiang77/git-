//
//  DuplexTableHeardView.h
//  StoryBoardDemo
//
//  Created by shen yan ping on 15/10/30.
//  Copyright © 2015年 寻医问药. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DuplexTableHeardView : UIView

// 是否不接受touch事件 此时点击事件可以下传 YES
@property (nonatomic, assign) BOOL isNoRecieveTouch;
@end
