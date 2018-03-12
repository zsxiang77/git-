//
//  VINinPutView.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/12/27.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "VINinPutView.h"
#import "CheDianZhangCommon.h"
#import "NumberKeyboard.h"
#import "UIImage+ImageWithColor.h"

@implementation VINinPutView

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
    [self.mainTextField resignFirstResponder];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kRGBColor(241, 241, 241);
        
        CGFloat jihaI = 0;
        
        UIView *shangView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 35)];
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
        jihaI += 35;
        
        UIButton *quXiaoBt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 35)];
        [quXiaoBt addTarget:self action:@selector(quXiaoBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [quXiaoBt setTitle:@"取消" forState:(UIControlStateNormal)];
        [quXiaoBt setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
        [shangView addSubview:quXiaoBt];
        
        UIButton *queDingBt = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW-60, 0, 60, 35)];
        [queDingBt addTarget:self action:@selector(queDingBttChick:) forControlEvents:(UIControlEventTouchUpInside)];
        [queDingBt setTitle:@"提交" forState:(UIControlStateNormal)];
        [queDingBt setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
        [shangView addSubview:queDingBt];
        
        
        
        
        NSArray *array1 = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0", nil];
        
        for (int i = 0; i<array1.count; i++) {
            UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(10+((kWindowW-38)/10+2)*i, jihaI+10, (kWindowW-38)/10, 92/2)];
            bt.tag = 100+i;
            [self setCornerWithRadius:10 borderWidth:0.5 borderColor:kLineBgColor button:bt withTitle:array1[i]];
            [self addSubview:bt];
        }
        jihaI += 92/2+10;
        
        NSArray *array2 = [NSArray arrayWithObjects:@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P", nil];
        
        for (int i = 0; i<array2.count; i++) {
            UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(10+((kWindowW-38)/10+2)*i, jihaI+10, (kWindowW-38)/10, 92/2)];
            bt.tag = 200+i;
            [self setCornerWithRadius:10 borderWidth:0.5 borderColor:kLineBgColor button:bt withTitle:array2[i]];
            [self addSubview:bt];
            
            if ([bt.titleLabel.text isEqualToString:@"Q"]||[bt.titleLabel.text isEqualToString:@"I"]||[bt.titleLabel.text isEqualToString:@"O"]) {
                bt.backgroundColor = kRGBColor(240, 240, 240);
                [bt setTitleColor:kRGBColor(179, 179, 179) forState:(UIControlStateNormal)];
                bt.userInteractionEnabled = NO;
            }
        }
        jihaI += 92/2+10;
        
        NSArray *array3 = [NSArray arrayWithObjects:@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L", nil];
        
        for (int i = 0; i<array3.count; i++) {
            UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(20+((kWindowW-56)/9+2)*i, jihaI+10, (kWindowW-56)/9, 92/2)];
            bt.tag = 300+i;
            [self setCornerWithRadius:10 borderWidth:0.5 borderColor:kLineBgColor button:bt withTitle:array3[i]];
            [self addSubview:bt];
        }
        jihaI += 92/2+10;
        
        
        NSArray *array4 = [NSArray arrayWithObjects:@"Z",@"X",@"C",@"V",@"B",@"N",@"M", nil];
        
        for (int i = 0; i<array4.count+1; i++) {
            UIButton *bt = [[UIButton alloc]init];
            bt.tag = 400+i;
            if (i == array4.count) {
                bt.frame = CGRectMake(30+((kWindowW-145)/7+5)*i, jihaI+10, 50, 92/2);
                [self setCornerWithRadius:10 borderWidth:0.5 borderColor:kLineBgColor button:bt withTitle:@""];
                [bt setImage:DJImageNamed(@"new_tuiGe") forState:(UIControlStateNormal)];
                bt.imageView.contentMode = UIViewContentModeScaleAspectFit;
                bt.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
            }else{
                bt.frame = CGRectMake(30+((kWindowW-145)/7+5)*i, jihaI+10, (kWindowW-145)/7+3, 92/2);
                [self setCornerWithRadius:10 borderWidth:0.5 borderColor:kLineBgColor button:bt withTitle:array4[i]];
            }
            
            [self addSubview:bt];
        }
        jihaI += 92/2+10+10;
        
        
        self.frame = CGRectMake(0, kWindowH-jihaI, kWindowW, jihaI);
    }
    return self;
}

-(void)queDingBttChick:(UIButton *)sender
{
    self.quedingBlock();
}

-(void)dianJiChick:(UIButton *)sender
{
//    NSLog(@"%@",sender.titleLabel.text);
//    NSString *str = [NSString stringWithFormat:@"%@",sender.titleLabel.text];
    if (self.myDelegate != nil) {
        if ([self.myDelegate respondsToSelector:@selector(fieldChangeing:)]) {
            [self.myDelegate fieldChangeing:self];
        }
        if ([self.myDelegate respondsToSelector:@selector(shouldChangeCharactersInRangreplacementString:)]) {
            [self.myDelegate shouldChangeCharactersInRangreplacementString:sender.titleLabel.text];
        }
    }
//    self.mainTextField.text = [NSString stringWithFormat:@"%@%@",self.mainTextField.text,sender.titleLabel.text];
    
}
@end
