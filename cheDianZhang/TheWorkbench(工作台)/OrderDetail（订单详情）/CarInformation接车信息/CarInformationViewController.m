//
//  CarInformationViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/27.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "CarInformationViewController.h"
#import "UIImageView+WebCache.h"
#import "PreviewPictureViewController.h"
#import "CarInspectionModel.h"

@interface CarInformationViewController ()

@property(nonatomic,strong)UIScrollView *mainSrollView;

@property(nonatomic,strong)NSArray *functions;

@property(nonatomic,strong)NSString *gas;
@property(nonatomic,strong)NSArray *goods;

@property(nonatomic,strong)NSString *goods_remark;
@property(nonatomic,strong)NSArray *image_info_sum;
@property(nonatomic,strong)NSArray *images;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)NSString *repairmile;

@end

@implementation CarInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"接车信息" withBackButton:YES];
    self.mainSrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavBarHeight,kWindowW, kWindowH-kNavBarHeight)];
    [self.view addSubview:self.mainSrollView];
    [self postrequest_methodData];
}

-(void)postrequest_methodData{
    
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:self.ordercode forKey:@"ordercode"];
    [self showOrHideLoadView:YES];
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@order/repair_order/inspect_info",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self showOrHideLoadView:NO];
        NSData *responseData = responseObject;
        NSData *filData = responseData;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"n返回：%@",parserDict);
        
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [NetWorkManager loginAgain:self];
            return;
        }
        
        NSDictionary *adData = kParseData(responseObject);
        
        if ([KISDictionaryHaveKey(responseObject, @"code") integerValue]!=200) {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return ;
        }else
        {
            NSDictionary *info = KISDictionaryHaveKey(adData, @"info");
            weakSelf.functions = KISDictionaryHaveKey(info, @"functions");
            weakSelf.gas = KISDictionaryHaveKey(info, @"gas");
            weakSelf.goods = KISDictionaryHaveKey(info, @"goods");
            weakSelf.goods_remark = KISDictionaryHaveKey(info, @"goods_remark");
            weakSelf.image_info_sum = KISDictionaryHaveKey(info, @"image_info_sum");
            weakSelf.images = KISDictionaryHaveKey(info, @"images");
            weakSelf.remark = KISDictionaryHaveKey(info, @"remark");
            weakSelf.repairmile = KISDictionaryHaveKey(info, @"repairmile");
            
            [weakSelf bujuSrollView];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showOrHideLoadView:NO];
    }];
    
}

