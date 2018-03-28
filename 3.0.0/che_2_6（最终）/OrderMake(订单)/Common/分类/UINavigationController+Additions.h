//
//  UINavigationController+Additions.h
//  cheDianZhang
//
//  Created by sykj on 2018/2/4.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Additions)
/**
 pop到前几个页面
 */
- (void)popToBeforeViewControllerWithNum:(NSInteger)num animated:(BOOL)animated;
@end
