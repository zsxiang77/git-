//
//  OrderChePaiCell.m
//  测试
//
//  Created by lcc on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "OrderChePaiCell.h"
@interface OrderChePaiCell()
@property (nonatomic, strong) UILabel *carPlateNumLB;
@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UILabel *numLB;
@end
@implementation OrderChePaiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpViews{
    
    UIView *backView = ({
        UIView *v = [[UIView alloc]init];
        [self.contentView addSubview:v];
        v.layer.cornerRadius = 2.5;
        v.layer.masksToBounds = YES;
        v.backgroundColor = UIColorHex(#007AFF);
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25);
            make.left.mas_equalTo(13);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(94);
        }];
        v;
    });
    
    self.carPlateNumLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [backView addSubview:lb];
        lb.layer.cornerRadius = 2.5;
        lb.layer.masksToBounds = YES;
        lb.layer.borderColor = UIColorHex(#FFFFFF).CGColor;
        lb.layer.borderWidth = 0.5;
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
        lb.textColor = UIColorHex(#FFFFFF);
        lb.textAlignment = NSTextAlignmentCenter;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsMake(3, 3, 3, 3));
        }];
        lb.text = @"";
        lb;
    });

    self.numLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:14];
        lb.textColor = UIColorHex(#4A4A4A);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.centerY.mas_offset(0);
        }];
        lb.text = @"";
        lb;
    });
    
    self.nameLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCRegularFontOfSize:12];
        lb.textColor = UIColorHex(#858488);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.numLB.mas_left).mas_offset(-5);
            make.centerY.mas_offset(0);
        }];
        lb.text = @"";
        lb;
    });

    UIView *lineView = ({
        UIView *v = [[UIView alloc]init];
        [self.contentView addSubview:v];
        v.backgroundColor = UIColorHex(#F0F0F0);
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        v;
    });
}

-(void)bingViewModel:(id)viewModel{
    self.carPlateNumLB.text = [UserInfo shareInstance].chuanCheArrayStr;
}
@end
