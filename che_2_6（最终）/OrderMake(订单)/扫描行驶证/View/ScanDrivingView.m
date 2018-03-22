//
//  ScanDrivingView.m
//  cheDianZhang
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "ScanDrivingView.h"

@implementation ScanDrivingView

-(instancetype)init{
    self=[super init];
    if(self){
        self.frame=CGRectMake(0, 0,kWindowW , kWindowH);
        self.alpha=0.5;
        self.backgroundColor = kColorWithRGB(0, 0, 0, 0.4);
        view=[[UIView alloc]init];
        [view.layer setMasksToBounds:YES];
        [view.layer setCornerRadius:10];
        view.backgroundColor=[UIColor whiteColor];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(210);
            make.centerY.mas_equalTo(self);
        }];
        
        self.shangLable=[[UILabel alloc]init];
        self.shangLable.numberOfLines = 0;
        self.shangLable.font = [UIFont systemFontOfSize:14];
        self.shangLable.textColor = [UIColor grayColor];
        self.shangLable.text=@"发发发";
        self.shangLable.textAlignment = NSTextAlignmentCenter;
        [view addSubview:self.shangLable];
        [self.shangLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(20);
        }];
        
        leftBtn =[[UIButton alloc]init];
        [leftBtn addTarget:self action:@selector(leftBtnChcick:) forControlEvents:(UIControlEventTouchUpInside)];
        [leftBtn setTitle:@"左边" forState:UIControlStateNormal];
        [leftBtn setTitleColor:kZhuTiColor forState:UIControlStateNormal];
        [leftBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [leftBtn.layer setCornerRadius:4];
        [leftBtn.layer setBorderWidth:1];//设置边界的宽度
        [leftBtn.layer setBorderColor:kZhuTiColor.CGColor];
        
        [view addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view);
            make.left.mas_equalTo(40);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(100);
        }];
        
        rightBtn =[[UIButton alloc]init];
        [rightBtn addTarget:self action:@selector(rightBtnChcick:) forControlEvents:(UIControlEventTouchUpInside)];
        [rightBtn setTitle:@"左边" forState:UIControlStateNormal];
        [rightBtn setTitleColor:kZhuTiColor forState:UIControlStateNormal];
        [rightBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        [rightBtn.layer setCornerRadius:4];
        [rightBtn.layer setBorderWidth:1];//设置边界的宽度
        [rightBtn.layer setBorderColor:kZhuTiColor.CGColor];
        
        [view addSubview:rightBtn];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-40);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(100);
            make.centerY.mas_equalTo(leftBtn);
        }];
        
        UILabel * line=[[UILabel alloc]init];
        line.backgroundColor=kLineBgColor;
        [view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-45);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        UIButton *xiaBtn=[[UIButton alloc]init];
        [xiaBtn addTarget:self action:@selector(shoDongChick:) forControlEvents:(UIControlEventTouchUpInside)];
        xiaBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [xiaBtn setTitle:@"手动输入"  forState:UIControlStateNormal];
        [xiaBtn setTitleColor:kZhuTiColor forState:UIControlStateNormal];
        [view addSubview:xiaBtn];
        [xiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(45);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(70);
            make.right.mas_equalTo(-20);
        }];
        
        self.xiaLable=[[UILabel alloc]init];
        self.xiaLable.font = [UIFont boldSystemFontOfSize:11];
        self.xiaLable.text=@"请点击选择正确车牌，若都不符合，请点击";
        [view addSubview:self.xiaLable];
        [self.xiaLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(xiaBtn.mas_left);
            make.centerY.mas_equalTo(xiaBtn);
        }];

        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(selfViewTouch:)];
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

-(void)leftBtnChcick:(UIButton *)sender
{
    self.leftBtnChcickBlock(leftBtn.titleLabel.text);
}
-(void)rightBtnChcick:(UIButton *)sender
{
    self.rightBtnChcickBlock(rightBtn.titleLabel.text);
}
-(void)shoDongChick:(UIButton *)sender
{
    self.shoDongChickBlock(@"");
}
-(void)yingCangViwe
{
    [UIView animateWithDuration:0.4 animations:^{
        CGPoint _center = self.center;
        if (_center.y > 0) {//显示状态
            _center.y -= CGRectGetHeight(self.frame);
        }
        self.center = _center;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)displayViewWithChePai:(NSString *)chePai1 withChePai2:(NSString *)chePai2//显示
{
    
    [leftBtn setTitle:chePai1 forState:(UIControlStateNormal)];
    [rightBtn setTitle:chePai2 forState:(UIControlStateNormal)];
    
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    paraStyle.lineSpacing = 5; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    NSMutableAttributedString* att1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"该行驶证车牌号为%@\n与上方输入的%@不符",chePai1,chePai2] attributes:dic];
    [att1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(8, chePai1.length)];
    [att1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(15+chePai1.length, chePai2.length)];
    self.shangLable.attributedText = att1;
    
    
    
    
    [UIView animateWithDuration:0.4 animations:^{
        self.hidden = NO;
        self.alpha = 1.0;
        
        CGPoint _center = self.center;
        if (_center.y < 0) {//显示状态
            _center.y += CGRectGetHeight(self.frame);
        }
        self.center = _center;
    } completion:^(BOOL finished) {
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:view]) {
        return NO;
    }
    return YES;
}

- (void)selfViewTouch:(id)sender
{
    [self yingCangViwe];
}
@end
