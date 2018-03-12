//
//  FoundDetailCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/24.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BOSSCheDianZhangCommon.h"
#import "UIImageView+WebCache.h"
#import "FoundDetailModel.h"

@interface FoundDetailCell : UITableViewCell
{
    UIImageView *touImageView;
    UILabel     *nameLabel;
    UILabel     *dateLabel;
    UIImageView *zanImageView;
    UILabel     *zanLabel;
    UILabel     *neiRongLabel;
    UIView      *huiFuView;
    UILabel     *huiFuLabel;
}
@property(nonatomic,strong)FoundDetailListModel *zhuModel;
@property(nonatomic,strong)void (^zanBtChickBlock)(FoundDetailListModel *zhuModel);


-(void)refleshData:(FoundDetailListModel *)dict;
@end
