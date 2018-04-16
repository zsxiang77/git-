//
//  LearningZuoCell.h
//  cheDianZhang
//
//  Created by apple on 2018/4/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LearningZuoCeShiModel.h"

@interface LearningZuoCell : UITableViewCell
{
    UIButton     *dianJiBt;
    UILabel      *titleLabe;
    LearningZuoCeShiDaAnModel *m_model;
}

@property(nonatomic,strong)void   (^dianJiChickBlock)(LearningZuoCeShiDaAnModel *model);
-(void)shuaXinData:(LearningZuoCeShiDaAnModel *)model;
@end
