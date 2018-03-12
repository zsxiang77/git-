//
//  ModelCarReMenCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheDianZhangCommon.h"
#import "ErMenModel.h"
#import "UIImageView+WebCache.h"

@interface ModelCarReMenCell : UITableViewCell

/**点击跳转*/
@property(nonatomic,strong)void (^userDianJiTiaoZhuan)(NSDictionary *dict);

@property(nonatomic,strong)NSArray *tiaozhuanArray;
- (void) refleshTableCellWith:(NSArray *)array;


@end
