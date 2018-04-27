//
//  StoreCellHeaderView.m
//  cheDianZhang
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreCellHeaderView.h"

@implementation StoreCellHeaderView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        UIView *shangview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW,130/2)];
        [self  addSubview:shangview];
        UILabel * line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [shangview addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
         touImgview = [[UIImageView alloc]init];
        [shangview addSubview:touImgview];
        [touImgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(58/2);
            make.centerY.mas_equalTo(shangview);
            make.height.mas_equalTo(56/2);
            make.width.mas_equalTo(66/2);
        }];
        shunxuLable = [[UILabel alloc]init];
        shunxuLable.font =[UIFont systemFontOfSize:17];
        [shunxuLable setTextColor:kRGBColor(74, 74, 74)];
        [shangview addSubview:shunxuLable];
        [shunxuLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(76/2);
            make.centerY.mas_equalTo(shangview);
        }];
        
        renYuanimgview = [[UIImageView alloc]init];
        [renYuanimgview.layer setMasksToBounds:YES];
        [renYuanimgview.layer setCornerRadius:18];
        [shangview addSubview:renYuanimgview];
        [renYuanimgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(touImgview.mas_right).mas_equalTo(8);
            make.centerY.mas_equalTo(shangview);
            make.height.mas_equalTo(72/2);
            make.width.mas_equalTo(72/2);
        }];
        
        nameLable= [[UILabel alloc]init];
        nameLable.font =[UIFont systemFontOfSize:16];
        [nameLable setTextColor:kRGBColor(132, 148, 165)];
        [shangview addSubview:nameLable];
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(renYuanimgview.mas_right).mas_equalTo(9);
            make.centerY.mas_equalTo(shangview);
        }];
       
        
    }
    return self;
}

-(void)reloadData
{
    if(self.indexRow == 1){
        touImgview.image = [UIImage imageNamed:@"huangGuan1"];
        shunxuLable.hidden = YES;
    }else if(self.indexRow ==2){
        touImgview.image = [UIImage imageNamed:@"huangGuan2"];
        shunxuLable.hidden = YES;
    }else if(self.indexRow ==3){
        touImgview.image = [UIImage imageNamed:@"huangGuan3"];
        shunxuLable.hidden = YES;
    }else{
        shunxuLable.hidden = NO;
        shunxuLable.text = [NSString stringWithFormat:@"%ld",self.indexRow];
    }
    nameLable.text = self.modes.real_name;
    [renYuanimgview sd_setImageWithURL:[NSURL URLWithString:self.modes.avatar] placeholderImage:DJImageNamed(@"Boss_fond_beijing_new")];
}
@end
