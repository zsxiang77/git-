//
//  XiMeiDetailViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiDetailViewController.h"
#import "OrderDetailCell1.h"
#import "OrderDetailViewController.h"
#import "CustomerInformationView.h"
#import "SellerInForMetionView.h"
#import "HaoCaiInFormetionView.h"
#import "PreviewPictureViewController.h"

#define YULANTAG  (5000)
#define GUANBITAG  (6000)

@interface XiMeiDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)CustomerInformationView *customerInformationView;
@property(nonatomic,strong)SellerInForMetionView *sellerInForMetionView;
@property(nonatomic,strong)HaoCaiInFormetionView *haoCaiInFormetionView;

@property(nonatomic,strong)UIButton *wanChengBt;

@end

@implementation XiMeiDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"订单详情" withBackButton:YES];
    self.wenTiArray = [[NSMutableArray alloc]init];
    
    self.wanChengBt = [[UIButton alloc]initWithFrame:CGRectMake(10, kWindowH-60, kWindowW-20, 40)];
    
    
    self.wanChengBt.backgroundColor = kNavBarColor;
    if (self.anNiuStr.length>0) {
        [self.wanChengBt setTitle:self.anNiuStr forState:(UIControlStateNormal)];
    }else
    {
        [self.wanChengBt setTitle:@"修改订单" forState:(UIControlStateNormal)];
    }
    
    [self.wanChengBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.wanChengBt addTarget:self action:@selector(wanChengBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.wanChengBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [self.wanChengBt.layer setCornerRadius:3];
    [self.view addSubview:self.wanChengBt];
    
    if (self.yingCangAnNiu == YES) {
        self.wanChengBt.hidden = YES;
    }
    
}
-(void)sethandle_orderordercodeWithTheWorkModel:(TheWorkModel *)model shiFouXimei:(UIButton *)sender
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.ordercode forKey:@"ordercode"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/handle_order" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if ([KISDictionaryHaveKey(responseObject, @"code")integerValue] == 200) {
            if (sender == nil) {
                [weakSelf getrequest_methodWithTheWorkModel:model];
            }else
            {
                [weakSelf shuaXinHeaderView2];
                [sender setTitle:@"施工完成" forState:(UIControlStateNormal)];
                [weakSelf.mainTableView reloadData];
            }
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return ;
            
        }
        
        
    } failure:^(id error) {
        
    }];
}

-(void)getrequest_methodWithTheWorkModel:(TheWorkModel *)model
{
    [self showOrHideLoadView:YES];

    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];


    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@store_staff/store_set/settings",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress) {

        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf showOrHideLoadView:NO];

        NSData *filData = responseObject;
        NSDictionary* parserDict = (NSDictionary *)filData;
        NPrintLog(@"\n返回：%@",parserDict);
        NSInteger code = [KISDictionaryHaveKey(parserDict, @"code") integerValue];
        if (code == 604)
        {
            [[UserInfo shareInstance] cleanUserInfor];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
            [NetWorkManager loginAgain:self];
            return;
        }

        NSDictionary *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSDictionary class]]) {

            return ;
        }

        NSDictionary *settings = KISDictionaryHaveKey(adData, @"settings");

        if (code == 200) {
            if ([model.class_name isEqualToString:@"维修"]) {
                OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
                if ([KISDictionaryHaveKey(settings, @"is_hide_button")boolValue]) {
                    vc.shiFouKeXiugai = YES;
                }else{
                    vc.shiFouKeXiugai = NO;
                }

                vc.hidesBottomBarWhenPushed = YES;
                vc.chuanzhiModel = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf showOrHideLoadView:NO];
        [[UserInfo shareInstance] showNotNetView];
    }];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setrequest_methodwithOrdercodevarchar:self.chuanzhiModel];
}

