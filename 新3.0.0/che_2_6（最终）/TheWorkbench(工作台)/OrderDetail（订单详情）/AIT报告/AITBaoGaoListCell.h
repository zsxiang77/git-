//
//  AITBaoGaoListCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/3.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AITBaoGaoListCell : UITableViewCell
{
    UILabel    *titleLabel;
    UILabel    *dateLabel;
}

-(void)refeleseWithModel:(NSDictionary *)model withStr:(NSString *)str;

@end
