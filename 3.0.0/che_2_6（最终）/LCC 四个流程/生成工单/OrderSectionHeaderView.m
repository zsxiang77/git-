//
//  OrderSectionHeaderView.m
//  测试
//
//  Created by lcc on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "OrderSectionHeaderView.h"
#import "OrderSectionModel.h"
@interface OrderSectionHeaderView()
@property (nonatomic, strong) UIImageView *iconImageView;
//@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UILabel *priceLB;
@end
@implementation OrderSectionHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.clipsToBounds = YES;
        [self setUpViews];
    }
    return self;
}

-(void)setUpViews{
    self.iconImageView = ({
        UIImageView *im = [[UIImageView alloc]init];
        [self.contentView addSubview:im];
        im.contentMode = UIViewContentModeScaleAspectFit;
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        im;
    });
    
    self.titleLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [self.contentView addSubview:lb];
        //PingFangSC-Semibold
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
        lb.textColor = UIColorHex(#333333);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(40);
            make.centerY.mas_offset(0);
        }];
        lb;
    });
//    21+14
    self.rightView = [UIView new];
    [self.contentView addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_offset(0);
        make.height.mas_equalTo(21);
    }];
    
    UIImageView *im = ({
        UIImageView *im = [[UIImageView alloc]init];
        [self.rightView addSubview:im];
        im.image = [UIImage imageNamed:@"人民币图标"];
        im.contentMode = UIViewContentModeScaleAspectFit;
        [im mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(11.5, 11.5));
        }];
        im;
    });
//    PingFangSC-Semibold
    self.priceLB = ({
        UILabel *lb = [[UILabel alloc]init];
        [_rightView addSubview:lb];
        lb.font = [UIFont pf_PingFangSCSemiboldFontOfSize:15];
        lb.textColor = UIColorHex(#FF001F);
        lb.textAlignment = NSTextAlignmentLeft;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(im.mas_right).mas_equalTo(3);
        }];
        lb;
    });

    UIView *lineView = ({
        UIView *v = [[UIView alloc]init];
        [self.contentView addSubview:v];
        v.backgroundColor = UIColorHex(#F0F0F0);
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.right.mas_equalTo(0);
            make.top.mas_offset(0);
        }];
        v;
    });

}

-(void)bingViewModel:(id)viewModel{
    OrderSectionModel *model = viewModel;
    self.iconImageView.image = [UIImage imageNamed:model.imageName];
    self.titleLB.text = model.title;
    if (LC_isStrEmpty(model.price)) {
        self.rightView.hidden = YES;
    }else{
        self.rightView.hidden = NO;
        self.priceLB.text = model.price;
    }
};

@end
