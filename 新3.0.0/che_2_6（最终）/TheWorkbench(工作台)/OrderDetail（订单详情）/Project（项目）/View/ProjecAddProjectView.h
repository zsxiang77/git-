//
//  ProjecAddProjectView.h
//  cheDianZhang
//
//  Created by apple on 2018/4/17.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjecAddProjectSanModel.h"

@interface ProjecAddProjectView : UIView<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *xuanView ;
}
@property(nonatomic,strong)NSMutableArray *xuanZhongFanHuiArray;//选中返回数组
@property(nonatomic,strong)UITableView * main_tableView;
@property(nonatomic,strong)NSMutableArray *mainArrary;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSString *mainClass;
@property(nonatomic,strong)void  (^xuanZhongQueDingBlock)(NSArray *xuanZhongFanHuiArray);
//@property(nonatomic,copy)void(^xuanzhongButton)(NSDictionary *NSMutableDictionary BOOL strBoor NSMutableDictionary * zidian);


@property(nonatomic,strong)void (^diSanJiArrayBlcok)(NSMutableDictionary *chuanDict,ProjecAddProjectSanModel *dict);

-(void)showView;
@end
