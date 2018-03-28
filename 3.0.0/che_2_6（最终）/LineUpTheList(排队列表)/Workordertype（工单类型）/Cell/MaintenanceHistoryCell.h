//
//  MaintenanceHistoryCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaintenanceHistoryCell : UITableViewCell
{
    UIView *backView;
    UIImageView *imageBackView;
    
    UILabel *quanImageView;
    UILabel *shangXianImageView;
    UILabel *xiaXianImageView;
}

-(void)refeleseZongCell:(BOOL)shiFouWeiXiu withDict:(NSDictionary *)model withInder:(NSInteger)index withPeiJian:(BOOL)peiJian;



@end
