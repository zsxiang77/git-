//
//  OrderDetailAccessoriesCell1.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/7.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@interface OrderDetailAccessoriesCell1 : UITableViewCell
{
    UILabel         *titleLabel;
    
    UILabel         *bianHaoLabel;
    UILabel         *kuCunLabel;
    UILabel         *danWeiLabel;
    
    UIButton     *gongShiTextBt;
    UIButton     *gongShiFeiTextBt;
}

@property(nonatomic,strong)void (^gongShiTextBtChickBlock)(void);
@property(nonatomic,strong)void(^gongShiTextBtnField)(void);

@property(nonatomic,strong)OrderDetailPartsModel *model;

@property(nonatomic,strong)void (^baoCunChcickBlock)(void);

-(void)refeleseWithModel:(OrderDetailPartsModel *)model;

@end
