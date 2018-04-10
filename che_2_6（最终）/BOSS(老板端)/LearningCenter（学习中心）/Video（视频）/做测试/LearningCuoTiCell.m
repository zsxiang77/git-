//
//  LearningCuoTiCell.m
//  cheDianZhang
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningCuoTiCell.h"

@implementation LearningCuoTiCell

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


-(void)shuaXinData:(NSString *)daAnAtr withZhengQueStr:(NSString *)zhengQueStr withWrongStr:(NSString *)wrongStr witINdex:(NSInteger)row
{
    NSString *numStr = @"";
    if (row == 0) {
        numStr = @"A";
    }else if (row == 1) {
        numStr = @"B";
    }else if (row == 2) {
        numStr = @"C";
    }else if (row == 3) {
        numStr = @"D";
    }else if (row == 4) {
        numStr = @"E";
    }else if (row == 5) {
        numStr = @"F";
    }else if (row == 6) {
        numStr = @"G";
    }else{
        numStr = @"H";
    }
    
    titleLabe.text = daAnAtr;
    titleLabe.textColor = kRGBColor(102, 102, 102);
    duiHaoImageView.hidden = YES;
    xuanZhongImageView.image = DJImageNamed(@"Boss_xuanZhong_no");
    NSArray *zhengQueStrArray = [zhengQueStr componentsSeparatedByString:@","];
    NSArray *wrongStrArray = [wrongStr componentsSeparatedByString:@","];
    if (zhengQueStrArray.count>0) {
        for (int i = 0; i<zhengQueStrArray.count; i++) {
            if ([numStr isEqualToString:zhengQueStrArray[i]]) {
                titleLabe.textColor = kRGBColor(0, 153, 0);
                duiHaoImageView.hidden = NO;
            }
        }
    }
    if (wrongStrArray.count>0) {
        for (int i = 0; i<wrongStrArray.count; i++) {
            if ([numStr isEqualToString:wrongStrArray[i]]) {
                titleLabe.textColor = kRGBColor(208, 2, 27);
                xuanZhongImageView.image = DJImageNamed(@"Boss_xuanZhong");
            }
        }
    }
    
}

@end
