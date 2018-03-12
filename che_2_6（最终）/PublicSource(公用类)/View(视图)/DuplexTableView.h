//
//  DuplexTableView.h
//  adult
//
//  Created by shen yan ping on 15/10/30.
//  Copyright (c) 2015年 AiMeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DuplexTableDelegate <NSObject>
//横向切换
@optional
- (void)tableChangedToIndex:(NSInteger)index;
- (void)fatherScrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface DuplexTableView : UIView<UIScrollViewDelegate>
{
    // 头视图frame
    CGRect headerRect;
    
    // 头和滚动视图
    UIView       *tableHeader;
    
    // 滚动视图
    NSArray *tableArray;
    
    // 记录当前可见的表格
    UITableView *table;
    // 记录是否拖动了table
    BOOL isTrag;
}

@property (nonatomic, assign) id<DuplexTableDelegate> myDelegate;
@property (nonatomic, assign) CGFloat visibleHeight;
@property (nonatomic, retain) UIScrollView *fatherScroll;// 父滚动视图

@property (nonatomic, assign) BOOL isHaveDownRefresh;//是否头部和表格不能分离（即是否保留下拉刷新功能）

- (void)buildMainViewWithTabel:(NSArray*)array head:(UIView*)hView visibleHeight:(float)visibalH isHaveDownRefresh:(BOOL)isHaveDown;
- (void)buildMainViewWithTabel2:(NSArray*)array head:(UIView*)hView visibleHeight:(float)visibalH isHaveDownRefresh:(BOOL)isHaveDown withView2:(UIView *)addview;
//底部table滑动
- (void)tableViewDidScroll:(UIScrollView *)scrollView;
//segment切换
- (void)setFatherScrollToIndex:(NSInteger)index;

@end
