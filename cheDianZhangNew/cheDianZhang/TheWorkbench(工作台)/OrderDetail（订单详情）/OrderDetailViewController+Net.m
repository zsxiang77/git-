//
//  OrderDetailViewController+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/4.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "OrderDetailViewController.h"



@implementation OrderDetailViewController (Net)

// 获取视频时间
- (CGFloat) getVideoLength:(NSURL *)URL
{
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}

// 获取视频的大小
- (CGFloat) getFileSize:(NSString *)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init] ;
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }
    return filesize;
}

#pragma mark - 上穿施工信息图片
/**
 上传视频这版先不使用
 */
-(void)shangChuanVideos:(NSData *)adta withUrl:(NSURL *)url
{
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestDuoZhangWithParametersVideoRepresentationWithfileData:@"order/order_queue/upload_file" viewController:self isShowLoading:YES withfileData:adta success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        CarInspectionModel *model = [[CarInspectionModel alloc]init];
        model.url = url;
        model.tuPianNameStr = KISDictionaryHaveKey(dataDic, @"names");
        [weakSelf zuoYouScrollViewBuju];
    } failure:^(id error) {
        
    }];
}
-(void)shangtuPian:(NSArray *)adtaArray withImage:(UIImage *)image
{
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestDuoZhangWithParametersUIImageJPEGRepresentationWithUrl:@"order/order_queue/upload_file" viewController:self isShowLoading:YES withimage:adtaArray success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
//        CarInspectionModel *model = [[CarInspectionModel alloc]init];
//        model.cunImage = image;
//        [weakSelf.wenTiArray addObject:model];
//        model.tuPianNameStr = KISDictionaryHaveKey(dataDic, @"names");
//        [weakSelf zuoYouScrollViewBuju];
        
        [weakSelf shangChuanShiGongTuPian:weakSelf.chuanzhiModel withImage:KISDictionaryHaveKey(dataDic, @"names")];
    } failure:^(id error) {
        
    }];
}
-(void)shangChuanShiGongTuPian:(TheWorkModel *)model withImage:(NSString *)str{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.ordercode forKey:@"ordercode"];
    [mDict setObject:str forKey:@"images"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/add_images" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if ([KISDictionaryHaveKey(responseObject, @"code")integerValue]==200) {
            [weakSelf setrequest_methodwithOrdercodevarchar:model];
        }
    } failure:^(id error) {
        
    }];
}

-(void)shanChuShiGongTuPian:(TheWorkModel *)model withImage:(NSString *)str{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.ordercode forKey:@"ordercode"];
    [mDict setObject:str forKey:@"images"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/delete_images" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        if ([KISDictionaryHaveKey(responseObject, @"code")integerValue]==200) {
            [weakSelf setrequest_methodwithOrdercodevarchar:model];
        }
    } failure:^(id error) {
        
    }];
}


#pragma mark - 解锁订单
-(void)postjieSuoWithModel:(TheWorkModel *)model{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.ordercode forKey:@"ordercode"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/unlock_order" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
//        NSArray* dataDic = kParseData(responseObject);
//        if (![dataDic isKindOfClass:[NSArray class]]) {
//            return;
//        }
        
        if ([KISDictionaryHaveKey(responseObject, @"code")integerValue]==200) {
            weakSelf.zhuModel.is_lock = @"0";
            NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
            [defaultCenter postNotificationName:kShuaXinGuoZuoTai object:nil];
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
        }
        [weakSelf shuaXinHeaderView];
        [weakSelf.mainTableView reloadData];
        
    } failure:^(id error) {
        
    }];
}

