//
//  PopInsuranceListView.h
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopInsuranceListModel;
@interface PopInsuranceListView : UIView

@property(nonatomic, copy) void (^didSecectedCallBack)(NSString *name, NSURL *imageURL);

- (void)showFromModel:(PopInsuranceListModel *)model;

@end
