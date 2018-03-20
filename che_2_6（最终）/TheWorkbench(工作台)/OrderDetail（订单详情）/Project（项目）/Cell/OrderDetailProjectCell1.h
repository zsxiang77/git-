//
//  OrderDetailProjectCell1.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@interface OrderDetailProjectCell1 : UITableViewCell<UITextFieldDelegate>
{
    UILabel         *titleLabel;
    
//    UITextField     *gongShiTextField;
//    UITextField     *gongShiFeiTextField;
    UIButton     *gongShiTextBt;
    UIButton     *gongShiFeiTextBt;
}
@property(nonatomic,strong)void (^gongShiTextBtChickBlock)(void);
@property(nonatomic,strong)void(^gongShiTextBtnField)(void);

@property(nonatomic,strong)OrderDetailSubjectsModel *model;

@property(nonatomic,strong)void (^baoCunChcickBlock)(void);

-(void)refeleseWithModel:(OrderDetailSubjectsModel *)model;

@end
