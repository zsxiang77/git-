//
//  HaoCaiInFormetionView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/30.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HaoCaiInFormetionView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)NSArray *mainArray;

@end
