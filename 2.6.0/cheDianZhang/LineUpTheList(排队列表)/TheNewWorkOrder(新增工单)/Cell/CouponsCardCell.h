//
//  CouponsCardCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/11.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponsCardCell : UITableViewCell


@property(nonatomic,strong)UIView *beiJingView;
@property(nonatomic,strong)UIImageView *beiJingImageView;

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *tuPianLabel;
@property(nonatomic,strong)UILabel *huiSeLabel;
@property(nonatomic,strong)UILabel *heiSeLabel;

-(void)refreshViewWithDate:(NSDictionary *)dict;

@end
