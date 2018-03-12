//
//  OrderDetailAccessoriesCell2.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/7.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@interface OrderDetailAccessoriesCell2 : UITableViewCell
{
    UILabel         *titleLabel;
    
    UILabel         *bianHaoLabel;
    UILabel         *kuCunLabel;
    UILabel         *danWeiLabel;
    
    UILabel         *numberLabel;
    UILabel         *jiaGeLabel;
}
@property(nonatomic,strong)OrderDetailPartsModel *model;

@property(nonatomic,strong)void (^bianJiBTChcickBlock)(void);

-(void)refeleseWithModel:(OrderDetailPartsModel *)model;

@end
