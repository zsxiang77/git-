//
//  StorePeiJianCell.h
//  cheDianZhang
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StorePeiJianModel.h"
@interface StorePeiJianCell : UITableViewCell
{
    UIImageView * touImgview;
    UILabel * nameLable;
    UILabel * jiageLable;
    UILabel * peijianpaiLable;
    UILabel * peijianBiLable;
    UILabel * shunxuLable;
}
-(void)refleshData:(listPeiJianModel *)dict dieIndex:(NSIndexPath*)index;
@end
