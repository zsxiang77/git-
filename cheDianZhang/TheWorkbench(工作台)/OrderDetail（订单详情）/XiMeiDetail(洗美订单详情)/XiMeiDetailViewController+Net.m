//
//  XiMeiDetailViewController+Net.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "XiMeiDetailViewController.h"
#import "SuccessfulOrderViewController.h"
#import "CarInspectionModel.h"

@implementation XiMeiDetailViewController (Net)

#pragma mark - 上穿施工信息图片

// 获取视频时间
- (CGFloat) getVideoLength:(NSURL *)URL
{
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}

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
//=============================================================

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
        if (self.anNiuStr.length>0) {
            [weakSelf shuaXinHeaderView2];
        }else
        {
            [weakSelf shuaXinHeaderView];
        }
        
        
        [weakSelf.mainTableView reloadData];
        
    } failure:^(id error) {
        
    }];
}

-(void)postZuiHouTiJiao:(TheWorkModel *)model{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:model.ordercode forKey:@"ordercode"];
    NSString *images = @"";
    NSString *video = @"";
    for (int i = 0; i<self.wenTiArray.count; i++) {
        CarInspectionModel *model = self.wenTiArray[i];
        if (model.cunImage) {
            if (images.length<=0) {
                images = model.tuPianNameStr;
            }else
            {
                images = [NSString stringWithFormat:@"%@,%@",images,model.tuPianNameStr];
            }
        }else
        {
            if (video.length<=0) {
                video = model.tuPianNameStr;
            }else
            {
                video = [NSString stringWithFormat:@"%@,%@",video,model.tuPianNameStr];
            }
        }
    }
    [mDict setObject:images forKey:@"images"];
    [mDict setObject:@"" forKey:@"remark"];
    [mDict setObject:video  forKey:@"video"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"order/order_queue/commit_order" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSInteger code = [KISDictionaryHaveKey(responseObject, @"code") integerValue];
        if (code == 200) {
            [weakSelf showMessageWindowWithTitle:@"施工完成" point:self.view.center delay:2];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return ;
        }
        
    } failure:^(id error) {
        
    }];
}


-(void)shuaXinHeaderView
{
    Order_info *model = (Order_info *)self.zhuModel.order_info;
    [self.xiMeiDetailHeaderView.topMianImageView  sd_setImageWithURL:[NSURL URLWithString:model.brand_img] placeholderImage:DJImageNamed(@"ic_launcher")];
    self.xiMeiDetailHeaderView.topCarNumberLa.text = model.car_number;
    if ([model.status isEqualToString:@"待施工"]) {
        self.xiMeiDetailHeaderView.topStateLabel.textColor = kRGBColor(253, 183, 46);
        self.xiMeiDetailHeaderView.stateImageView.image = DJImageNamed(@"waiting_repair");
    }else {
        self.xiMeiDetailHeaderView.topStateLabel.textColor = kRGBColor(114, 183, 95);
        self.xiMeiDetailHeaderView.stateImageView.image = DJImageNamed(@"waiting_statement");
    }
    self.xiMeiDetailHeaderView.topStateLabel.text = model.status;
    self.xiMeiDetailHeaderView.topShuoMLabel.text = model.cars_spec;
    self.xiMeiDetailHeaderView.topLeiXinLabel.text = model.class_name;
    self.xiMeiDetailHeaderView.timeLabel.text = model.add_time;
    
    self.xiMeiDetailHeaderView.erWeiMaImageView.image  = [SuccessfulOrderViewController qrCodeImageWithContent:model.order_url codeImageSize:180 red:0 green:0 blue:1];
    self.xiMeiDetailHeaderView.dingDanText.text = model.ordercode;
    
    [self.xiMeiDetailHeaderView sheZHiBuJuWithXiangMu:self.zhuModel.subjects withHaoCaiArray:self.zhuModel.comm_imgs withSouDan:NO];
    self.mainTableView.tableHeaderView = self.xiMeiDetailHeaderView;
}

-(void)shuaXinHeaderView2
{
    Order_info *model = (Order_info *)self.zhuModel.order_info;
    [self.xiMeiDetailHeaderView2.topMianImageView  sd_setImageWithURL:[NSURL URLWithString:model.brand_img] placeholderImage:DJImageNamed(@"ic_launcher")];
    self.xiMeiDetailHeaderView2.topCarNumberLa.text = model.car_number;
    
    if ([model.status isEqualToString:@"待施工"]) {
        self.xiMeiDetailHeaderView2.topStateLabel.textColor = kRGBColor(253, 183, 46);
        self.xiMeiDetailHeaderView2.stateImageView.image = DJImageNamed(@"waiting_repair");
    }else{
        self.xiMeiDetailHeaderView2.topStateLabel.textColor = kRGBColor(114, 183, 95);
        self.xiMeiDetailHeaderView2.stateImageView.image = DJImageNamed(@"waiting_statement");
    }
    self.xiMeiDetailHeaderView2.topShuoMLabel.text = model.cars_spec;
    self.xiMeiDetailHeaderView2.topStateLabel.text = model.status;
    self.xiMeiDetailHeaderView2.topLeiXinLabel.text = model.class_name;
    self.xiMeiDetailHeaderView2.timeLabel.text = model.add_time;
    
    self.xiMeiDetailHeaderView2.erWeiMaImageView.image  = [SuccessfulOrderViewController qrCodeImageWithContent:model.order_url codeImageSize:180 red:0 green:0 blue:1];
    self.xiMeiDetailHeaderView2.dingDanText.text = model.ordercode;
    
    [self.xiMeiDetailHeaderView2 sheZHiBuJuWithXiangMu:self.zhuModel.subjects withHaoCaiArray:self.zhuModel.comm_imgs withSouDan:YES];
    if ([self.zhuModel.is_lock integerValue] == 0) {
        self.xiMeiDetailHeaderView2.suoDanSwitch.on = NO;
    }else
    {
        self.xiMeiDetailHeaderView2.suoDanSwitch.on = YES;
    }
    self.mainTableView.tableHeaderView = self.xiMeiDetailHeaderView2;
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
            self.zhuModel.is_lock = @"0";
            [weakSelf shuaXinHeaderView2];
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
        }
        
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
            self.zhuModel.is_lock = @"1";
            [weakSelf shuaXinHeaderView2];
        }else
        {
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
        }
        
    } failure:^(id error) {
        
    }];
}

@end
