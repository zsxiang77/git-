//
//  LearningCenterCellTableViewCell.h
//  cheDianZhang
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LearningModel.h"
@interface LearningCenterCellTableViewCell : UITableViewCell
{
    UIImageView*leftuImgView;
    UIImageView*zuixinImgView;
    UIImageView* dianzanImgView;
    UILabel *titleUilable;
    UILabel *zhujiangUilable;
    UILabel *redioshuUilable;
    UILabel*dianzanCount;
    UILabel*jiageLable;
    UIImageView *shoucangImgView;
}
@property (nonatomic, strong) void (^changePartst)(LearningModel *model,NSIndexPath*index);
@property(nonatomic,strong)LearningModel *zhuModel;
@property(nonatomic,strong)NSIndexPath*indexPath;
-(void)refleshData:(LearningModel*)dict withIndex:(NSIndexPath*)index;
@end
