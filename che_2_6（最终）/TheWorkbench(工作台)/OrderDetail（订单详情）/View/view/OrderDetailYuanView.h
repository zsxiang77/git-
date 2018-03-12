//
//  OrderDetailYuanView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/1.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, STClockWiseType) {
    STClockWiseYes,
    STClockWiseNo
};


@interface OrderDetailYuanView : UIView

-(instancetype)initWithFrame:(CGRect)frame withInde:(CGFloat )index;


@property (assign, nonatomic) CGFloat persentage;
-(void)setupColorLayer;
-(void)setupColorMaskLayer;
-(void)setupBlueMaskLayer;

@end
