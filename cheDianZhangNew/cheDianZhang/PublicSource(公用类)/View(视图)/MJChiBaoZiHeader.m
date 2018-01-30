//
//  MJChiBaoZiHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/12.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJChiBaoZiHeader.h"

@implementation MJChiBaoZiHeader
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    
//    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//    NSMutableArray *refreshingImages = [[NSMutableArray alloc]init];
//    for (int i = 1; i<=4; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"xialai_%d", i]];
//        
//        [refreshingImages addObject:image];
//    }
//    
//    [self setImages:refreshingImages forState:MJRefreshStatePulling];
//    
//    // 设置正在刷新状态的动画图片
//    NSMutableArray *refreshingImages2 = [[NSMutableArray alloc]init];
//    for (int i = 1; i<=6; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"jiazai_%d", i]];
//        [refreshingImages2 addObject:image];
//    }
//    
//    [self setImages:refreshingImages2 forState:MJRefreshStateRefreshing];
}

@end