-(void)bujuSrollView
{
    CGFloat gunHeight = 0;
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, gunHeight, kWindowW, 50)];
    view1.backgroundColor = [UIColor whiteColor];
    gunHeight += 50;
    [self.mainSrollView addSubview:view1];
    
    UIImageView *view1ImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"Group 10")];
    [view1 addSubview:view1ImageView];
    [view1ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(view1);
        make.width.height.mas_equalTo(35);
    }];
    
    UILabel *view1Label = [[UILabel alloc]init];
    view1Label.font = [UIFont systemFontOfSize:13];
    [view1 addSubview:view1Label];
    [view1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view1ImageView.mas_right).mas_equalTo(5);
        make.centerY.mas_equalTo(view1);
    }];
    if (self.images.count>0) {
        view1Label.text = [NSString stringWithFormat:@"车辆外观检查（%ld）",(unsigned long)self.images.count];
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, gunHeight, kWindowW, 130)];
        view2.backgroundColor = [UIColor whiteColor];
        gunHeight += 130;
        [self.mainSrollView addSubview:view2];
        
        UIScrollView *imagesScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, kWindowW, 100)];
        [view2 addSubview:imagesScrollView];
        
        CGFloat dingWeiX = 0;
        
        for (int i = 0;i<self.images.count ; i++) {
            NSDictionary *describe = KISDictionaryHaveKey(self.images[i], @"describe");
            
            UIView *dingView = [[UIView alloc]initWithFrame:CGRectMake(dingWeiX, 0, 100, 100)];
            dingWeiX += 100;
            [imagesScrollView addSubview:dingView];
            
            UIImageView *imagesImageView = [[UIImageView alloc]init];
            [imagesImageView  sd_setImageWithURL:[NSURL URLWithString:KISDictionaryHaveKey(self.images[i], @"images")] placeholderImage:DJImageNamed(@"xiangMuBack")];
            [dingView addSubview:imagesImageView];
            [imagesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(10);
                make.centerX.mas_equalTo(dingView);
                make.width.height.mas_equalTo(60);
            }];
            
            UIButton *imagesButton = [[UIButton alloc]init];
            [imagesButton addTarget:self action:@selector(imagesButtonChick:) forControlEvents:(UIControlEventTouchUpInside)];
            imagesButton.tag = 2000+i;
            [dingView addSubview:imagesButton];
            [imagesButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(10);
                make.centerX.mas_equalTo(dingView);
                make.width.height.mas_equalTo(60);
            }];
            
            UILabel *describeLabel = [[UILabel alloc]init];
            describeLabel.font = [UIFont systemFontOfSize:13];
            describeLabel.text =  KISDictionaryHaveKey(describe,@"Direction");
            describeLabel.textColor = [UIColor grayColor];
            [dingView addSubview:describeLabel];
            [describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(imagesImageView.mas_bottom).mas_equalTo(5);
                make.centerX.mas_equalTo(dingView);
            }];
            
            
        }
        imagesScrollView.contentSize = CGSizeMake(dingWeiX+100, 100);
        
        
        NSMutableArray *wentArray = [[NSMutableArray alloc]init];
        NSDictionary *image_info_sumDict = self.image_info_sum[0];
        if ([KISDictionaryHaveKey(image_info_sumDict, @"AX") integerValue]>0) {
            [wentArray addObject:[NSString stringWithFormat:@"凹陷(%@)",KISDictionaryHaveKey(image_info_sumDict, @"AX")]];
        }
        
        if ([KISDictionaryHaveKey(image_info_sumDict, @"DQ") integerValue]>0) {
            [wentArray addObject:[NSString stringWithFormat:@"掉漆(%@)",KISDictionaryHaveKey(image_info_sumDict, @"DQ")]];
        }
        
        if ([KISDictionaryHaveKey(image_info_sumDict, @"GH") integerValue]>0) {
            [wentArray addObject:[NSString stringWithFormat:@"刮痕(%@)",KISDictionaryHaveKey(image_info_sumDict, @"GH")]];
        }
        
        if ([KISDictionaryHaveKey(image_info_sumDict, @"LW") integerValue]>0) {
            [wentArray addObject:[NSString stringWithFormat:@"裂纹(%@)",KISDictionaryHaveKey(image_info_sumDict, @"LW")]];
        }
        
        if ([KISDictionaryHaveKey(image_info_sumDict, @"PS") integerValue]>0) {
            [wentArray addObject:[NSString stringWithFormat:@"破损(%@)",KISDictionaryHaveKey(image_info_sumDict, @"PS")]];
        }
        
        if ([KISDictionaryHaveKey(image_info_sumDict, @"XS") integerValue]>0) {
            [wentArray addObject:[NSString stringWithFormat:@"锈蚀(%@)",KISDictionaryHaveKey(image_info_sumDict, @"XS")]];
        }
        
        
        UIView *view2View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 30)];
        view2View.backgroundColor = [UIColor whiteColor];
        [view2 addSubview:view2View];
        for (int i = 0; i<wentArray.count; i++) {
            UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(65*i+5, 3, 60, 25)];
            la.font = [UIFont systemFontOfSize:13];
            la.textAlignment = NSTextAlignmentCenter;
            la.backgroundColor = kRGBColor(226, 231, 245);
            la.textColor = [UIColor blackColor];
            la.text = wentArray[i];
            [la.layer setMasksToBounds:YES];
            [la.layer setCornerRadius:25/2];
            [view2View addSubview:la];
        }
    }else
    {
        view1Label.text = @"车辆外观检查";
        
        UILabel *view1Label2 = [[UILabel alloc]init];
        view1Label2.font = [UIFont systemFontOfSize:13];
        view1Label2.text = @"无";
        view1Label2.textColor = [UIColor redColor];
        [view1 addSubview:view1Label2];
        [view1Label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(view1);
        }];
    }
    
