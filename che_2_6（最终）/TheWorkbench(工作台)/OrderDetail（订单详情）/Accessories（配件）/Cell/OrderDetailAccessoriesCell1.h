//
//  OrderDetailAccessoriesCell1.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/7.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@interface OrderDetailAccessoriesCell1 : UITableViewCell<UITextFieldDelegate>
{
    UILabel         *titleLabel;
    
    UILabel         *bianHaoLabel;
    UILabel         *kuCunLabel;
    UILabel         *danWeiLabel;
    
    UITextField     *gongShiTextField;
    UITextField     *gongShiFeiTextField;
}

@property(nonatomic,strong)OrderDetailPartsModel *model;

@property(nonatomic,strong)void (^baoCunChcickBlock)(void);

-(void)refeleseWithModel:(OrderDetailPartsModel *)model;

@end
