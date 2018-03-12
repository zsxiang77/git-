//
//  ViewPerfectInformationVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "ViewPerfectInformationModel.h"

@interface ViewPerfectInformationVC : BaseViewController

@property(nonatomic,strong)UITableView  *mainTableView;

@property(nonatomic,strong)NSString *ordercode;

@property(nonatomic,strong)NSDictionary *mainDict;
@property(nonatomic,strong)NSMutableArray *listArray;

- (void)updateUI;

@end


@interface ViewPerfectInformationVC (Net)
-(void)postInspect_detail;

@end
