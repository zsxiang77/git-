//
//  ProjectDetailSearchCell.h
//  cheDianZhang
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectModeChangYong.h"
@interface ProjectDetailSearchCell : UITableViewCell
{
    UILabel * titleLable;
    UILabel * gongshiLable;
    UILabel * gonsghiFeiLable;
}
-(void)refelesePeiJianWithModel:(NSDictionary *)model;
@end
