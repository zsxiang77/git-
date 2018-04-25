//
//  CalenderView.h
//  日历表
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 雷晏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderView : UIView<UIScrollViewDelegate>
{
    UIView *titleView ;
}
@property(nonatomic,strong)UILabel * yearLable;
@property(nonatomic,strong)void (^rilianHidenBlock)(void);
+ (NSDate *)dateFromString:(NSString *)timeStr format:(NSString *)format;
@end
