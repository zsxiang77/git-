//
//  AITListCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/11/8.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheDianZhangCommon.h"
#import "SWTableViewCell.h"

@interface AITListCell : SWTableViewCell


@property(nonatomic,strong)UILabel  *numberLabel;
@property(nonatomic,strong)UILabel  *serialLabel;
@property(nonatomic,strong)UILabel  *verifyLabel;
@property(nonatomic,strong)NSDictionary *chuZhiDict;

@end
