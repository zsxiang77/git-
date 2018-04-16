//
//  CustomerInformationYYueCell2.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/13.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "CustomerInformationYYueCell2.h"

@implementation CustomerInformationYYueCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        mainView = [[UIView alloc]init];
        mainView.backgroundColor = kRGBColor(250, 250, 250);
        [mainView.layer setMasksToBounds:YES];
        [mainView.layer setBorderColor:kRGBColor(217, 217, 217).CGColor];
        [mainView.layer setBorderWidth:1];
        [self.contentView addSubview:mainView];
        [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

-(void)shuxinCellGuZhang:(NSArray*)model
{
    //删除cell的所有子视图
    while ([mainView.subviews lastObject] != nil)
    {
        [(UIView*)[mainView.subviews lastObject] removeFromSuperview];
    }
    
    for (int i = 0; i<model.count; i++) {
        NSDictionary *dic = model[i];
        UILabel*lable=[[UILabel alloc]init];
        lable.font = [UIFont systemFontOfSize:15];
        lable.textColor = kRGBColor(51, 51, 51);
        [mainView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(38);
            make.top.mas_equalTo(i*38);
        }];
        lable.text=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"info")];
        if (model.count>=2) {
            UILabel*line=[[UILabel alloc]init];
            line.backgroundColor=kRGBColor(217, 217, 217);
            [mainView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-10);
                make.height.mas_equalTo(0.5);
                make.top.mas_equalTo(38+i*38);
            }];
            line.hidden = NO;
            if (i== model.count-1) {
                line.hidden = YES;
            }
        }

    }
    
}

@end
