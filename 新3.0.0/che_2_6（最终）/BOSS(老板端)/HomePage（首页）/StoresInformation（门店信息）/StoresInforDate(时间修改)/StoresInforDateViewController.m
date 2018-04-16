//
//  StoresInforDateViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/12.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoresInforDateViewController.h"
#import "StoresDateYuanView.h"

@interface StoresInforDateViewController ()
{
    StoresDateYuanView *shangDateShiView;
}

@property(nonatomic,strong)UIScrollView *mainScrollView;

@end

@implementation StoresInforDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"营业时间" withBackButton:YES];
    
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight)];
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.contentSize = CGSizeMake(kWindowW, 40+398*2);
    
    UIView *shangView = [[UIView alloc]initWithFrame:CGRectMake((kWindowW-298)/2, 10, 298, 398)];
    shangView.backgroundColor = kRGBColor(242, 242, 242);
    shangView.layer.shadowColor = kRGBColor(123, 123, 123).CGColor;//shadowColor阴影颜色
    shangView.layer.shadowOffset = CGSizeMake(5,5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    shangView.layer.shadowOpacity = 0.5;
    shangView.layer.shadowRadius = 2;// 阴影扩散的范围控制
    shangView.layer.shadowOffset = CGSizeMake(0, 1);// 阴影的范围
    [self.mainScrollView addSubview:shangView];
    
    UILabel *shangTitle = [[UILabel alloc]init];
    shangTitle.text = @"上班时间";
    shangTitle.font = [UIFont boldSystemFontOfSize:17];
    [shangView addSubview:shangTitle];
    [shangTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(shangView);
        make.top.mas_equalTo(4);
    }];
    
    UILabel *shangZhongLabel = [[UILabel alloc]init];
    shangZhongLabel.textColor = [UIColor blackColor];
    shangZhongLabel.text = @":";
    
    shangDateShiView = [[StoresDateYuanView alloc]initWithFrame:CGRectMake(27, 126, 245, 245)];
    shangDateShiView.backgroundColor = [UIColor whiteColor];
    shangDateShiView.layer.shadowColor = kRGBColor(123, 123, 123).CGColor;//shadowColor阴影颜色
    shangDateShiView.layer.shadowOffset = CGSizeMake(5,5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    shangDateShiView.layer.shadowOpacity = 0.5;
    shangDateShiView.layer.shadowRadius = 2;// 阴影扩散的范围控制
    shangDateShiView.layer.shadowOffset = CGSizeMake(0, 1);// 阴影的范围
    [shangDateShiView.layer setCornerRadius:245/2];
    [shangView addSubview:shangDateShiView];
    
}



@end
