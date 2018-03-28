//
//  CustomerInformationVC.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/31.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "XiMeiXinZengZuiZongModel.h"
#import "CustomerInformationYYueModel.h"
#import "CustomerInformationYYueView.h"

@interface CustomerInformationVC : BaseViewController
{
    UILabel *yuYueTitleLabel;
    UILabel *yuYueTimeLabel;
    UILabel *yuYueTimeLabel2;
    UILabel *yuYueLeiXLabel2;
    UILabel *yuYueSYuLabel2;
    UIView *yuYueQieHView;
    UIImageView *yuYueXiaoImageView;
    UILabel *yuYueTitleXiaoLabel;
}

@property(nonatomic,strong)CustomerInformationYYueView *fuCengView;

@property(nonatomic,strong)Car_zongModel *zuiZhongModel;
@property(nonatomic,strong)XiMeiXinZengZuiZongModel *xiMeiZuiZhongModel;

@property(nonatomic,strong)CustomerInformationYYueModel *mainModel;
@property(nonatomic,assign)BOOL shiFouYanYong;


@property(nonatomic,strong)NSDictionary *userInformetionDict;

@property(nonatomic,assign)BOOL shiFouWeiXiu;//是否维修

@end
