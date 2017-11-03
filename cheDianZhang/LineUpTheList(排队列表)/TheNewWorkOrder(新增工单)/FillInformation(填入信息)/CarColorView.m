//
//  CarColorView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/12.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "CarColorView.h"
#import "CheDianZhangCommon.h"

@implementation CarColorView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.5);
        UIView *mainView = [[UIView alloc]init];
        mainView.backgroundColor = [UIColor whiteColor];
        [mainView.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [mainView.layer setCornerRadius:3];
        [self addSubview:mainView];
        [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(120);
        }];
        
        UIView *colorbackView = [[UIView alloc]init];
        [colorbackView.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [colorbackView.layer setCornerRadius:3];
        [colorbackView.layer setBorderWidth:0.5];//设置边界的宽度
        //设置按钮的边界颜色
        [colorbackView.layer setBorderColor:[kRGBColor(180, 180, 180) CGColor]];
        [mainView addSubview:colorbackView];
        [colorbackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(35);
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"车身颜色";
        [colorbackView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.centerY.mas_equalTo(colorbackView);
            make.width.mas_equalTo(80);
        }];
        
        self.colorTextFild = [[UITextField alloc]init];
        self.colorTextFild.placeholder = @"请填写车身颜色";
        [colorbackView addSubview:self.colorTextFild];
        [self.colorTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(90);
            make.centerY.mas_equalTo(colorbackView);
            make.right.mas_equalTo(-10);
        }];
        
        self.okTiJiaoBt = [[UIButton alloc]init];
        [self.okTiJiaoBt setTitle:@"确定" forState:(UIControlStateNormal)];
        [self.okTiJiaoBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.okTiJiaoBt.backgroundColor = kNavBarColor;
        [mainView addSubview:self.okTiJiaoBt];
        [self.okTiJiaoBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(colorbackView.mas_bottom).mas_equalTo(10);
            make.height.mas_equalTo(35);
        }];
        
        
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(vietualViewTouch:)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

-(void)vietualViewTouch:(id)sender
{
    [self.colorTextFild resignFirstResponder];
//    self.colorTextFild.text = @"";
//    self.hidden = YES;
}


@end
