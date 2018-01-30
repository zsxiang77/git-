//
//  ProjectDetailsChooseView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/22.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectDetailsChooseView : UIView<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *fenLeiArray;
}
@property(nonatomic,strong)UITableView *main_tableView;

@property(nonatomic,strong)void (^fenLeiBlcok)(NSString *str);

@end
