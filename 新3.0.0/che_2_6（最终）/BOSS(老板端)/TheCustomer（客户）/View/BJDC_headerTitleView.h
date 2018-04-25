//
//  BJDC_headerTitleView.h
//  DaJiang365
//
//  Created by 周岁祥 on 17/3/29.
//  Copyright © 2017年 泰宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJDC_headerTitleView : UIView

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,assign)BOOL shiFouDiGe;

@property(nonatomic, copy)void (^selectFanHui)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs withhasAppointmentBetShow:(NSInteger)has;
- (instancetype)initWithFrameNew:(CGRect)frame childVcs:(NSArray *)childVcs withhasAppointmentBetShow:(NSInteger)has;


/**
 重置title
 */
- (void)reloadTitlesWithNewTitles:(NSArray *)titles;

-(void)qingZhiXuanZHong:(NSInteger)inex;


@end

