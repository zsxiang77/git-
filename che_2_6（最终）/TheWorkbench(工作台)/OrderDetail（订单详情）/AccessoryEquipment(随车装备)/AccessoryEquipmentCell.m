//
//  AccessoryEquipmentCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/14.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "AccessoryEquipmentCell.h"

@implementation AccessoryEquipmentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor= [UIColor clearColor];
        UIView *mianView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 45)];
        mianView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:mianView];
        
        self.zuoTitelLabel = [[UILabel alloc]init];
        self.zuoTitelLabel.font = [UIFont systemFontOfSize:13];
        [mianView addSubview:self.zuoTitelLabel];
        [self.zuoTitelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(mianView);
        }];
        
        UILabel *line =[[UILabel alloc]init];
        line.backgroundColor=kLineBgColor;
        [mianView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
        //        self.youLabel = [[UILabel alloc]init];
        //        self.youLabel.font = [UIFont systemFontOfSize:13];
        //        [mianView addSubview:self.youLabel];
        //        [self.youLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.mas_equalTo(-10);
        //            make.centerY.mas_equalTo(mianView);
        //        }];
        //
        //        self.xuanZhongImaheView = [[UIImageView alloc]init];
        //        [self.contentView addSubview:self.xuanZhongImaheView];
        //        [self.xuanZhongImaheView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.mas_equalTo(self.youLabel.mas_left).mas_equalTo(-10);
        //            make.centerY.mas_equalTo(mianView);
        //            make.width.height.mas_equalTo(20);
        //        }];
        self.zuoYouBt = [[FunctionZuoYouBt alloc]initWithFrame:CGRectMake(kWindowW-85-10, (45-30)/2, 171/2, 30) withZuoTitle:@"异常" withYouStr:@"正常"];
        [self.contentView addSubview:self.zuoYouBt];
        [self.zuoYouBt setBuJuOrZhuangTai];
    }
    return self;
}
@end

