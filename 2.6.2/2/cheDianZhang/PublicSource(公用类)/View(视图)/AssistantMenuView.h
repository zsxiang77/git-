//
//  AssistantMenuView.h
//  DaJiang365
//
//  Created by 黄鑫 on 16/10/28.
//  Copyright © 2016年 泰宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssistantMenuView : UIView

@property (nonatomic, copy) NSArray *items;
@property (nonatomic, copy) void (^didClickedMenuCallBack)(NSInteger index);

- (void) showMenuView;

@end
