//
//  BossJianCeListTableViewCell.m
//  cheDianZhang
//
//  Created by apple on 2018/4/14.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BossJianCeListTableViewCell.h"

@implementation BossJianCeListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self==[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        xuanZhongImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:xuanZhongImageView];
        [xuanZhongImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(35);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(20);
        }];
        
        titleLabe = [[UILabel alloc]init];
        titleLabe.font = [UIFont systemFontOfSize:16];
        titleLabe.numberOfLines = 2;
        titleLabe.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:titleLabe];
        [titleLabe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(63);
            make.right.mas_lessThanOrEqualTo(-40);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        duiHaoImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"duihao")];
        duiHaoImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:duiHaoImageView];
        [duiHaoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabe.mas_right).mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(15);
        }];
        
    }
    return self;
}
-(void)setData:(NSString *)daAnstr withZhengque:(NSString *)zhengqueStr withWrong:(NSString *)wrongStr withInIt:(NSInteger)row
{
    NSString * strmun = @"";
    if(row == 0){
        strmun = @"A";
    }else if(row == 1){
        strmun = @"B";
    }else if(row == 2){
        strmun = @"C";
    }else if(row == 3){
        strmun = @"D";
    }else if(row == 4){
        strmun = @"E";
    }else if(row == 5){
        strmun = @"F";
    }else if(row == 6){
        strmun = @"G";
    }else{
        strmun = @"H";
    }
    titleLabe.text = daAnstr;
    titleLabe.textColor = kRGBColor(102, 102, 102);
    duiHaoImageView.hidden = YES;
    xuanZhongImageView.image = DJImageNamed(@"Boss_xuanZhong_no");
    NSArray *zhengQueStrArray = [zhengqueStr componentsSeparatedByString:@","];
    NSArray *wrongStrArray = [wrongStr componentsSeparatedByString:@","];
    if (zhengQueStrArray.count>0) {
        for (int i = 0; i<zhengQueStrArray.count; i++) {
            if ([strmun isEqualToString:zhengQueStrArray[i]]) {
                titleLabe.textColor = kRGBColor(0, 153, 0);
                duiHaoImageView.hidden = NO;
            }
        }
    }
    if (wrongStrArray.count>0) {
        for (int i = 0; i<wrongStrArray.count; i++) {
            if ([strmun isEqualToString:wrongStrArray[i]]) {
                titleLabe.textColor = kRGBColor(208, 2, 27);
                xuanZhongImageView.image = DJImageNamed(@"Boss_xuanZhong");
            }
        }
    }
}
@end
