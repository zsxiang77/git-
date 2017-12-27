//
//  PreviewPictureViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/14.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "PreviewPictureViewController.h"
#import "UIImageView+WebCache.h"

@interface PreviewPictureViewController ()
@property(nonatomic,strong)UIImageView *mianImageView;

@end

@implementation PreviewPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"预览图片" withBackButton:YES];
    self.view.backgroundColor = [UIColor blackColor];
    if (self.chuRuMoel.urlDiZhi.length>0) {
        [self.mianImageView  sd_setImageWithURL:[NSURL URLWithString:self.chuRuMoel.urlDiZhi] placeholderImage:DJImageNamed(@"xiangMuBack")];
    }else
    {
        self.mianImageView.image = self.chuRuMoel.cunImage;
    }
    
    UILabel * la3 = [[UILabel alloc]init];
    la3.textColor = [UIColor whiteColor];
    la3.text = [NSString stringWithFormat:@"车身备注：%@",self.chuRuMoel.beiZhu];
    [self.view addSubview:la3];
    la3.textAlignment = NSTextAlignmentCenter;
    [la3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    if (self.shiFouZhanShi == YES) {
        la3.hidden = YES;
    }
    
    UILabel * la2 = [[UILabel alloc]init];
    la2.textColor = [UIColor whiteColor];
    NSString *str = @"车身描述：";
    for (int i = 0; i<self.chuRuMoel.wenTiArray.count; i++) {
        str = [NSString stringWithFormat:@"%@%@",str,self.chuRuMoel.wenTiArray[i]];
    }
    la2.text = str;
    [self.view addSubview:la2];
    la2.textAlignment = NSTextAlignmentCenter;
    [la2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-30);
        make.height.mas_equalTo(30);
    }];
    if (self.shiFouZhanShi == YES) {
        la2.hidden = YES;
    }
    
    UILabel *la = [[UILabel alloc]init];
    la.textColor = [UIColor whiteColor];
    la.text = [NSString stringWithFormat:@"车身方位：%@",self.chuRuMoel.fangXiang];
    [self.view addSubview:la];
    la.textAlignment = NSTextAlignmentCenter;
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-60);
        make.height.mas_equalTo(30);
    }];
    if (self.shiFouZhanShi == YES) {
        la.hidden = YES;
    }
}

-(UIImageView *)mianImageView
{
    if (!_mianImageView) {
        _mianImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight)];
        _mianImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_mianImageView];
    }
    return _mianImageView;
}

@end
