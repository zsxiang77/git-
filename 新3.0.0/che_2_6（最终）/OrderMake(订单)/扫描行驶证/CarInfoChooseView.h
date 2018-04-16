//
//  CarInfoChooseView.h
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CarInfoChooseViewStyle) {
    CarInfoChooseViewStyleNoData,
    CarInfoChooseViewStyleList,
    CarInfoChooseViewStyleManual,
};

@interface CarInfoChooseView : UIView

@property (nonatomic, assign) CarInfoChooseViewStyle style;
@property (nonatomic, strong) NSString *manualChooseText;
/** 不同样式下的总高度 */
@property (nonatomic, assign) CGFloat currHeight;
@property (nonatomic, strong, readonly) UITableView *tableView;

@property(nonatomic, copy) void (^didChooseCarButtonCallBack)(void);
@end
