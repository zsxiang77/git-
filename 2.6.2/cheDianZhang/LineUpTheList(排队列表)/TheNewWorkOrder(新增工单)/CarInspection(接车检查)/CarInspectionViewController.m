//
//  CarInspectionViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/13.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "CarInspectionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "CarInspectionErVC.h"
#import "PreviewPictureViewController.h"

#define ZHANSHITGA  (4000)

#define YULANTAG  (5000)
#define GUANBITAG  (6000)

@interface CarInspectionViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *_imagePickerController;
}

@property(nonatomic,strong)UIScrollView *mianScrollView;
@property(nonatomic,strong)UIScrollView *zuoYouScrollView;
@property(nonatomic,strong)NSMutableArray  *wenTiArray;

@end

@implementation CarInspectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"接车检查" withBackButton:YES];
    self.wenTiArray = [[NSMutableArray alloc]init];
    [self yeMianBuJu];
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self zuoYouScrollViewBuju];
}

-(void)tuPianYLbtChick:(UIButton *)sender
{
    
    NSInteger index = sender.tag - YULANTAG;
    PreviewPictureViewController *vc = [[PreviewPictureViewController alloc]init];
//    vc.chuRuMoel = self.wenTiArray[index];
    vc.tuPianArray = self.wenTiArray;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)guanbiBtChick:(UIButton *)sender
{
    NSInteger index = sender.tag - GUANBITAG;
    [self.wenTiArray removeObject:self.wenTiArray[index]];
    [self zuoYouScrollViewBuju];
}

