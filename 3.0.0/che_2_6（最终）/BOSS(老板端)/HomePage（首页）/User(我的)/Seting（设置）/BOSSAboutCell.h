//
//  BOSSAboutCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/25.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BOSSAboutCell : UITableViewCell

@property(nonatomic,strong)UIView  *zhongView;
-(void)chuLiData:(NSDictionary *)dict withIndex:(NSInteger)index;
@end
