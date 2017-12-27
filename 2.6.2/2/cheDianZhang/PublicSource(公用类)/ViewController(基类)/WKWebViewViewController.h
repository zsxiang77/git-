//
//  WKWebViewViewController.h
//  DaJiang365
//
//  Created by 周岁祥 on 2017/7/5.
//  Copyright © 2017年 泰宇. All rights reserved.
//

#import "BaseViewController.h"

@interface WKWebViewViewController : BaseViewController
@property(nonatomic, assign)BOOL isNoShowNavBar;//显示导航栏
@property(nonatomic, retain)NSString* webUrl;//加载地址
@property(nonatomic, retain)NSString* navTitle;//标题

@property(nonatomic,strong)UIButton *guanBiBt;

@property(nonatomic,strong)NSString *wenAnName;

@property(nonatomic,strong)NSData  *chuanData;
@end