//    随车装备
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, gunHeight+10, kWindowW, 60)];
    view3.backgroundColor = [UIColor whiteColor];
    gunHeight += 80;
    [self.mainSrollView addSubview:view3];
    UIImageView *view3ImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"Group 113")];
    [view3 addSubview:view3ImageView];
    [view3ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(view3);
        make.width.height.mas_equalTo(35);
    }];
    
    UILabel *view3NameLa = [[UILabel alloc]init];
    view3NameLa.font = [UIFont systemFontOfSize:13];
    view3NameLa.text = @"随车装备";
    [view3 addSubview:view3NameLa];
    [view3NameLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view3ImageView.mas_right).mas_equalTo(5);
        make.top.mas_equalTo(view3ImageView);
    }];
    
    UILabel *view3BeiZhuLa = [[UILabel alloc]init];
    view3BeiZhuLa.font = [UIFont systemFontOfSize:12];
    view3BeiZhuLa.text = [NSString stringWithFormat:@"备注 %@",self.goods_remark];
    [view3 addSubview:view3BeiZhuLa];
    [view3BeiZhuLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view3ImageView.mas_right).mas_equalTo(5);
        make.bottom.mas_equalTo(view3ImageView);
    }];
    
    NSMutableArray *newGoods = [[NSMutableArray alloc]init];
    for (int i = 0; i<self.goods.count; i++) {
        if ([KISDictionaryHaveKey(self.goods[i], @"bool") boolValue]) {
            [newGoods addObject:self.goods[i]];
        }
    }
    
    if (newGoods.count >0) {
        
        
        UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(0, gunHeight-10, kWindowW, (newGoods.count/4+1)*30)];
        view4.backgroundColor = [UIColor whiteColor];
        gunHeight +=  ((newGoods.count/4+1)*30);
        [self.mainSrollView addSubview:view4];
        
        for (int i = 0; i<newGoods.count; i++) {
            UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake((kWindowW/4)*(i%4)+5, 5+(30*(i/4)), kWindowW/4-10, 25)];
            la.adjustsFontSizeToFitWidth = YES;
            la.font = [UIFont systemFontOfSize:13];
            la.backgroundColor = kNavBarColor;
            la.textColor = [UIColor whiteColor];
            la.textAlignment = NSTextAlignmentCenter;
            [la.layer setMasksToBounds:YES];
            [la.layer setCornerRadius:3];
            la.text = KISDictionaryHaveKey(newGoods[i], @"name");
            [view4 addSubview:la];
        }
    }else
    {
        UILabel *view3StateLa = [[UILabel alloc]init];
        view3StateLa.font = [UIFont systemFontOfSize:13];
        view3StateLa.textColor = [UIColor redColor];
        view3StateLa.text = @"无";
        [view3 addSubview:view3StateLa];
        [view3StateLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(view3);
        }];
    }
    
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(0, gunHeight, kWindowW, 60)];
    view5.backgroundColor = [UIColor whiteColor];
    gunHeight +=  70;
    [self.mainSrollView addSubview:view5];
    
    UIImageView *view5ImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"Group 124")];
    [view5 addSubview:view5ImageView];
    [view5ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(view5);
        make.width.height.mas_equalTo(30);
    }];
    
    UILabel *view5Label = [[UILabel alloc]init];
    view5Label.font = [UIFont systemFontOfSize:13];
    view5Label.text = @"功能信息";
    [view5 addSubview:view5Label];
    [view5Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view5ImageView.mas_right).mas_equalTo(5);
        make.centerY.mas_equalTo(view5);
    }];
    
    NSMutableArray *functionsGoods = [[NSMutableArray alloc]init];
    for (int i = 0; i<self.functions.count; i++) {
        if ([KISDictionaryHaveKey(self.functions[i], @"bool") boolValue]) {
            [functionsGoods addObject:self.functions[i]];
        }
    }
    
    if (functionsGoods.count >0) {
        
        
        UIView *view6 = [[UIView alloc]initWithFrame:CGRectMake(0, gunHeight-10, kWindowW, functionsGoods.count*30)];
        view6.backgroundColor = [UIColor whiteColor];
        gunHeight +=  functionsGoods.count*30;
        [self.mainSrollView addSubview:view6];
        
        for (int i = 0; i<functionsGoods.count; i++) {
            UILabel *la1 = [[UILabel alloc]initWithFrame:CGRectMake(10, i*30, kWindowW/2, 30)];
            la1.adjustsFontSizeToFitWidth = YES;
            la1.font = [UIFont systemFontOfSize:13];
            la1.textAlignment = NSTextAlignmentLeft;
            la1.text = KISDictionaryHaveKey(functionsGoods[i], @"name");
            [view6 addSubview:la1];
            UILabel *la2 = [[UILabel alloc]initWithFrame:CGRectMake(kWindowW/2, i*30, kWindowW/2-20, 30)];
            la2.textColor = [UIColor redColor];
            la2.adjustsFontSizeToFitWidth = YES;
            la2.font = [UIFont systemFontOfSize:13];
            la2.textAlignment = NSTextAlignmentRight;
            la2.text = KISDictionaryHaveKey(functionsGoods[i], @"result");
            [view6 addSubview:la2];
        }
    }else
    {
        UILabel *view5StateLa = [[UILabel alloc]init];
        view5StateLa.font = [UIFont systemFontOfSize:13];
        view5StateLa.textColor = [UIColor greenColor];
        view5StateLa.text = @"正常";
        [view5 addSubview:view5StateLa];
        [view5StateLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(view5);
        }];
    }
    
    
    UIView *view7 = [[UIView alloc]initWithFrame:CGRectMake(0, gunHeight, kWindowW, 60)];
    view7.backgroundColor = [UIColor whiteColor];
    gunHeight +=  60;
    [self.mainSrollView addSubview:view7];
    
    UIImageView *view7ImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"Group 124")];
    [view7 addSubview:view7ImageView];
    [view7ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(view7);
        make.width.height.mas_equalTo(30);
    }];
    
    UILabel *view7Label = [[UILabel alloc]init];
    view7Label.font = [UIFont systemFontOfSize:13];
    view7Label.text = @"油量和公里数";
    [view7 addSubview:view7Label];
    [view7Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view7ImageView.mas_right).mas_equalTo(5);
        make.centerY.mas_equalTo(view7);
    }];
    
    
    UIView *view8 = [[UIView alloc]initWithFrame:CGRectMake(0, gunHeight, kWindowW, 60)];
    view8.backgroundColor = [UIColor whiteColor];
    gunHeight +=  60;
    [self.mainSrollView addSubview:view8];
    
    for (int i = 0; i<2; i++) {
        UILabel *la1 = [[UILabel alloc]initWithFrame:CGRectMake(10, i*30, kWindowW/2, 30)];
        la1.adjustsFontSizeToFitWidth = YES;
        la1.font = [UIFont systemFontOfSize:13];
        la1.textAlignment = NSTextAlignmentLeft;
        if (i==0) {
            la1.text = @"油量";
        }else
        {
            la1.text = @"公里数";
        }
        [view8 addSubview:la1];
        UILabel *la2 = [[UILabel alloc]initWithFrame:CGRectMake(kWindowW/2, i*30, kWindowW/2-20, 30)];
        la2.textColor = [UIColor redColor];
        la2.adjustsFontSizeToFitWidth = YES;
        la2.font = [UIFont systemFontOfSize:13];
        la2.textAlignment = NSTextAlignmentRight;
        if (i==0) {
            la2.text = [NSString stringWithFormat:@"%@%%",self.gas];
        }else
        {
            la2.text = [NSString stringWithFormat:@"%@公里",self.repairmile];
        }
        [view8 addSubview:la2];
    }
    
    self.mainSrollView.backgroundColor = [UIColor clearColor];
    self.mainSrollView.contentSize = CGSizeMake(kWindowW, gunHeight);
}


