//
//  JobBoardScreeningCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/17.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 task_type 0:客户流失 1:异常工单 2:差评回访 3:预约跟进 4:保养到期 5:保险到期 6:年检提醒 7:生日回访 8:询价追踪
 9:工单回访 10:全部任务
 */

@interface JobBoardScreeningCell : UICollectionViewCell


@property(nonatomic,strong)UIImageView *mianImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *numberLabel;
@property(nonatomic,strong)UILabel *line1;
@property(nonatomic,strong)UILabel *line2;

-(void)refilshData:(NSDictionary *)dict;

@end
