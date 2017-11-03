//
//  DuplexTableView.m
//  adult
//
//  Created by shen yan ping on 15/10/30.
//  Copyright (c) 2015年 AiMeng. All rights reserved.
//

#import "DuplexTableView.h"

@implementation DuplexTableView

- (void)buildMainViewWithTabel:(NSArray*)array head:(UIView*)hView visibleHeight:(float)visibalH isHaveDownRefresh:(BOOL)isHaveDown
{
    self.visibleHeight = visibalH;
    self.isHaveDownRefresh = isHaveDown;

    tableArray = [[NSArray alloc] initWithArray:array];
    tableHeader = hView;
    headerRect = tableHeader.frame;
    
    table = tableArray[0];
    
    // 父滚动视图
    _fatherScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _fatherScroll.backgroundColor = [UIColor whiteColor];
    _fatherScroll.contentSize = CGSizeMake(CGRectGetWidth(_fatherScroll.frame)*[array count], CGRectGetHeight(_fatherScroll.frame));
    _fatherScroll.pagingEnabled = YES;
    _fatherScroll.delegate = self;
    _fatherScroll.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < [array count]; i++) {
        [_fatherScroll addSubview:tableArray[i]];
    }

    [self addSubview:_fatherScroll];
}

- (void)buildMainViewWithTabel2:(NSArray*)array head:(UIView*)hView visibleHeight:(float)visibalH isHaveDownRefresh:(BOOL)isHaveDown withView2:(UIView *)addview
{
    self.visibleHeight = visibalH;
    self.isHaveDownRefresh = isHaveDown;
    
    tableArray = [[NSArray alloc] initWithArray:array];
    tableHeader = hView;
    headerRect = tableHeader.frame;
    
    table = tableArray[0];
    
    // 父滚动视图
    _fatherScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _fatherScroll.backgroundColor = [UIColor whiteColor];
    _fatherScroll.contentSize = CGSizeMake(CGRectGetWidth(_fatherScroll.frame)*[array count], CGRectGetHeight(_fatherScroll.frame));
    _fatherScroll.pagingEnabled = YES;
    _fatherScroll.delegate = self;
    _fatherScroll.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < [array count]; i++) {
        [_fatherScroll addSubview:tableArray[i]];
    }
    [_fatherScroll addSubview:addview];
    [self addSubview:_fatherScroll];
}

#pragma mark - scrollview（滚动视图）协议
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _fatherScroll) {
        int page = (_fatherScroll.contentOffset.x) / CGRectGetWidth(_fatherScroll.frame);
        if([self.myDelegate respondsToSelector:@selector(tableChangedToIndex:)]){
            [self.myDelegate tableChangedToIndex:page];
        }
    }
}

- (void)setFatherScrollToIndex:(NSInteger)index
{
    
    
    
    if (index < 0) {
        return;
    }
    [_fatherScroll scrollRectToVisible:CGRectMake(index*CGRectGetWidth(_fatherScroll.frame), _fatherScroll.contentOffset.y, CGRectGetWidth(_fatherScroll.frame), CGRectGetHeight(_fatherScroll.frame)) animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _fatherScroll)
    {
        // 重新选择表格
        [self reselectTable];
     
        if([self.myDelegate respondsToSelector:@selector(fatherScrollViewDidScroll:)]){
            [self.myDelegate fatherScrollViewDidScroll:_fatherScroll];
        }
    }
}

- (void)tableViewDidScroll:(UIScrollView *)scrollView
{
    [self dragTable];    
}
// 重新选择表格
- (void)reselectTable
{
    // headerview的高减去可见高度
    CGFloat headerHeight = CGRectGetHeight(headerRect)-self.visibleHeight;
    // 所有表格将要设置的contentoffset
    CGFloat moveOffsetY = table.contentOffset.y >= headerHeight ? headerHeight : table.contentOffset.y;
    // 记录改动后的表格，等循环结束后才赋给全局的table
    UITableView *tmpTableView = nil;
    NSInteger tableCount = [tableArray count];
    for (int i = 0; i < tableCount; i++)
    {
        UITableView *tmpTable = [tableArray objectAtIndex:i];
        
//        if (tmpTable != table && moveOffsetY >= 0)
        if (moveOffsetY >= 0)
        {
            if (isTrag)
            {// 如果拖动了表格则将其他所有的表格置为记录table的offset
                tmpTable.contentOffset = CGPointMake(0, moveOffsetY);
            }
            else
            {
                if (tmpTable.contentOffset.y <= headerHeight)
                {// 如果表格的contentoffset的y值小于headerview的高减去可见高度
                    tmpTable.contentOffset = CGPointMake(0, moveOffsetY);
                }
            }
        }
        
        if (_fatherScroll.contentOffset.x >= i*CGRectGetWidth(_fatherScroll.frame) && _fatherScroll.contentOffset.x < (i+1)*CGRectGetWidth(_fatherScroll.frame))
        {
            tmpTableView = tmpTable;
        }
    }
    if (tmpTableView != nil)
    {
        if (tmpTableView != table)
        {
            table = tmpTableView;
            // 改变记录的table后将记录是否拖动表格的变量置为NO
            isTrag = NO;
        }
    }
}

// 拖动表格
- (void)dragTable
{
    isTrag = YES;
    
    CGRect rect = headerRect;
    // headerview的高减去可见高度
    CGFloat headerHeight = CGRectGetHeight(rect)-self.visibleHeight;
    
    // 三种情况：1.表格的contentOffset在（0-headerview的高减去可见高度之间，两端都不包括）；2.表格的contentOffset大于等于headerview的高减去可见高度；3.表格的contentOffset小于等于0
    if (table.contentOffset.y < headerHeight && table.contentOffset.y > 0)
    {// 如果表格的contentoffset的y值在｛0-headerview的高减去可见高度之间｝
        rect.origin.y -= table.contentOffset.y;
        tableHeader.frame = rect;
    }
    else if (table.contentOffset.y >= headerHeight)
    {// 如果表格的contentoffset的y值大于headerview的高减去可见高度
        if (CGRectGetMinY(tableHeader.frame) > -headerHeight)
        {
            rect.origin.y -= headerHeight;
            tableHeader.frame = rect;
        }
    }
    else if (table.contentOffset.y <= 0)
    {
        // 如果表格的contentoffset的y值小于0
        // heard与table连接一起 无单独下拉刷新
        if (self.isHaveDownRefresh) {
            CGFloat minY = CGRectGetMinY(rect);
            //含表格下拉刷新
            if (CGRectGetMinY(tableHeader.frame) < minY)
            {
                rect.origin.y = minY;
                tableHeader.frame = rect;
            }
        }
        else{
            rect.origin.y -= table.contentOffset.y;
            tableHeader.frame = rect;
        }
        
        
    }
}


@end
