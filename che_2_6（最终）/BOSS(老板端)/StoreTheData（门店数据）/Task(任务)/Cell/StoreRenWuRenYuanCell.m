//
//  StoreRenWuRenYuanCell.m
//  cheDianZhang
//
//  Created by apple on 2018/4/22.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreRenWuRenYuanCell.h"

@implementation StoreRenWuRenYuanCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self ==[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        nameLable = [[UILabel alloc]init];
        nameLable.font = [UIFont systemFontOfSize:14];
        nameLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:nameLable];
        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(24);
            make.width.mas_equalTo(kWindowW/3);
        }];
        
        daodianLable = [[UILabel alloc]init];
        daodianLable.font = [UIFont systemFontOfSize:14];
         daodianLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:daodianLable];
        [daodianLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(kWindowW/3);
            make.width.mas_equalTo(kWindowW/3);
        }];
        
        yuyueLable = [[UILabel alloc]init];
        yuyueLable.font = [UIFont systemFontOfSize:14];
        yuyueLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:yuyueLable];
        [yuyueLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(kWindowW/3*2);
            make.width.mas_equalTo(kWindowW/6);
        }];
       
    }
    return self;
}
-(void)refleshData:(Staff_listModel *)dict dieIndex:(NSIndexPath*)index
{
    if(index.row ==0){
        nameLable.font = [UIFont boldSystemFontOfSize:14];
        nameLable.text = @"姓名";
        daodianLable.font = [UIFont boldSystemFontOfSize:14];
        daodianLable.text = @"到店";
        yuyueLable.font = [UIFont boldSystemFontOfSize:14];
        yuyueLable.text = @"预约";
    }else{
        nameLable.text = dict.real_name;
        daodianLable.text = dict.arrival;
        yuyueLable.text = dict.appoint;
    }
}
@end
