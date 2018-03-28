//
//  UINavigationController+Additions.m
//  cheDianZhang
//
//  Created by sykj on 2018/2/4.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "UINavigationController+Additions.h"

@implementation UINavigationController (Additions)

- (void)popToBeforeViewControllerWithNum:(NSInteger)num animated:(BOOL)animated
{
    [self popToViewController:[self.viewControllers objectAtIndex:self.viewControllers.count - 1 - num] animated:animated];
}
@end
