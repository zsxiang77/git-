//
//  StoresInformationCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/12.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoresInformationCell : UITableViewCell
@property(nonatomic,strong)UILabel *mainLabl;

@property(nonatomic,strong)UILabel *rightLabl;
@property(nonatomic,strong)UIImageView *jianTouImageView;
-(void)shuaXingCellWithZuo:(NSString *)zuoStr withRight:(NSString *)rightStr shiFouErwei:(BOOL)erwei;

@end
