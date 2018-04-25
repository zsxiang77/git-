//
//  StoreRenWuCell.m
//  cheDianZhang
//
//  Created by apple on 2018/4/21.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreRenWuCell.h"

@implementation StoreRenWuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self ==[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        fenleiLable = [[UILabel alloc]init];
        fenleiLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:fenleiLable];
        [fenleiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(kWindowW/6);
        }];
        
        yiwanChengLable = [[UILabel alloc]init];
         yiwanChengLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:yiwanChengLable];
        [yiwanChengLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(kWindowW/6);
            make.width.mas_equalTo(kWindowW/6);
        }];
        
        weiWanchengLable = [[UILabel alloc]init];
         weiWanchengLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:weiWanchengLable];
        [weiWanchengLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(kWindowW/6*2);
            make.width.mas_equalTo(kWindowW/6);
        }];
        guoqiLable = [[UILabel alloc]init];
          guoqiLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:guoqiLable];
        [guoqiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(kWindowW/6*3);
            make.width.mas_equalTo(kWindowW/6);
        }];
        zongshuLable = [[UILabel alloc]init];
         zongshuLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:zongshuLable];
        [zongshuLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(kWindowW/6*4);
            make.width.mas_equalTo(kWindowW/6);
        }];
        yuyueLable = [[UILabel alloc]init];
        yuyueLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:yuyueLable];
        [yuyueLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(kWindowW/6*5);
            make.width.mas_equalTo(kWindowW/6);
        }];
    }
    return self;
}
-(void)refleshData:(Task_listModel *)dict dieIndex:(NSIndexPath*)index
{
    if(index.row ==0){
        fenleiLable.font = [UIFont boldSystemFontOfSize:14];
        fenleiLable.text = @"分类";
        yiwanChengLable.font = [UIFont boldSystemFontOfSize:14];
        yiwanChengLable.text = @"已完成";
        weiWanchengLable.font = [UIFont boldSystemFontOfSize:14];
        weiWanchengLable.text = @"未完成";
        guoqiLable.font = [UIFont boldSystemFontOfSize:14];
        guoqiLable.text = @"过期";
        zongshuLable.font = [UIFont boldSystemFontOfSize:14];
        zongshuLable.text = @"总数";
        yuyueLable.font = [UIFont boldSystemFontOfSize:14];
        yuyueLable.text = @"预约";
    }else{
        fenleiLable.text = dict.task_name;
        yiwanChengLable.text = dict.done;
        weiWanchengLable.text =dict.undone;
        guoqiLable.text =dict.inval;
        zongshuLable.text =dict.total;
        yuyueLable.text =dict.appoint;
    }
}
@end
