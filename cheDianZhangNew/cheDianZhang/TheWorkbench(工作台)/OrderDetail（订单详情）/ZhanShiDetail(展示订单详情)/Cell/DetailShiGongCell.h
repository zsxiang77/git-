//
//  DetailShiGongCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/15.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"

@interface DetailShiGongCell : UITableViewCell
{
    UILabel *zuoLabel;
    UILabel *youLabel;
}

@property(nonatomic,strong)UILabel *line;

-(void)refleshData:(PeiJianListModel *)dict whitshiFouXian:(BOOL)line;
-(void)refleshDataxianMu:(OrignalModel *)dict whitshiFouXian:(BOOL)line;
-(void)refleshDataXiMei:(NSDictionary *)dict whitshiFouXian:(BOOL)line;

@end
