//
//  LearningZiCeViewController.m
//  cheDianZhang
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "LearningZiCeViewController.h"
#import "LearningDaAnViewController.h"
@interface LearningZiCeViewController ()

@end

@implementation LearningZiCeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"自测题" withBackButton:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:@"ceshibeijingtu"];
    imgView.frame = CGRectMake(0, kBOSSNavBarHeight+108/2, kWindowW, kWindowW*290/706);
    imgView.backgroundColor = [UIColor yellowColor];
     [self.view addSubview:imgView];
    
    self.cuoTiCount = [[UILabel alloc]init];
    self.cuoTiCount.textColor = kRGBColor(51, 51, 51);
    self.cuoTiCount.font = [UIFont boldSystemFontOfSize:17];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"您共完成%@道题,其中%@道题错误",self.chuanZhiDict.totalnum,self.chuanZhiDict.num]];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor redColor]
                          range:NSMakeRange(9+self.chuanZhiDict.totalnum.length, self.chuanZhiDict.num.length)];
    self.cuoTiCount.attributedText = AttributedStr;
    [self.view addSubview:self.cuoTiCount];
    [self.cuoTiCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgView.mas_bottom).mas_equalTo(94/2);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIButton *okBt = [[UIButton alloc]init];
    [okBt.layer setMasksToBounds:YES];
    okBt.backgroundColor = kZhuTiColor;
    [okBt.layer setCornerRadius:8];
    [okBt setTitle:@"查看答案" forState:(UIControlStateNormal)];
    [okBt addTarget:self action:@selector(nextChick:) forControlEvents:UIControlEventTouchUpInside];
    [okBt setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:okBt];
    [okBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(self.cuoTiCount.mas_bottom).mas_equalTo(112/2);
        make.height.mas_equalTo(48);
    }];
    
    UIButton *zailaiyiciBtn = [[UIButton alloc]init];
    [zailaiyiciBtn.layer setMasksToBounds:YES];
    //zailaiyiciBtn.backgroundColor = kZhuTiColor;
    [zailaiyiciBtn.layer setCornerRadius:8];
    zailaiyiciBtn.layer.borderWidth = 1;
    zailaiyiciBtn.layer.borderColor = kZhuTiColor.CGColor;
    [zailaiyiciBtn setTitle:@"再来一次" forState:(UIControlStateNormal)];
    [zailaiyiciBtn addTarget:self action:@selector(backQianChick:) forControlEvents:UIControlEventTouchUpInside];
    [zailaiyiciBtn setTitleColor:kZhuTiColor forState:(UIControlStateNormal)];
    [self.view addSubview:zailaiyiciBtn];
    [zailaiyiciBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(okBt.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(48);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)nextChick:(UIButton *)sender
{
    LearningDaAnViewController * vc = [[LearningDaAnViewController alloc]init];
    vc.chuanZhiDict = self.chuanZhiDict;
    vc.fatherViewController = self.fatherViewController;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)backQianChick:(UIButton *)sender
{
    //跳转页面刷新当前页面
    LearningZuoCeShiViewController *vc = (LearningZuoCeShiViewController *)self.backCeshiViewController;
    [self.navigationController popToViewController:vc animated:YES];
    [vc qingQiuGet_questionData];
}
@end
