//
//  DetailZhiJianCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/15.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailZhiJianCell : UITableViewCell
{
    UILabel *zuoLabel;
    UILabel *youLabel;
    UILabel *line;
}

-(void)refleshData:(NSDictionary *)dict whitRow:(NSInteger)row;

@end
