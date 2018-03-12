//
//  FillVINCodeCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/28.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FillVINCodeCell : UITableViewCell
{
    UILabel *chePaiLabel;
    UILabel *vINLabel;
}

-(void)freshdata:(NSDictionary *)dict pipei:(NSString *)str;

@end
