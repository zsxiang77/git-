//
//  VersionUpdate.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/19.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VersionUpdate : UIView
{
    UILabel *zhuLabel;
    UIScrollView *zhuScrollView;
}

-(void)setYeMianArray:(NSArray *)array withbanBen:(NSString *)string;

@end
