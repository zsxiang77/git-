//
//  BossJianCeListTableViewCell.h
//  cheDianZhang
//
//  Created by apple on 2018/4/14.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BossJianCeListTableViewCell : UITableViewCell
{
    UIImageView  *xuanZhongImageView;
    UILabel      *titleLabe;
    UIImageView  *duiHaoImageView;
}
-(void)setData:(NSString *)daAnstr withZhengque:(NSString *)zhengqueStr withWrong:(NSString *)wrongStr withInIt:(NSInteger)row;
@end
