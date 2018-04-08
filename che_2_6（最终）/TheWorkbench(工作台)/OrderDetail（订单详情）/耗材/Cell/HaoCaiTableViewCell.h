//
//  HaoCaiTableViewCell.h
//  cheDianZhang
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
#import "XiMeiNewOrdersErModel.h"
@interface HaoCaiTableViewCell : UITableViewCell<UITextFieldDelegate>
{
    UILabel         *titleLabel;

    
    UILabel         *shuliangLabel;
    UILabel         *jiageLabel;
    UILabel         *bianmaFeiLabel;
    UILabel         *shuxingLabel;
    UILabel         *danweiLable;
    
    UIButton     *shuliangTextBt;
    UIButton     *jiageTextBt;
}
@property(nonatomic,strong)void (^shuliangTextBtChickBlock)(Service_commods *model);
@property(nonatomic,strong)void(^jiageTextBtnField)(Service_commods *model);

@property(nonatomic,strong)Service_commods *model;

@property(nonatomic,strong)void (^baoCunChcickBlock)(void);

-(void)refeleseWithModel:(Service_commods *)model;
@end