-(void)zuoYouScrollViewBuju
{
    while ([self.zuoYouScrollView.subviews lastObject] != nil)
    {
        [(UIView*)[self.zuoYouScrollView.subviews lastObject] removeFromSuperview];
    }
    int aoXian = 0;
    int diaoQi = 0;
    int guanHen = 0;
    int lieWen = 0;
    int poSun = 0;
    int xiuShi = 0;
    
    for (int i = 0; i<self.wenTiArray.count;i++ ) {
        CarInspectionModel *model = self.wenTiArray[i];
        UIView *diangWeiViwe = [[UIView alloc]initWithFrame:CGRectMake(70*i+5, 5, 65, 60)];
        diangWeiViwe.backgroundColor = [UIColor blackColor];
        [self.zuoYouScrollView addSubview:diangWeiViwe];
        
        UIImageView *zhuIm = [[UIImageView alloc]initWithImage:model.cunImage];
        zhuIm.contentMode = UIViewContentModeScaleAspectFit;
        [diangWeiViwe addSubview:zhuIm];
        [zhuIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        UIImageView *guanBiIm = [[UIImageView alloc]initWithImage:DJImageNamed(@"ic_clear_image_normal")];
        [diangWeiViwe addSubview:guanBiIm];
        [guanBiIm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.width.height.mas_equalTo(20);
        }];
        
        UIButton *tuPianYLbt = [[UIButton alloc]init];
        tuPianYLbt.tag = YULANTAG + i;
        [diangWeiViwe addSubview:tuPianYLbt];
        [tuPianYLbt addTarget:self action:@selector(tuPianYLbtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [tuPianYLbt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        UIButton *guanbiBt = [[UIButton alloc]init];
        [diangWeiViwe addSubview:guanbiBt];
        guanbiBt.tag = GUANBITAG  + i;
        [guanbiBt addTarget:self action:@selector(guanbiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [guanbiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.width.height.mas_equalTo(30);
        }];
        
        for (int j = 0; j<model.wenTiArray.count; j++) {
            if ([model.wenTiArray[j] isEqualToString:@"凹陷"]) {
                aoXian ++;
            }else if ([model.wenTiArray[j] isEqualToString:@"掉漆"]) {
                diaoQi ++;
            }else if ([model.wenTiArray[j] isEqualToString:@"刮痕"]) {
                guanHen ++;
            }else if ([model.wenTiArray[j] isEqualToString:@"裂纹"]) {
                lieWen ++;
            }else if ([model.wenTiArray[j] isEqualToString:@"破损"]) {
                poSun ++;
            }else if ([model.wenTiArray[j] isEqualToString:@"锈蚀"]) {
                xiuShi ++;
            }
        }
    }
    self.zuoYouScrollView.contentSize = CGSizeMake(self.wenTiArray.count*70, 70);
    
    for (int i = 0; i<6; i++) {
        UILabel *la = [self.mianScrollView viewWithTag:ZHANSHITGA+i];
        switch (i) {
            case 0:
            {
                la.text = [NSString stringWithFormat:@"凹陷（%d）",aoXian];
                if (aoXian>0) {
                    la.textColor = [UIColor orangeColor];
                }else{
                    la.textColor = [UIColor blackColor];
                }
            }
                break;
            case 1:
            {
                la.text = [NSString stringWithFormat:@"掉漆（%d）",diaoQi];
                if (diaoQi>0) {
                    la.textColor = [UIColor orangeColor];
                }else{
                    la.textColor = [UIColor blackColor];
                }

            }
                break;
            case 2:
            {
                la.text = [NSString stringWithFormat:@"刮痕（%d）",guanHen];
                if (guanHen>0) {
                    la.textColor = [UIColor orangeColor];
                }else{
                    la.textColor = [UIColor blackColor];
                }
            }
                break;
            case 3:
            {
                la.text = [NSString stringWithFormat:@"裂纹（%d）",lieWen];
                if (lieWen>0) {
                    la.textColor = [UIColor orangeColor];
                }else{
                    la.textColor = [UIColor blackColor];
                }
            }
                break;
            case 4:
            {
                la.text = [NSString stringWithFormat:@"破损（%d）",poSun];
                if (poSun>0) {
                    la.textColor = [UIColor orangeColor];
                }else{
                    la.textColor = [UIColor blackColor];
                }
            }
                break;
            case 5:
            {
                la.text = [NSString stringWithFormat:@"锈蚀（%d）",xiuShi];
                if (xiuShi>0) {
                    la.textColor = [UIColor orangeColor];
                }else{
                    la.textColor = [UIColor blackColor];
                }
            }

                break;
                
            default:
                break;
        }
    }
    
}
-(void)yeMianBuJu
{
    CGFloat sheZhiHeight = 0;
    self.mianScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight)];
    self.mianScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mianScrollView];
    
    UILabel *titiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, sheZhiHeight, kWindowW, 40)];
    titiLabel.backgroundColor = kRGBColor(240, 240, 240);
    titiLabel.text = @"1、进行车辆外观检查";
    titiLabel.textAlignment = NSTextAlignmentCenter;
    [self.mianScrollView addSubview:titiLabel];
    sheZhiHeight += 40;
    
    UIView *shangBaiView = [[UIView alloc]initWithFrame:CGRectMake(0, sheZhiHeight, kWindowW, 150)];
    shangBaiView.backgroundColor = [UIColor whiteColor];
    [self.mianScrollView addSubview:shangBaiView];
    sheZhiHeight += 150;
    
    UIButton *zhaoXiangBt = [[UIButton alloc]init];
    [zhaoXiangBt setImage:DJImageNamed(@"inspect_camera") forState:(UIControlStateNormal)];
    [zhaoXiangBt addTarget:self action:@selector(zhaoXiangBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [shangBaiView addSubview:zhaoXiangBt];
    [zhaoXiangBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(shangBaiView);
        make.height.mas_equalTo(70);
        make.width.mas_equalTo(70*228/178);
    }];
    
    UILabel *zhaoxiangLa = [[UILabel alloc]init];
    zhaoxiangLa.text = @"点击相机照相";
    zhaoxiangLa.textColor = [UIColor grayColor];
    [shangBaiView addSubview:zhaoxiangLa];
    [zhaoxiangLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(shangBaiView);
        make.top.mas_equalTo(zhaoXiangBt.mas_bottom).mas_equalTo(10);
    }];
    
    
    self.zuoYouScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, sheZhiHeight, kWindowW, 70)];
    self.zuoYouScrollView.backgroundColor = [UIColor whiteColor];
    [self.mianScrollView addSubview:self.zuoYouScrollView];
    sheZhiHeight += 60;
    
    for (int i = 0; i<6; i++) {
        UILabel *zhanshilabel = [[UILabel alloc]initWithFrame:CGRectMake((kWindowW/3)*(i%3), sheZhiHeight +(i/3)*40, kWindowW/3, 40)];
        zhanshilabel.font = [UIFont systemFontOfSize:14];
        zhanshilabel.textAlignment = NSTextAlignmentCenter;
        zhanshilabel.tag = ZHANSHITGA+i;
        zhanshilabel.textColor = [UIColor grayColor];
        [self.mianScrollView addSubview:zhanshilabel];
        if (i == 0) {
            zhanshilabel.text = @"凹陷（0）";
        }else if (i == 1) {
            zhanshilabel.text = @"掉漆（0）";
        }else if (i == 2) {
            zhanshilabel.text = @"刮痕（0）";
        }else if (i == 3) {
            zhanshilabel.text = @"裂纹（0）";
        }else if (i == 4) {
            zhanshilabel.text = @"破损（0）";
        }else
        {
            zhanshilabel.text = @"锈蚀（0）";
        }
    }
    
    sheZhiHeight += 80;
    
    UIButton *queDingBt = [[UIButton alloc]initWithFrame:CGRectMake(10, sheZhiHeight + 30, kWindowW-20, 40)];
    [queDingBt.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    [queDingBt.layer setCornerRadius:3];
    queDingBt.backgroundColor = kZhuTiColor;
    [queDingBt setTitle:@"下一步" forState:(UIControlStateNormal)];
    [queDingBt addTarget:self action:@selector(queDingBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [queDingBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [self.mianScrollView addSubview:queDingBt];
    sheZhiHeight += 100;
    
    self.mianScrollView.contentSize = CGSizeMake(kWindowW, sheZhiHeight);
    
    
}
-(void)queDingBtChick:(UIButton *)sender
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [self showOrHideLoadView:YES];
    
    kWeakSelf(weakSelf)
    NSString *path = [NSString stringWithFormat:@"%@order/repair_order/goods",HOST_URL];
    [[NetWorkManagerGet sharedAFManager] GET:path parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress) {
        
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self showOrHideLoadView:NO];
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
        NSArray *array = KISDictionaryHaveKey(adData, @"goods");
        NSMutableArray *chuaArray = [[NSMutableArray alloc]init];
        if (code == 200) {
            if (array.count>0) {
                for (int i = 0;i<array.count ; i++) {
                    AccessoryEquipmentModel *model = [[AccessoryEquipmentModel alloc]init];
                    [model setDataShuJu:array[i]];
                    [chuaArray addObject:model];
                }
                
            }
            AccessoryEquipmentVC *vc = [[AccessoryEquipmentVC alloc]init];
            vc.chuRuArray = chuaArray;
            [weakSelf.zuiZhongModel.image_info  removeAllObjects];
            [weakSelf.zuiZhongModel.image_info_sum  removeAllObjects];
            int aoXian = 0;
            int diaoQi = 0;
            int guanHen = 0;
            int lieWen = 0;
            int poSun = 0;
            int xiuShi = 0;
            
            NSString *images = @"";
            
            for (int i = 0; i<weakSelf.wenTiArray.count; i++) {
                
                CarInspectionModel *model = weakSelf.wenTiArray[i];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                NSString *AX = @"0";
                NSString *DQ = @"0";
                NSString *GH = @"0";
                NSString *PS = @"0";
                NSString *XS = @"0";
                NSString *LW = @"0";
                
                for (int j = 0; j<model.wenTiArray.count; j++) {
                    if ([model.wenTiArray[j] isEqualToString:@"凹陷"]) {
                        AX = @"1";
                    }else if ([model.wenTiArray[j] isEqualToString:@"掉漆"]) {
                        DQ = @"1";
                    }else if ([model.wenTiArray[j] isEqualToString:@"刮痕"]) {
                        GH = @"1";
                    }else if ([model.wenTiArray[j] isEqualToString:@"裂纹"]) {
                        LW = @"1";
                    }else if ([model.wenTiArray[j] isEqualToString:@"破损"]) {
                        PS = @"1";
                    }else if ([model.wenTiArray[j] isEqualToString:@"锈蚀"]) {
                        XS = @"1";
                    }
                }
                
                [dict setObject:[NSString stringWithFormat:@"%@",AX] forKey:@"AX"];
                [dict setObject:[NSString stringWithFormat:@"%@",DQ] forKey:@"DQ"];
                [dict setObject:[NSString stringWithFormat:@"%@",GH] forKey:@"GH"];
                [dict setObject:[NSString stringWithFormat:@"%@",PS] forKey:@"PS"];
                [dict setObject:[NSString stringWithFormat:@"%@",XS] forKey:@"XS"];
                [dict setObject:[NSString stringWithFormat:@"%@",LW] forKey:@"LW"];
                [dict setObject:[NSString stringWithFormat:@"%@",model.fangXiang] forKey:@"Direction"];
                [dict setObject:[NSString stringWithFormat:@"%d",i+1] forKey:@"id"];
                [dict setObject:[NSString stringWithFormat:@"%@",model.beiZhu] forKey:@"remarks"];
                
                [weakSelf.zuiZhongModel.image_info  addObject:dict];
                
                
                for (int j = 0; j<model.wenTiArray.count; j++) {
                    if ([model.wenTiArray[j] isEqualToString:@"凹陷"]) {
                        aoXian ++;
                    }else if ([model.wenTiArray[j] isEqualToString:@"掉漆"]) {
                        diaoQi ++;
                    }else if ([model.wenTiArray[j] isEqualToString:@"刮痕"]) {
                        guanHen ++;
                    }else if ([model.wenTiArray[j] isEqualToString:@"裂纹"]) {
                        lieWen ++;
                    }else if ([model.wenTiArray[j] isEqualToString:@"破损"]) {
                        poSun ++;
                    }else if ([model.wenTiArray[j] isEqualToString:@"锈蚀"]) {
                        xiuShi ++;
                    }
                }
                
                if (images.length>0) {
                    images = [NSString stringWithFormat:@"%@,%@",images,model.tuPianNameStr];
                }else
                {
                    images = model.tuPianNameStr;
                }
                
            }
            NSMutableDictionary *dict2 = [[NSMutableDictionary alloc]init];
            [dict2 setObject:[NSString stringWithFormat:@"%d",aoXian] forKey:@"AX"];
            [dict2 setObject:[NSString stringWithFormat:@"%d",diaoQi] forKey:@"DQ"];
            [dict2 setObject:[NSString stringWithFormat:@"%d",guanHen] forKey:@"GH"];
            [dict2 setObject:[NSString stringWithFormat:@"%d",poSun] forKey:@"PS"];
            [dict2 setObject:[NSString stringWithFormat:@"%d",xiuShi] forKey:@"XS"];
            [dict2 setObject:[NSString stringWithFormat:@"%d",lieWen] forKey:@"LW"];
            [dict2 setObject:@"1" forKey:@"id"];
            
            [weakSelf.zuiZhongModel.image_info_sum  addObject:dict2];
            
            weakSelf.zuiZhongModel.imagec = images;
            
            
            vc.zuiZhongModel = weakSelf.zuiZhongModel;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showOrHideLoadView:NO];
        NPrintLog(@"请求失败 %@ \n", error);
    }];
    
}

-(void)zhaoXiangBtChick:(UIButton *)sender
{
    //判断摄像头授权
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"未获得授权使用摄像头" message:@"请在iOS '设置-隐私-相机' 中打开" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        [alert show];
        return;
    }
    
    if (self.wenTiArray.count>8) {
        [self showMessageWithContent:@"最多8张" point:self.view.center afterDelay:2.0];
        return;
    }
    
    [self selectImageFromCamera];

}



#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera
{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark 图片保存完毕的回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeImage]) {
        UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else if([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeMovie])
    {
        NSString* path = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
    }
    
}

-(void)image:(UIImage *)imaeg didFinishSavingWithError:(NSError *)error contextInfo:(NSDictionary *)info
{
    CarInspectionModel *model = [[CarInspectionModel alloc]init];
    model.cunImage = imaeg;
    CarInspectionErVC *vc = [[CarInspectionErVC alloc]init];
    kWeakSelf(weakSelf)
    vc.tianJianWenTiChick = ^(CarInspectionModel *model) {
        [weakSelf.wenTiArray addObject:model];
    };
    vc.chuRuMoel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)video:(AVAudioSession *)video didFinishSavingWithError:(NSError *)error contextInfo:(NSDictionary *)info
{
    
}
@end
