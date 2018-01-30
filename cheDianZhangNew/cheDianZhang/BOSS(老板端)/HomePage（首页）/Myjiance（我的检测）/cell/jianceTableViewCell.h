//
//  jianceTableViewCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "jianceModel.h"
#import "UIImageView+WebCache.h"
@interface jianceTableViewCell : UITableViewCell
{
    UILabel*titleUilable;
    UILabel*codeUIlable;
    
    UIImageView*mainimgView;
}
-(void)refleshData:(jianceModel *)dict;
@end
