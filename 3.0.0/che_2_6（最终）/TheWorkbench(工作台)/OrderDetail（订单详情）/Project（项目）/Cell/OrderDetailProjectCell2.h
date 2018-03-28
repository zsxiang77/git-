//
//  OrderDetailProjectCell2.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
@interface OrderDetailProjectCell2 : UITableViewCell
{
    UILabel         *titleLabel;
    
    UILabel         *gongShiLabel;
    UILabel         *gongShiFeiLabel;
    UILabel         *shiGongRenLabel;
}
@property(nonatomic,strong)OrderDetailSubjectsModel *model;

@property(nonatomic,strong)void (^bianJiBTChcickBlock)(void);

@property(nonatomic,strong)void (^paiGongBtChcickBlock)(OrderDetailSubjectsModel *model);

-(void)refeleseWithModel:(OrderDetailSubjectsModel *)model;
@end
