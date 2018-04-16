//
//  SwitchRolesCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "SwitchRolesCell.h"
#import "UIImageView+WebCache.h"

@implementation SwitchRolesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        touImageView = [[UIImageView alloc]init];
        [touImageView.layer setMasksToBounds:YES];
        [touImageView.layer setCornerRadius:18];
        [self.contentView addSubview:touImageView];
        [touImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(9);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(36);
        }];
        
        nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont systemFontOfSize:18];
        nameLabel.textColor = kRGBColor(34, 34, 34);
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(55);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        xuanZhongImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"gou_black")];
        [self.contentView addSubview:xuanZhongImageView];
        [xuanZhongImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-9);
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(10);
            make.width.mas_equalTo(16);
        }];
        
    }
    return self;
}

-(void)refeleseWithModel:(NSDictionary *)dict
{
    xuanZhongImageView.hidden = YES;
    [touImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"icon")]]];
    nameLabel.text = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dict, @"role_name")];
    if ([[UserInfo shareInstance].userPositions[0] integerValue] == [KISDictionaryHaveKey(dict, @"role_id") integerValue]) {
        xuanZhongImageView.hidden = NO;
    }
}

@end