-(void)wanChengBtChick:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"施工完成"]) {
        if ([self.zhuModel.is_lock isEqualToString:@"1"] && [self.zhuModel.is_free intValue] == 0){
            [self showMessageWithContent:@"已锁单" point:self.view.center afterDelay:2];
            return;
        }
        [self postZuiHouTiJiao:self.chuanzhiModel];
        return;
    }
    
    if ([self.chuanzhiModel.class_name isEqualToString:@"维修"]) {
        [self sethandle_orderordercodeWithTheWorkModel:self.chuanzhiModel shiFouXimei:nil];
        
//        [self getrequest_methodWithTheWorkModel:self.chuanzhiModel];
        
//        OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.chuanzhiModel = self.chuanzhiModel;
//        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        [self sethandle_orderordercodeWithTheWorkModel:self.chuanzhiModel shiFouXimei:sender];
        
    }
}
-(OrderDetailModel *)zhuModel
{
    if (!_zhuModel) {
        _zhuModel = [[OrderDetailModel alloc]init];
    }
    return _zhuModel;
}
-(ErWeiMaView *)erWeiMaView
{
    if (!_erWeiMaView) {
        _erWeiMaView = [[ErWeiMaView alloc]init];
        _erWeiMaView.hidden = YES;
        [self.view addSubview:_erWeiMaView];
        [self.view bringSubviewToFront:_erWeiMaView];
    }
    return _erWeiMaView;
}
-(XiMeiDetailHeaderView *)xiMeiDetailHeaderView
{
    if (!_xiMeiDetailHeaderView) {
        _xiMeiDetailHeaderView = [[XiMeiDetailHeaderView alloc]init];
        kWeakSelf(weakSelf)
        _xiMeiDetailHeaderView.erWeiMaButtonBlock = ^{
            Order_info *model = (Order_info *)weakSelf.zhuModel.order_info;
            weakSelf.erWeiMaView.mainImageView.image  = [SuccessfulOrderViewController qrCodeImageWithContent:model.order_url codeImageSize:180 red:0 green:0 blue:1];
            weakSelf.erWeiMaView.hidden = NO;
        };
        _xiMeiDetailHeaderView.chaKaButtonBlock = ^{
            if (weakSelf.zhuModel.comm_info.count<=0) {
                return ;
            }
            weakSelf.haoCaiInFormetionView.hidden = NO;
            weakSelf.haoCaiInFormetionView.mainArray = weakSelf.zhuModel.comm_info;
            [weakSelf.haoCaiInFormetionView.mainTableView reloadData];
        };
    }
    return _xiMeiDetailHeaderView;
}

-(XiMeiDetailHeaderView *)xiMeiDetailHeaderView2
{
    if (!_xiMeiDetailHeaderView2) {
        _xiMeiDetailHeaderView2 = [[XiMeiDetailHeaderView alloc]init];
        kWeakSelf(weakSelf)
        _xiMeiDetailHeaderView2.erWeiMaButtonBlock = ^{
            Order_info *model = (Order_info *)weakSelf.zhuModel.order_info;
            weakSelf.erWeiMaView.mainImageView.image  = [SuccessfulOrderViewController qrCodeImageWithContent:model.order_url codeImageSize:180 red:0 green:0 blue:1];
            weakSelf.erWeiMaView.hidden = NO;
        };
        _xiMeiDetailHeaderView2.chaKaButtonBlock = ^{
            if (weakSelf.zhuModel.comm_info.count<=0) {
                return ;
            }
            weakSelf.haoCaiInFormetionView.hidden = NO;
            weakSelf.haoCaiInFormetionView.mainArray = weakSelf.zhuModel.comm_info;
            [weakSelf.haoCaiInFormetionView.mainTableView reloadData];
        };
        
        _xiMeiDetailHeaderView2.suoDanSwitchBlock = ^(UISwitch *sender) {
            if (sender.on == YES) {
                
                [weakSelf postSuoDanWithModel:weakSelf.chuanzhiModel];
            }else
            {
                if ([weakSelf.zhuModel.is_lock isEqualToString:@"1"] && [weakSelf.zhuModel.is_free intValue] == 0) {
                    [weakSelf showMessageWithContent:@"已锁单" point:weakSelf.view.center afterDelay:2];
                    sender.on = YES;
                    return;
                }
                
                [weakSelf postjieSuoWithModel:weakSelf.chuanzhiModel];
            }
            
        };
        
    }
    return _xiMeiDetailHeaderView2;
}
-(HaoCaiInFormetionView *)haoCaiInFormetionView
{
    if (!_haoCaiInFormetionView) {
        _haoCaiInFormetionView = [[HaoCaiInFormetionView alloc]init];
        [self.view addSubview:_haoCaiInFormetionView];
        [self.view bringSubviewToFront:_haoCaiInFormetionView];
    }
    return _haoCaiInFormetionView;
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight-60) style:UITableViewStyleGrouped];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData0)];
        [self.view addSubview:_mainTableView];
        
    }
    return _mainTableView;
}

