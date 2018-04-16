//
//  OrderSectionHeaderView.h
//  测试
//
//  Created by lcc on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderSectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) UILabel *titleLB;
-(void)bingViewModel:(id)viewModel;
@end
