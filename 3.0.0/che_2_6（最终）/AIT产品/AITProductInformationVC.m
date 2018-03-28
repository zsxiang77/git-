//
//  AITProductInformationVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/11/9.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "AITProductInformationVC.h"
#import "SettingAITSerialNumberVC.h"
#import "AITIntroduceViewController.h"
#import "AITListViewController.h"
#import "DetailAITProductsViewController.h"

@interface AITProductInformationVC ()
@property(nonatomic,strong)UILabel *shuoMingLabel;
@property(nonatomic,assign)NSInteger aitNum;
@property(nonatomic,strong)UILabel *gouMaiLabel;
@property(nonatomic,strong)UIImageView *gouImageView;
@property(nonatomic,assign)BOOL   shiFouGouMai;

@end

@implementation AITProductInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"AIT产品信息" withBackButton:YES];
    
    for (int i = 0; i<2; i++) {
        UIView *zhuTiView = [[UIView alloc]initWithFrame:CGRectMake(10, kNavBarHeight+20+(239/2+20)*i, kWindowW-20, 239/2)];
        zhuTiView.backgroundColor = [UIColor whiteColor];
        [zhuTiView.layer setMasksToBounds:YES];
        [zhuTiView.layer setCornerRadius:20];
        [zhuTiView.layer setBorderWidth:0.5];
        [zhuTiView.layer setBorderColor:kRGBColor(217, 217, 217).CGColor];
        [self.view addSubview:zhuTiView];
        
        UIImageView *zuoImageView = [[UIImageView alloc]init];
        [zhuTiView addSubview:zuoImageView];
        [zuoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(zhuTiView);
            make.width.mas_equalTo(136/2);
            make.height.mas_equalTo(121/2);
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.textColor = kRGBColor(74, 74, 74);
        [zhuTiView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(zhuTiView);
        }];
        
        if (i == 0) {
            zuoImageView.image = DJImageNamed(@"AIT_set");
            titleLabel.text = @"已有AIT产品，请设置序列号";
            
            self.shuoMingLabel = [[UILabel alloc]init];
            self.shuoMingLabel.font = [UIFont systemFontOfSize:11];
            self.shuoMingLabel.textColor = kRGBColor(155, 155, 155);
            [zhuTiView addSubview:self.shuoMingLabel];
            [self.shuoMingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(titleLabel.mas_bottom).mas_equalTo(10);
            }];
            
        }else
        {
            zuoImageView.image = DJImageNamed(@"AIT_buy");
            titleLabel.text = @"还没有AIT产品？点击购买";
            self.gouMaiLabel = titleLabel;
            self.gouImageView = zuoImageView;
        }
        
        UIButton *dianJiBt = [[UIButton alloc]init];
        dianJiBt.tag = 200+i;
        [dianJiBt addTarget:self action:@selector(dianJiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [zhuTiView addSubview:dianJiBt];
        [dianJiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
    }
    self.aitNum = 0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"data_center/privateinfo/staff_detail" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        NSDictionary *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        
        weakSelf.aitNum = [KISDictionaryHaveKey(adData, @"ait_num") integerValue];
        NSString *indexAitStr = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(adData, @"ait_num")];
        NSMutableAttributedString* att1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已有设备%@",indexAitStr]];
        [att1 addAttribute:NSForegroundColorAttributeName value:kZhuTiColor range:NSMakeRange(4, indexAitStr.length)];
        weakSelf.shuoMingLabel.attributedText = att1;
        
        if ([KISDictionaryHaveKey(adData, @"can_buy") boolValue] == NO) {
            weakSelf.gouMaiLabel.text = @"已订购AIT产品，点击查看";
            weakSelf.gouImageView.image = DJImageNamed(@"AIT_buy_set");
            weakSelf.shiFouGouMai = YES;
        }else{
            weakSelf.gouMaiLabel.text = @"还没有AIT产品？点击购买";
            weakSelf.gouImageView.image = DJImageNamed(@"AIT_buy");
            weakSelf.shiFouGouMai = NO;
        }
        
    } failure:^(id error) {
        
    }];
}
-(void)dianJiBtChick:(UIButton *)sender
{
    if (sender.tag == 200) {
        if (self.aitNum > 0) {
            AITListViewController *vc = [[AITListViewController alloc]init];
            //            kWeakSelf(weakSelf)
            vc.shuXianNumber = ^(NSInteger sender) {
                
            };
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            SettingAITSerialNumberVC *vc = [[SettingAITSerialNumberVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (sender.tag == 201) {
        if (self.shiFouGouMai == NO) {
            AITIntroduceViewController *vc = [[AITIntroduceViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            DetailAITProductsViewController *vc = [[DetailAITProductsViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


@end
