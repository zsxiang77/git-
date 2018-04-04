//
//  NewInputView.m
//  cheDianZhang
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "NewInputView.h"
#import "CheDianZhangCommon.h"
#import "NumberKeyboard.h"
#import "UIImage+ImageWithColor.h"

@implementation NewInputView


- (UIButton *)setCornerWithRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color button:(UIButton *)sender withTitle:(NSString *)str{
    sender.layer.cornerRadius = radius;
    sender.layer.borderColor = color.CGColor;
    [sender  setBackgroundImage:[UIImage imageWithUIColor:kRGBColor(224, 224, 224)] forState:(UIControlStateHighlighted)];
    sender.layer.borderWidth = width;
    sender.backgroundColor = [UIColor whiteColor];
    [sender setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [sender setTitle:str forState:(UIControlStateNormal)];
    sender.layer.masksToBounds = YES;
    [sender addTarget:self action:@selector(dianJiChick:) forControlEvents:(UIControlEventTouchUpInside)];
    return sender;
}

-(void)quXiaoBtChick:(UIButton *)sender
{
    self.quxiaoBlock();
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kRGBColor(241, 241, 241);
        
        UIView *shangView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 36)];
        shangView.backgroundColor = kRGBColor(245, 245, 245);
        shangView.layer.shadowOpacity = 0.5;// 阴影透明度
        shangView.layer.shadowColor = kRGBColor(209, 209, 209).CGColor;// 阴影的颜色
        
        shangView.layer.shadowRadius = 2;// 阴影扩散的范围控制
        
        shangView.layer.shadowOffset = CGSizeMake(0, 1);// 阴影的范围
        [self addSubview:shangView];
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = kLineBgColor;
        [shangView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, kWindowW, 1)];
        lin.backgroundColor = kLineBgColor;
        [shangView addSubview:lin];
        
        UIButton *quXiaoBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 35)];
        [quXiaoBt addTarget:self action:@selector(quXiaoBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [quXiaoBt setTitle:@"取消" forState:(UIControlStateNormal)];
        [quXiaoBt setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
        [shangView addSubview:quXiaoBt];
        
        self.contentBtn = [[UIButton alloc]init];
        [self.contentBtn addTarget:self action:@selector(contentClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentBtn setImage:[UIImage imageNamed:@"keyDown"] forState:UIControlStateNormal];
        [self.contentBtn setImage:[UIImage imageNamed:@"keyUp"] forState:UIControlStateSelected];
        self.contentBtn.contentMode = UIViewContentModeScaleAspectFit;
        self.contentBtn.imageEdgeInsets = UIEdgeInsetsMake(5,15,5,15);
        self.contentBtn.frame = CGRectMake(kWindowW/2-60/2,0, 60, 35);
        [shangView addSubview:self.contentBtn];
        self.contentBtn.selected = NO;
        
        UIButton *queDingBt = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW-60, 0, 60, 35)];
        [queDingBt addTarget:self action:@selector(queDingBttChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [queDingBt setTitle:@"提交" forState:(UIControlStateNormal)];
        [queDingBt setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
        [shangView addSubview:queDingBt];
        
        self.hanziView = [[UIView alloc]init];
        self.hanziView.frame = CGRectMake(0, 36, kWindowW, self.frame.size.height-36);
        self.hanziView.hidden=NO;
        [self addSubview:self.hanziView];
        
        self.shuziView = [[UIView alloc]init];
        self.shuziView.frame = CGRectMake(0, 36, kWindowW, self.frame.size.height-36);
        self.shuziView.hidden=YES;
        [self addSubview:self.shuziView];
        
        self.qitaView = [[UIView alloc]init];
        self.qitaView.frame = CGRectMake(0, 36, kWindowW, self.frame.size.height-36);
        self.qitaView.hidden=YES;
        [self addSubview:self.qitaView];
        
        
        NSArray *array1 = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0", nil];
        CGFloat heightCount = (self.shuziView.frame.size.height-40)/4;
        for (int i = 0; i<array1.count; i++) {
            UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(10+((kWindowW-38)/10+2)*i, 5, (kWindowW-38)/10, heightCount)];
            bt.tag = 100+i;
            [self setCornerWithRadius:10 borderWidth:0.5 borderColor:kLineBgColor button:bt withTitle:array1[i]];
            [self.shuziView addSubview:bt];
        }
        
        NSArray *array2 = [NSArray arrayWithObjects:@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P", nil];
        
        for (int i = 0; i<array2.count; i++) {
            UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(10+((kWindowW-38)/10+2)*i, heightCount+15, (kWindowW-38)/10, heightCount)];
            bt.tag = 200+i;
            [self setCornerWithRadius:10 borderWidth:0.5 borderColor:kLineBgColor button:bt withTitle:array2[i]];
            [self.shuziView addSubview:bt];
        }
        
        NSArray *array3 = [NSArray arrayWithObjects:@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L", nil];
        
        for (int i = 0; i<array3.count; i++) {
            UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(20+((kWindowW-56)/9+2)*i, heightCount*2+25, (kWindowW-56)/9, heightCount)];
            bt.tag = 300+i;
            [self setCornerWithRadius:10 borderWidth:0.5 borderColor:kLineBgColor button:bt withTitle:array3[i]];
            [self.shuziView addSubview:bt];
        }
        NSArray *array4 = [NSArray arrayWithObjects:@"Z",@"X",@"C",@"V",@"B",@"N",@"M", nil];
        
        for (int i = 0; i<array4.count+1; i++) {
            UIButton *bt = [[UIButton alloc]init];
            bt.tag = 400+i;
            if (i == array4.count) {
                bt.frame = CGRectMake(30+((kWindowW-145)/7+5)*i, heightCount*3+35, 50, heightCount);
                [self setCornerWithRadius:10 borderWidth:0.5 borderColor:kLineBgColor button:bt withTitle:@""];
                [bt setImage:DJImageNamed(@"new_tuiGe") forState:(UIControlStateNormal)];
                bt.imageView.contentMode = UIViewContentModeScaleAspectFit;
                bt.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
            }else{
                bt.frame = CGRectMake(30+((kWindowW-145)/7+5)*i, heightCount*3+35, (kWindowW-145)/7+3, heightCount);
                [self setCornerWithRadius:10 borderWidth:0.5 borderColor:kLineBgColor button:bt withTitle:array4[i]];
            }
            [self.shuziView addSubview:bt];
        }
        
        
        NSArray *hanziArry = [NSArray arrayWithObjects:@"京",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"沪",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"桂",@"琼",@"渝",@"川",@"贵",@"云",@"藏",@"陕",@"甘",@"青",@"宁",@"新", nil];
        CGFloat hanziCount = (self.hanziView.frame.size.height-50)/4;
        CGFloat ww = (kWindowW -10)/9;
        for (int i = 0; i<hanziArry.count+1; i++) {
            UIButton *btnde = [[UIButton alloc]init];
            btnde.titleLabel.font=[UIFont systemFontOfSize:15];
            btnde.tag = 100+i;
            if(i==hanziArry.count){
                btnde.frame = CGRectMake(5+(ww)*(i%9),10+(hanziCount+10)*(i/9), ww*5-2, hanziCount);
                [self setCornerWithRadius:10 borderWidth:0.5 borderColor:kLineBgColor button:btnde withTitle:@""];
                [btnde setImage:DJImageNamed(@"new_tuiGe") forState:(UIControlStateNormal)];
                btnde.imageView.contentMode = UIViewContentModeScaleAspectFit;
                btnde.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
            }else{
                btnde.frame = CGRectMake(5+(ww)*(i%9),10+(hanziCount+10)*(i/9), ww-2, hanziCount);
                [self setCornerWithRadius:10 borderWidth:0.5 borderColor:kLineBgColor button:btnde withTitle:hanziArry[i]];
            }
            [self.hanziView addSubview:btnde];
        }
        
        NSArray * qitaArray = [NSArray arrayWithObjects:@"挂",@"学",@"警",@"试",@"使", nil];
        CGFloat qitaww = (kWindowW -10)/5;
        CGFloat heightQita =(self.qitaView.frame.size.height-30)/2;
        for (int i = 0; i<qitaArray.count; i++) {
            UIButton *bts1 = [[UIButton alloc]initWithFrame:CGRectMake(5+(qitaww)*(i%5),  10+(qitaww+10)*(i/5), qitaww-2, heightQita)];
            bts1.tag = 5000+i;
            bts1.titleLabel.font = [UIFont systemFontOfSize:15];
            [self setCornerWithRadius:10 borderWidth:0.5 borderColor:kLineBgColor button:bts1 withTitle:qitaArray[i]];
            [self.qitaView addSubview:bts1];
        }
        
        NSArray * qitaArray1 = [NSArray arrayWithObjects:@"领",@"超",@"清空", nil];
        for (int i = 0; i<qitaArray1.count+1; i++) {
            UIButton *bts2 = [[UIButton alloc]init];
            bts2.titleLabel.font = [UIFont systemFontOfSize:15];
            bts2.tag = 6000+i;
            if(i==qitaArray1.count){
                bts2.frame=CGRectMake(42+(qitaww)*(i%5),heightQita+20, qitaww-2, heightQita);
                [self setCornerWithRadius:10 borderWidth:0.5 borderColor:kLineBgColor button:bts2 withTitle:@""];
                [bts2 setImage:DJImageNamed(@"new_tuiGe") forState:(UIControlStateNormal)];
                bts2.imageView.contentMode = UIViewContentModeScaleAspectFit;
                bts2.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
            }else{
                bts2.frame=CGRectMake(42+(qitaww)*(i%5),heightQita+20, qitaww-2, heightQita);
                [self setCornerWithRadius:10 borderWidth:0.5 borderColor:kLineBgColor button:bts2 withTitle:qitaArray1[i]];
            }
            if(i==qitaArray1.count-1){
                [bts2 setTitleColor:kRGBColor(155, 155, 155) forState:UIControlStateNormal];
            }
            [self.qitaView addSubview:bts2];
        }
        
    }
    return self;
}

-(void)queDingBttChick:(UIButton *)sender
{
    self.quedingBlock();
}

-(void)dianJiChick:(UIButton *)sender
{

    
    if (self.myDelegate != nil) {
        if ([self.myDelegate respondsToSelector:@selector(fieldChangeing:)]) {
            [self.myDelegate fieldChangeing:self];
        }
        if ([self.myDelegate respondsToSelector:@selector(shouldChangeCharactersInRangreplacementString:)]) {
            [self.myDelegate shouldChangeCharactersInRangreplacementString:sender.titleLabel.text];
        }
    }
    
    
}

-(void)contentClick:(UIButton*)sender
{
    
    sender.selected = !sender.selected;
    self.shoWqieHuan(sender.selected);
}
@end

