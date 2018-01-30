//
//  ProjectDetailsCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/22.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ProjectDetailsCell.h"
#import "CheDianZhangCommon.h"

@implementation ProjectDetailsCell

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
        
        self.xuanZhongBt = [[UIButton alloc]init];
        [self.xuanZhongBt setImage:DJImageNamed(@"cell_noselect") forState:(UIControlStateNormal)];
        [self.xuanZhongBt setImage:DJImageNamed(@"cell_select") forState:(UIControlStateSelected)];
        [self.xuanZhongBt setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
        [self.xuanZhongBt addTarget:self action:@selector(xuanZhongBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [view1 addSubview:self.xuanZhongBt];
        [self.xuanZhongBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(view1);
            make.width.height.mas_equalTo(30);
        }];
        
        self.biaoTiLabel = [[UILabel alloc]init];
        self.biaoTiLabel.adjustsFontSizeToFitWidth = YES;
        [view1 addSubview:self.biaoTiLabel];
        [self.biaoTiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.xuanZhongBt.mas_right).mas_equalTo(0);
            make.right.mas_equalTo(-10);
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
        
        
        UIView *gshiView = [[UIView alloc]init];
        [gshiView.layer setMasksToBounds:YES];
        [gshiView.layer setCornerRadius:3];
        [gshiView.layer setBorderWidth:0.5];//设置边界的宽度
        //设置按钮的边界颜色
        [gshiView.layer setBorderColor:[kRGBColor(180, 180, 180) CGColor]];
        [view3 addSubview:gshiView];
        [gshiView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(view3);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(kWindowW/2-20);
        }];
        
        self.jianBt = [[UIButton alloc]init];
        [self.jianBt addTarget:self action:@selector(jianBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.jianBt.layer setBorderWidth:0.5];
        [self.jianBt.layer setBorderColor:[kRGBColor(180, 180, 180) CGColor]];
        [self.jianBt setTitle:@"-" forState:(UIControlStateNormal)];
        [self.jianBt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [gshiView  addSubview:self.jianBt];
        [self.jianBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.height.mas_equalTo(30);
        }];
        
        self.jiaBt = [[UIButton alloc]init];
        [self.jiaBt addTarget:self action:@selector(jiaBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.jiaBt.layer setBorderWidth:0.5];
        [self.jiaBt.layer setBorderColor:[kRGBColor(180, 180, 180) CGColor]];
        [self.jiaBt setTitle:@"+" forState:(UIControlStateNormal)];
         [self.jiaBt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [gshiView  addSubview:self.jiaBt];
        [self.jiaBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_equalTo(0);
            make.width.height.mas_equalTo(30);
        }];
        
        
        self.benDiLael2 = [[UILabel alloc]init];
        self.benDiLael2.font = [UIFont systemFontOfSize:13];
        [gshiView addSubview:self.benDiLael2];
        [self.benDiLael2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.jianBt.mas_right).mas_equalTo(5);
            make.centerY.mas_equalTo(gshiView);
        }];
        
        self.gongShiLabel = [[UILabel alloc]init];
        self.gongShiLabel.font = [UIFont systemFontOfSize:13];
        [gshiView addSubview:self.gongShiLabel];
        [self.gongShiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.benDiLael2.mas_right).mas_equalTo(0);
            make.centerY.mas_equalTo(gshiView);
        }];
        
        self.xiuGaiGongShiBT = [[UIButton alloc]init];
        [self.xiuGaiGongShiBT addTarget:self action:@selector(xiuGaiGongShiBTChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.xiuGaiGongShiBT.layer setBorderWidth:0.5];
        [self.xiuGaiGongShiBT.layer setBorderColor:[kRGBColor(180, 180, 180) CGColor]];
        [gshiView  addSubview:self.xiuGaiGongShiBT];
        [self.xiuGaiGongShiBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_equalTo(0);
            make.left.mas_equalTo(self.jianBt.mas_right).mas_equalTo(0);
            make.right.mas_equalTo(self.jiaBt.mas_left).mas_equalTo(0);
        }];
        
        UIView *gshiView2 = [[UIView alloc]init];
        [gshiView2.layer setMasksToBounds:YES];
        [gshiView2.layer setCornerRadius:3];
        [gshiView2.layer setBorderWidth:0.5];//设置边界的宽度
        //设置按钮的边界颜色
        [gshiView2.layer setBorderColor:[kRGBColor(180, 180, 180) CGColor]];
        [view3 addSubview:gshiView2];
        [gshiView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(view3);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(kWindowW/2-30);
        }];
        
        self.benDiLael3 = [[UILabel alloc]init];
        self.benDiLael3.font = [UIFont systemFontOfSize:13];
        [gshiView2 addSubview:self.benDiLael3];
        [self.benDiLael3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.centerY.mas_equalTo(gshiView2);
        }];
        self.gongShiFeiLabel = [[UILabel alloc]init];
        self.gongShiFeiLabel.font = [UIFont systemFontOfSize:13];
        [gshiView2 addSubview:self.gongShiFeiLabel];
        [self.gongShiFeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.benDiLael3.mas_right).mas_equalTo(0);
            make.centerY.mas_equalTo(gshiView2);
        }];
        
        self.gongShiFeiBt = [[UIButton alloc]init];
        [self.gongShiFeiBt addTarget:self action:@selector(gongShiFeiBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [gshiView2 addSubview:self.gongShiFeiBt];
        [self.gongShiFeiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
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
-(void)gongShiFeiBtChick:(UIButton *)sender
{
    self.xiuGaiGongShiFeiBlock(self.OrignalModel);
}

-(void)xiuGaiGongShiBTChick:(UIButton *)sender
{
    self.xiuGaiGongShiBlock(self.OrignalModel);
}

-(void)xuanZhongBtChick:(UIButton *)sender
{
    self.OrignalModel.shiFouXuanZhong = !sender.selected;
    self.tableViewShuaXinBlock();
}


-(void)jianBtChick:(UIButton *)sender
{
    if ([self.OrignalModel.hour floatValue] >1) {
        CGFloat jis = [self.OrignalModel.hour floatValue]-1;
        self.OrignalModel.hour = [CommonRecordStatus getAvaildNumberWithDoubleStr:[NSString stringWithFormat:@"%.2f",jis]];
    }else{
        self.buNengWeiLing();
    }
    self.tableViewShuaXinBlock();
}


-(void)jiaBtChick:(UIButton *)sender
{
    if ([self.OrignalModel.hour floatValue]>=99999.9) {
        return;
    }
    
    CGFloat jis = [self.OrignalModel.hour floatValue]+1;
    self.OrignalModel.hour = [CommonRecordStatus getAvaildNumberWithDoubleStr:[NSString stringWithFormat:@"%.2f",jis]];
    self.tableViewShuaXinBlock();
}



-(void)refeleseWithModel:(OrignalModel *)model
{
    self.OrignalModel = model;
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
    self.xuanZhongBt.selected = model.shiFouXuanZhong;
}


@end
