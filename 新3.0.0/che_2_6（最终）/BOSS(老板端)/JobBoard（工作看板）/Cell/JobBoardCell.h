//
//  JobBoardCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/15.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobBoardModel.h"

@interface JobBoardCell : UITableViewCell
{
    UIImageView   *zuoImageView;
    UILabel   *titleLabel;
    UIImageView   *jingJiImageView;
    UIImageView   *zhongYaoImageView;
    
    UILabel   *rightLabel;
    UILabel   *rightXiaLabel;
    
    UILabel   *chePaiLabel;
    UILabel   *cheLeiXinLabel;
    
//    UIImageView   *nameImageView;
    UILabel   *nameLabel;
}

-(void)refleshData:(JobBoardModel *)dict;

@end