-(void)loadNewData0
{
    [self.mainTableView.mj_header endRefreshing];
    if ([self.wanChengBt.titleLabel.text isEqualToString:@"施工完成"]) {
        [self sethandle_orderordercodeWithTheWorkModel:self.chuanzhiModel shiFouXimei:self.wanChengBt];
    }else{
        [self setrequest_methodwithOrdercodevarchar:self.chuanzhiModel];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myIdentifier = @"Cell";
    OrderDetailCell1 *cell = (OrderDetailCell1 *)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil)
        cell = [[OrderDetailCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    cell.youImageView.hidden = YES;
    if (indexPath.row == 0) {
        cell.zuoLabel.text = @"订单来源";
        cell.youImageView.hidden = NO;
        //            1线上下单 2 后台创建 3 app
        Order_info *model = (Order_info *)self.zhuModel.order_info;
        if ([model.create_type isEqualToString:@"1"]) {
            cell.youLabel.text = @"线上下单";
            cell.youImageView.image = DJImageNamed(@"source_weixin");
        }else if([model.create_type isEqualToString:@"2"])
        {
            cell.youLabel.text = @"后台";
            cell.youImageView.image = DJImageNamed(@"source_pc");
        }else if([model.create_type isEqualToString:@"3"])
        {
            cell.youLabel.text = @"APP";
            cell.youImageView.image = DJImageNamed(@"source_app");
        }
        cell.youLabel.textColor = [UIColor blackColor];
    }else if (indexPath.row == 2) {
        cell.zuoLabel.text = @"销售信息";
        cell.youLabel.text = @"查看";
        cell.youLabel.textColor = [UIColor blueColor];
        
    }else if (indexPath.row == 1) {
        cell.zuoLabel.text = @"客户信息";
        cell.youLabel.text = @"查看";
        cell.youLabel.textColor = [UIColor blueColor];
    }else
    {
        cell.zuoLabel.text = @"施工人员";
        
        if (self.zhuModel.operation.length>0) {
            cell.youLabel.text = @"查看";
            cell.youLabel.textColor = [UIColor blueColor];
        }else{
            cell.youLabel.text = @"";
            cell.youLabel.textColor = [UIColor blueColor];
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        self.customerInformationView.hidden = NO;
        [self.customerInformationView setYeMianWithOrderDetailModel:self.zhuModel];
    }
    if (indexPath.row == 2) {
        self.sellerInForMetionView.hidden = NO;
        [self.sellerInForMetionView setYeMianWithOrderDetailModel:self.zhuModel];
    }
    
    if (indexPath.row == 3) {
        if (self.zhuModel.operation.length>0) {
            [self showAlertViewWithTitle:nil Message:self.zhuModel.operation buttonTitle:@"确定"];
        }else
        {
            return;
        }
        
    }
}
-(CustomerInformationView *)customerInformationView
{
    if (!_customerInformationView) {
        _customerInformationView = [[CustomerInformationView alloc]init];
        [self.view addSubview:_customerInformationView];
        [self.view bringSubviewToFront:_customerInformationView];
    }
    return _customerInformationView;
}

-(SellerInForMetionView *)sellerInForMetionView
{
    if (!_sellerInForMetionView) {
        _sellerInForMetionView = [[SellerInForMetionView alloc]init];
        [self.view addSubview:_sellerInForMetionView];
        [self.view bringSubviewToFront:_sellerInForMetionView];
    }
    return _sellerInForMetionView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
//    [[tableView viewWithTag:1000] removeFromSuperview];
    
    UIView *footView = [[UIView alloc]init];
    footView.tag = 1000;
    footView.backgroundColor = kRGBColor(244, 245, 246);
    CGFloat jiSuanGao = 0;
    if ([self.wanChengBt.titleLabel.text isEqualToString:@"施工完成"]) {
        UILabel *la = [[UILabel alloc]init];
        la.text = @"施工信息";
        la.font = [UIFont systemFontOfSize:14];
        la.textColor = [UIColor grayColor];
        [footView addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(jiSuanGao);
            make.height.mas_equalTo(25);
        }];
        
        self.zuoYouScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 25, kWindowW, 70)];
        self.zuoYouScrollView.backgroundColor = [UIColor whiteColor];
        [footView addSubview:self.zuoYouScrollView];
        [self zuoYouScrollViewBuju];
        jiSuanGao += 95;
    }
    
    
    
    
    UILabel *la = [[UILabel alloc]init];
    la.text = @"订单操作人员";
    la.font = [UIFont systemFontOfSize:14];
    la.textColor = [UIColor grayColor];
    [footView addSubview:la];
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(jiSuanGao);
        make.height.mas_equalTo(35);
    }];
    
    UIView *backWhictView = [[UIView alloc]initWithFrame:CGRectMake(0,jiSuanGao+ 35, kWindowW, 60)];
    backWhictView.backgroundColor = [UIColor whiteColor];
    [footView addSubview:backWhictView];
    
    UILabel *la2 = [[UILabel alloc]init];
    la2.text = self.zhuModel.holder_info;
    la2.font = [UIFont systemFontOfSize:14];
    la2.textColor = [UIColor grayColor];
    [backWhictView addSubview:la2];
    [la2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    return footView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.wanChengBt.titleLabel.text isEqualToString:@"施工完成"]) {
        return 200;
    }
    return 100;
}

