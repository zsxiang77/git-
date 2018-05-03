//
//  StoreBottomView.h
//  cheDianZhang
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreBottomView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIView *mainView;
    CGFloat _taberHei;
    UIButton *dianJiShouQibt;
}
@property(nonatomic,strong)UITableView * mainTable;
@property(nonatomic,strong)NSMutableArray *listModelArray;

-(instancetype)initWithFrame:(CGRect)frame withTaberHei:(CGFloat)taberHei;


- (void)show;
- (void)dismiss;
@end
