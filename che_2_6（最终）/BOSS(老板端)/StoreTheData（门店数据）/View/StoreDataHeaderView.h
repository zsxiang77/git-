//
//  StoreDataHeaderView.h
//  cheDianZhang
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreDataHeaderView : UIView
{
    UILabel * line ;
}
@property(nonatomic, copy)void (^viewQieHuan)(NSUInteger shifouxuanzhong);
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *) Array imgArray:(NSArray *)ImgArray selectArray: (NSArray *)selimgArray;
@end