-(void)imagesButtonChick:(UIButton *)sender
{
    NSInteger index = sender.tag - 2000;
    NSDictionary *images = self.images[index];
    NSDictionary *describe = KISDictionaryHaveKey(images, @"describe");
    PreviewPictureViewController *vc = [[PreviewPictureViewController alloc]init];
    CarInspectionModel *model = [[CarInspectionModel alloc]init];
    model.fangXiang = KISDictionaryHaveKey(describe, @"Direction");
    model.beiZhu = KISDictionaryHaveKey(describe, @"remarks");
    model.urlDiZhi = KISDictionaryHaveKey(images, @"images");
    
    if ([KISDictionaryHaveKey(describe, @"AX")integerValue]>0) {
        [model.wenTiArray addObject:@"凹陷"];
    }
    if ([KISDictionaryHaveKey(describe, @"DQ")integerValue]>0) {
        [model.wenTiArray addObject:@"掉漆"];
    }
    if ([KISDictionaryHaveKey(describe, @"GH")integerValue]>0) {
        [model.wenTiArray addObject:@"刮痕"];
    }
    if ([KISDictionaryHaveKey(describe, @"LW")integerValue]>0) {
        [model.wenTiArray addObject:@"裂纹"];
    }
    if ([KISDictionaryHaveKey(describe, @"PS")integerValue]>0) {
        [model.wenTiArray addObject:@"破损"];
    }
    if ([KISDictionaryHaveKey(describe, @"XS")integerValue]>0) {
        [model.wenTiArray addObject:@"锈蚀"];
    }
    
    vc.chuRuMoel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