#pragma mark - 锁单
-(void)postSuoDanWithModel:(TheWorkModel *)model{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.ordercode forKey:@"ordercode"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/lock_order" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
//        NSArray* dataDic = kParseData(responseObject);
//        if (![dataDic isKindOfClass:[NSArray class]]) {
//            return;
//        }
        
        if ([KISDictionaryHaveKey(responseObject, @"code")integerValue]==200) {
            weakSelf.zhuModel.is_lock = @"1";
            NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
            [defaultCenter postNotificationName:kShuaXinGuoZuoTai object:nil];
            
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
        }
        [weakSelf shuaXinHeaderView];
        [weakSelf.mainTableView reloadData];
        
    } failure:^(id error) {
        
    }];
}

#pragma mark - 配件明细
-(void)postpeiJianMingXiWithModel:(TheWorkModel *)model withTiaoZhua:(BOOL)tiao With:(BaseViewController *)viewColler{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.ordercode forKey:@"ordercode"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/seller_show_parts" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSArray* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSArray class]]) {
            return;
        }
        [_peiJianMingXiArrayCun removeAllObjects];
        [_peiJianMingXiArray removeAllObjects];
        
        if (dataDic.count>0) {
            for (int i = 0; i<dataDic.count; i++) {
                PeiJianListModel *model = [[PeiJianListModel alloc]init];
                [model setDangQIanWIthData:dataDic[i]];
                [_peiJianMingXiArrayCun addObject:model];
                [_peiJianMingXiArray addObject:model];
            }
        }
        
        if (tiao == YES) {
            if (viewColler) {
                PartsSubsidiaryViewController * vc = [[PartsSubsidiaryViewController alloc]init];
                vc.suerViewController = weakSelf;
                vc.ordercode = model.ordercode;
                vc.chuanRuArray = _peiJianMingXiArrayCun;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else
            {
                PartsSubsidiaryViewController * vc = [[PartsSubsidiaryViewController alloc]init];
                vc.suerViewController = weakSelf;
                vc.ordercode = model.ordercode;
                vc.chuanRuArray = _peiJianMingXiArrayCun;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }else{
            [weakSelf.mainTableView reloadData];
        }
        
        
    } failure:^(id error) {
        
    }];
}
#pragma mark - 项目明细
-(void)postrequest_methodMingXiWithModel:(TheWorkModel *)model withTiaoZhua:(BOOL)tiao With:(BaseViewController *)viewColler{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.ordercode forKey:@"ordercode"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/repair_order/seller_show_order" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        [_xiangMuMingXiArrayCun removeAllObjects];
        [_xiangMuMingXiArray removeAllObjects];
        NSArray * orignalArrary = KISDictionaryHaveKey(dataDic, @"orignal");
        if (orignalArrary.count>0) {
            for (int i = 0; i<orignalArrary.count; i++) {
                OrignalModel *model = [[OrignalModel alloc]init];
                [model setDangQIanWIthData:orignalArrary[i]];
                [_xiangMuMingXiArrayCun addObject:model];
                [_xiangMuMingXiArray addObject:model];
            }
        }
        if (tiao == YES) {
            if (viewColler) {
                ConstructionPersonnelViewController * vc = [[ConstructionPersonnelViewController alloc]init];
                vc.suerViewController = weakSelf;
                vc.ordercode = model.ordercode;
                
                if (_xiangMuMingXiArrayCun.count>0) {
                    vc.chuanRuArray = _xiangMuMingXiArrayCun;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }else
                {
                    [weakSelf showMessageWindowWithTitle:@"请先添加项目" point:self.view.center delay:1];
                }
                
            }else
            {
                ProjectDetailsViewController * vc = [[ProjectDetailsViewController alloc]init];
                vc.suerViewController = weakSelf;
                vc.ordercode = model.ordercode;
                vc.chuanRuArray = _xiangMuMingXiArrayCun;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }else{
            [weakSelf.mainTableView reloadData];
        }
        
        
    } failure:^(id error) {
        
    }];
}
#pragma mark - 故障描述
-(void)postRequest_methodWithModel:(TheWorkModel *)model{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.ordercode forKey:@"ordercode"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/descript" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NPrintLog(@"order/order_queue/descript");
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        NSString *descript = KISDictionaryHaveKey(dataDic, @"descript");
        weakSelf.orderDetailHeaderView.weiXiuFAnLabel.text = descript;
        
    } failure:^(id error) {
        
    }];
}

