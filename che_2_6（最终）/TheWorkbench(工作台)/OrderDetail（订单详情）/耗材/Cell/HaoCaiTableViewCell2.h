//
//  HaoCaiTableViewCell2.h
//  cheDianZhang
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XiMeiNewOrdersErModel.h"
@interface HaoCaiTableViewCell2 : UITableViewCell
{
    UILabel         *titleLabel;
    
    UILabel         *shuliangLabel;
    UILabel         *jiageLabel;
    UILabel         *bianmaFeiLabel;
    UILabel         *shuxingLabel;
    UILabel         *danweiLable;
    UIButton        *bianJiBT;
    UIImageView     *bianJiaTu;
}
@property(nonatomic,strong)Service_commods *model;

@property(nonatomic,strong)void (^bianJiBTChcickBlock)(void);

-(void)refeleseWithModel:(Service_commods *)model;
@end
