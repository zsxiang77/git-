//
//  AITBaoGaoListVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "WKWebViewViewController.h"

@interface AITBaoGaoListVC : BaseViewController
@property(nonatomic,strong)UITableView  *main_tabelView;

@property(nonatomic,strong)NSDictionary *mainDataDict;
@property(nonatomic,strong)NSMutableArray *mainAit_list;
@property(nonatomic,strong)NSMutableArray *mainPad_list;

@property(nonatomic,strong)NSString  *ordercode;
@property(nonatomic,strong)NSString  *vin;

@end
