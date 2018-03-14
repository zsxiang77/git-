//
//  LCMessageListView.h
//  测试
//
//  Created by lcc on 2018/1/30.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "LCMessageViewModel.h"

@interface LCMessageListViewCell : BaseTableViewCell

@end

@interface LCMessageListView : UIView
- (void)addMessageViewModels:(NSArray <LCMessageViewModel *>*)dataArr;
- (void)addMessageViewModel:(LCMessageViewModel *)vmodel;

@property (nonatomic, strong) UIView *header;
@end
