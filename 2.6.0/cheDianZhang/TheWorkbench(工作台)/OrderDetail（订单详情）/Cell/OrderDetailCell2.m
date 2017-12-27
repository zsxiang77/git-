//
//  OrderDetailCell2.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/21.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "OrderDetailCell2.h"
#import "CheDianZhangCommon.h"

@implementation OrderDetailCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kRGBColor(244, 245, 246);
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 40)];
        view1.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:view1];
        
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 40, kWindowW, 40)];
        view2.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view2];
        
        UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 81, kWindowW, 40)];
        view3.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view3];
        
        self.biaoTiLabel = [[UILabel alloc]init];
        [view1 addSubview:self.biaoTiLabel];
        [self.biaoTiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(view1);
        }];
        
        self.benDiLael1 = [[UILabel alloc]init];
        self.benDiLael1.font = [UIFont systemFontOfSize:13];
        [view2 addSubview:self.benDiLael1];
        [self.benDiLael1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(view2);
        }];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        [view2 addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.benDiLael1.mas_right).mas_equalTo(15);
            make.centerY.mas_equalTo(view2);
        }];
        
        
        self.benDiLael2 = [[UILabel alloc]init];
        self.benDiLael2.font = [UIFont systemFontOfSize:13];
        [view3 addSubview:self.benDiLael2];
        [self.benDiLael2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(view3);
        }];
        
        self.gongShiLabel = [[UILabel alloc]init];
        self.gongShiLabel.font = [UIFont systemFontOfSize:13];
        [view3 addSubview:self.gongShiLabel];
        [self.gongShiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.benDiLael2.mas_right).mas_equalTo(0);
            make.centerY.mas_equalTo(view3);
        }];
        
        self.benDiLael3 = [[UILabel alloc]init];
        self.benDiLael3.font = [UIFont systemFontOfSize:13];
        [view3 addSubview:self.benDiLael3];
        [self.benDiLael3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.gongShiLabel.mas_right).mas_equalTo(15);
            make.centerY.mas_equalTo(view3);
        }];
        self.gongShiFeiLabel = [[UILabel alloc]init];
        self.gongShiFeiLabel.font = [UIFont systemFontOfSize:13];
        [view3 addSubview:self.gongShiFeiLabel];
        [self.gongShiFeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.benDiLael3.mas_right).mas_equalTo(0);
            make.centerY.mas_equalTo(view3);
        }];
        
        self.benDiLael4 = [[UILabel alloc]init];
        self.benDiLael4.font = [UIFont systemFontOfSize:13];
        [view3 addSubview:self.benDiLael4];
        [self.benDiLael4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.gongShiFeiLabel.mas_right).mas_equalTo(15);
            make.centerY.mas_equalTo(view3);
        }];
        
        
        self.nuberLaber = [[UILabel alloc]init];
        self.nuberLaber.font = [UIFont systemFontOfSize:13];
        [view3 addSubview:self.nuberLaber];
        [self.nuberLaber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.benDiLael4.mas_right).mas_equalTo(0);
            make.centerY.mas_equalTo(view3);
        }];
        
    }
    return self;
}

-(void)refeleseWithModel:(OrignalModel *)model
{
    self.benDiLael1.text = @"施工人员";
    self.benDiLael2.text = @"工时：";
    self.benDiLael3.text = @"工时费：";
    self.biaoTiLabel.text = model.subject;
    if (model.operation.length<=0) {
        self.nameLabel.text = @"未选";
        self.nameLabel.textColor = [UIColor redColor];
    }else{
        self.nameLabel.text = model.operation;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    self.gongShiLabel.text = model.hour;
    self.gongShiFeiLabel.text = model.reality_fee;
}

-(void)refelesePeiJianWithModel:(PeiJianListModel *)model
{
    self.benDiLael1.text = @"编号";
    self.benDiLael2.text = @"库存：";
    self.benDiLael3.text = @"单价：";
    self.benDiLael4.text = @"数量：";
    
    self.biaoTiLabel.text = model.cname;
    self.nameLabel.text = model.parts_id;
    self.gongShiLabel.text = model.count;
    self.gongShiFeiLabel.text = model.parts_fee;
    self.nuberLaber.text = model.parts_num;
}

@end