-(void)setrequest_methodwithOrdercodevarchar:(TheWorkModel *)model{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.ordercode forKey:@"ordercode"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/queue_order_info" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSDictionary* dataDic = kParseData(responseObject);
        if (![dataDic isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        [weakSelf.zhuModel setDangQIanWIthData:dataDic];
        [weakSelf shuaXinHeaderView];
        
        [weakSelf.mainTableView reloadData];
        
    } failure:^(id error) {
        
    }];
}

-(void)shuaXinHeaderView
{
    Order_info *model = (Order_info *)self.zhuModel.order_info;
    [self.orderDetailHeaderView.topMianImageView  sd_setImageWithURL:[NSURL URLWithString:model.brand_img] placeholderImage:DJImageNamed(@"")];
    self.orderDetailHeaderView.topCarNumberLa.text = model.car_number;
    self.orderDetailHeaderView.stateImageView.image = DJImageNamed(@"waiting_repair");
    self.orderDetailHeaderView.topShuoMLabel.text = model.cars_spec;
    self.orderDetailHeaderView.topStateLabel.text = model.status;
    self.orderDetailHeaderView.topLeiXinLabel.text = model.class_name;
    self.orderDetailHeaderView.timeLabel.text = model.add_time;
    
    self.orderDetailHeaderView.erWeiMaImageView.image  = [SuccessfulOrderViewController qrCodeImageWithContent:model.order_url codeImageSize:180 red:0 green:0.658 blue:1];
    self.orderDetailHeaderView.dingDanText.text = model.ordercode;
    
    if ([self.zhuModel.is_lock integerValue] == 0) {
        self.orderDetailHeaderView.suoDanSwitch.on = NO;
    }else
    {
        self.orderDetailHeaderView.suoDanSwitch.on = YES;
    }
    
    UILabel *label1 = [self.orderDetailHeaderView viewWithTag:4001];
    label1.text = KISDictionaryHaveKey(self.zhuModel.seller, @"real_name");
    
    UILabel *label2 = [self.orderDetailHeaderView viewWithTag:4003];
    label2.text = KISDictionaryHaveKey(self.zhuModel.inspector, @"staff_name");
    
    NSString *aitNumeStr = @"";
    if ([KISDictionaryHaveKey(self.zhuModel.ait, @"num")integerValue]>0) {
        aitNumeStr = [NSString stringWithFormat:@"(%@)",KISDictionaryHaveKey(self.zhuModel.ait, @"num")];
        self.orderDetailHeaderView.aitDianJiLel.text = @"查看";
    }else{
        self.orderDetailHeaderView.aitDianJiLel.text = @"0";
    }
    UILabel *label3 = [self.orderDetailHeaderView viewWithTag:4002];
    label3.text = aitNumeStr;
    
    RTLabelComponentsStructure *components = [RCLabel extractTextStyle:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.zhuModel.ait, @"massage")]];
    self.orderDetailHeaderView.aitXianShiLabel.componentsAndPlainText = components;
    NSInteger colorIndex = [KISDictionaryHaveKey(self.zhuModel.ait, @"color") integerValue];
    
    if (colorIndex == 0) {
        self.orderDetailHeaderView.aitXianShiLabel.textColor = kRGBColor(235, 80, 100);
        self.orderDetailHeaderView.aitImageView.image = DJImageNamed(@"04_prompt");
    }else{
        self.orderDetailHeaderView.aitXianShiLabel.textColor = kRGBColor(130, 177, 82);
        self.orderDetailHeaderView.aitImageView.image = DJImageNamed(@"04_prompt_green");
    }
}



@end
