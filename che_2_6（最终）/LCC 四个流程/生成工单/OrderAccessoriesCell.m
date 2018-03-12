//
//  OrderAccessoriesCell.m
//  测试
//
//  Created by lcc on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "OrderAccessoriesCell.h"
#import "CreatOrderFlowChartManager.h"
@interface OrderAccessoriesCell()
@property (nonatomic, strong) UILabel *leftLB;
@property (nonatomic, strong) UILabel *rightLB;
@end

@implementation OrderAccessoriesCell

-(void)setUpViews{
    self.leftLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        //PingFangSC-Regular
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        lb.textColor = UIColorHex(#858488);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.centerY.mas_offset(0);
        }];
        lb;
    });
    
    self.rightLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        //PingFangSC-Regular
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        lb.textColor = UIColorHex(#4A4A4A);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.centerY.mas_offset(0);
        }];
        lb;
    });
}

-(void)bingViewModel:(id)viewModel{
    PartsModel *model = viewModel;
    self.leftLB.text = [NSString stringWithFormat:@"%@*%@",model.partsName,model.num];
    self.rightLB.text = [NSString stringWithFormat:@"%.2f",[model.unitPrice floatValue] * [model.num floatValue]];
}

@end
