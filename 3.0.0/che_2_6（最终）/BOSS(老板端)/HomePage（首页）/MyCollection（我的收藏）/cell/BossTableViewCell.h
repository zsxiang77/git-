//
//  BossTableViewCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BossShouCangModel.h"
@interface BossTableViewCell : UITableViewCell
{
    UIImageView   *youImageView;
    UILabel   *titleLabel;
    UILabel *titleDate;
}
-(void)refleshData:(BossShouCangModel *)dict;
@end
