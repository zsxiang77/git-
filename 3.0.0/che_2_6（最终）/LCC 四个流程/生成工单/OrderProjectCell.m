//
//  OrderProjectCell.m
//  测试
//
//  Created by lcc on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "OrderProjectCell.h"

@interface OrderProjectCell()
@property (nonatomic, strong) UILabel *leftLB;
@property (nonatomic, strong) UILabel *rightLB;
@end

@implementation OrderProjectCell

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

-(void)bingViewModel:(id)viewModel {
    ProjectModel *model = viewModel;
    self.leftLB.text = [NSString stringWithFormat:@"%@*%@",model.projectName,model.time];
    self.rightLB.text = [NSString stringWithFormat:@"%.2f",[model.price floatValue] * [model.time floatValue]];  //model.price;
}

@end