#pragma mark - 拍照


-(void)zuoYouScrollViewBuju
{
    while ([self.zuoYouScrollView.subviews lastObject] != nil)
    {
        [(UIView*)[self.zuoYouScrollView.subviews lastObject] removeFromSuperview];
    }
    
    
    UIView *shangDingVIew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    [self.zuoYouScrollView addSubview:shangDingVIew];
    
    UIButton *tianJianbt = [[UIButton alloc]init];
    [tianJianbt setImage:DJImageNamed(@"add_new_photo") forState:(UIControlStateNormal)];
    [shangDingVIew addSubview:tianJianbt];
    [tianJianbt addTarget:self action:@selector(tianJianbtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [tianJianbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(5);
        make.bottom.right.mas_equalTo(-5);
    }];
    
    for (int i = 1; i<self.zhuModel.media_images.count+1;i++ ) {
        NSString *modelStr = self.zhuModel.media_images[i-1];
        UIView *diangWeiViwe = [[UIView alloc]initWithFrame:CGRectMake(70*i+5, 5, 65, 60)];
        diangWeiViwe.backgroundColor = [UIColor blackColor];
        [self.zuoYouScrollView addSubview:diangWeiViwe];
        
        UIImageView *zhuIm = [[UIImageView alloc]init];
        zhuIm.contentMode = UIViewContentModeScaleAspectFit;
        [diangWeiViwe addSubview:zhuIm];
        [zhuIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        [zhuIm  sd_setImageWithURL:[NSURL URLWithString:modelStr] placeholderImage:DJImageNamed(@"ic_launcher")];
        
        UIImageView *guanBiIm = [[UIImageView alloc]initWithImage:DJImageNamed(@"ic_clear_image_normal")];
        [diangWeiViwe addSubview:guanBiIm];
        [guanBiIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.width.height.mas_equalTo(20);
        }];
        
        UIButton *tuPianYLbt = [[UIButton alloc]init];
        tuPianYLbt.tag = YULANTAG + i-1;
        [diangWeiViwe addSubview:tuPianYLbt];
        [tuPianYLbt addTarget:self action:@selector(tuPianYLbtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [tuPianYLbt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        UIButton *guanbiBt = [[UIButton alloc]init];
        [diangWeiViwe addSubview:guanbiBt];
        guanbiBt.tag = GUANBITAG  + i-1;
        [guanbiBt addTarget:self action:@selector(guanbiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [guanbiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.width.height.mas_equalTo(30);
        }];
    }
    self.zuoYouScrollView.contentSize = CGSizeMake((self.wenTiArray.count+1)*70, 70);
}



-(void)tuPianYLbtChick:(UIButton *)sender
{
    NSInteger index = sender.tag - YULANTAG;
    
    PreviewPictureViewController *vc = [[PreviewPictureViewController alloc]init];
    vc.shiFouZhanShi = YES;
    CarInspectionModel *model = [[CarInspectionModel alloc]init];
    model.urlDiZhi = self.zhuModel.media_images[index];
    vc.chuRuMoel = model;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)guanbiBtChick:(UIButton *)sender
{
    if ([self.zhuModel.is_lock isEqualToString:@"1"] && [self.zhuModel.is_free intValue] == 0) {
        [self showMessageWithContent:@"已锁单" point:self.view.center afterDelay:2];
        return;
    }
    NSInteger index = sender.tag - GUANBITAG;
    NSString *shanImage = @"";
    for (int i = 0; i<self.zhuModel.media_images.count; i++) {
        if (![self.zhuModel.media_images[i] isEqualToString:self.zhuModel.media_images[index]]) {
            if (shanImage.length>0) {
                shanImage = [NSString stringWithFormat:@"%@,%@",shanImage,self.zhuModel.media_images[i]];
            }else
            {
                shanImage = self.zhuModel.media_images[i];
            }
        }
    }
    [self shanChuShiGongTuPian:self.chuanzhiModel withImage:shanImage];
}
-(void)tianJianbtChick:(UIButton *)sender
{
    
    if ([self.zhuModel.is_lock isEqualToString:@"1"] && [self.zhuModel.is_free intValue] == 0) {
        [self showMessageWithContent:@"已锁单" point:self.view.center afterDelay:2];
        return;
    }
    
    if (self.wenTiArray.count>8) {
        [self showMessageWithContent:@"最多8张" point:self.view.center afterDelay:2.0];
        return;
    }
    
//    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"小视频" otherButtonTitles:@"拍照", nil];
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:nil];
    
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (buttonIndex == 0) {
//        [self selectImageFromCameraWithVideo:YES];
//    }
//    if (buttonIndex == 1) {
//        [self selectImageFromCameraWithVideo:NO];
//    }
    if (buttonIndex == 0) {
        [self selectImageFromCameraWithVideo:NO];
    }
}

#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCameraWithVideo:(BOOL)video
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    if (video == YES) {
        if ([UIImagePickerController
             isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            NSArray *availableMediaTypes = [UIImagePickerController
                                            availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            if ([availableMediaTypes containsObject:(NSString *)kUTTypeMovie]) {
                // 支持视频录制
                imagePickerController.delegate = self;
                imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                imagePickerController.allowsEditing = YES;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie];
            }else
            {
                return;
            }
        }
        
    }else{
        
        imagePickerController.delegate = self;
        imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    }
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark 图片保存完毕的回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeImage]) {
        UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else if([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeMovie])
    {
        // 如果是视频
        NSURL *url = info[UIImagePickerControllerMediaURL];
        
        // 获取视频总时长
        CGFloat lengthTime = [self getVideoLength:url];
        if (lengthTime >15.0f) {
            [self showAlertViewWithTitle:nil Message:@"只能上传15s内的视频" buttonTitle:@"确定"];
            return;
        }
        
        NSLog(@"%f",lengthTime);
        // 保存视频至相册 (异步线程)
        NSString *urlStr = [url path];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
                
                UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            }
            
        });
        
        AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
        NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
        
        if ([compatiblePresets containsObject:AVAssetExportPresetLowQuality])
            
        {
            
            AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetPassthrough];
            NSString *exportPath = [NSString stringWithFormat:@"%@/%@.mp4",
                                    [NSHomeDirectory() stringByAppendingString:@"/tmp"],
                                    @"1"];
            exportSession.outputURL = [NSURL fileURLWithPath:exportPath];
            NSLog(@"%@", exportPath);
            exportSession.outputFileType = AVFileTypeMPEG4;
            [exportSession exportAsynchronouslyWithCompletionHandler:^{
                
                switch ([exportSession status]) {
                    case AVAssetExportSessionStatusFailed:
                        NSLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
                        break;
                    case AVAssetExportSessionStatusCancelled:
                        NSLog(@"Export canceled");
                        break;
                    case AVAssetExportSessionStatusCompleted:
                        NSLog(@"转换成功");
                        break;
                    default:
                        break;
                }
            }];
        }
        
        //压缩视频
        NSData *videoData = [NSData dataWithContentsOfURL:url];
        //视频上传
        [self shangChuanVideos:videoData withUrl:url];
        
    }
}

-(void)image:(UIImage *)imaeg didFinishSavingWithError:(NSError *)error contextInfo:(NSDictionary *)info
{
    NSArray *array = @[imaeg];
    [self shangtuPian:array withImage:imaeg];
}
#pragma mark 视频保存完毕的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextIn {
    if (error) {
        NPrintLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NPrintLog(@"视频保存成功.");
        [self showMessageWindowWithTitle:@"视频保存成功" point:self.view.center delay:1];
    }
}

@end
