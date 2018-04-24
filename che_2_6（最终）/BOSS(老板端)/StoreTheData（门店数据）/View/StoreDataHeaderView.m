//
//  StoreDataHeaderView.m
//  cheDianZhang
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "StoreDataHeaderView.h"
@implementation StoreDataHeaderView
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *) Array imgArray:(NSArray *)ImgArray selectArray: (NSArray *)selimgArray
{
    CGFloat anNIuWight = kWindowW/4;
    if(self == [super initWithFrame:frame])
    {
        for (int i=0; i<Array.count; i++) {
            UIButton * btn = [[UIButton alloc]init];
            
            btn.frame = CGRectMake(anNIuWight*i, 20, anNIuWight, kBOSSNavBarHeight-20);
            [btn setTitle:Array[i] forState:UIControlStateNormal];
            
            btn.imageEdgeInsets = UIEdgeInsetsMake(12, -5, 12,10);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0,0);
            btn.titleLabel.font=[UIFont systemFontOfSize:15];
            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [btn setImage:[UIImage imageNamed:ImgArray[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:selimgArray[i]] forState:UIControlStateSelected];
            
            [btn setTitleColor:kRGBColor(74, 74, 74) forState:UIControlStateNormal];
            [btn setTitleColor:kRGBColor(74, 144, 266) forState:UIControlStateSelected];
            
            [btn addTarget:self action:@selector(anniuClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i+400;
            if(i== 0){
                btn.selected = YES;
            }
            if(i==3){
                btn.imageEdgeInsets = UIEdgeInsetsMake(12, -6, 12,10);
            }
            [self addSubview:btn];
        }
        line = [[UILabel alloc]init];
        line.backgroundColor = kRGBColor(74, 144, 266);
        line .frame = CGRectMake(anNIuWight/4, self.frame.size.height-3, anNIuWight/2, 2);
        [self addSubview:line];
        
        UILabel * linebom = [[UILabel alloc]init];
        linebom.backgroundColor = kLineBgColor;
        [self addSubview:linebom];
        [linebom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}

-(void)anniuClick :(UIButton *)sender
{
    CGFloat anNIuWights = kWindowW/4;
    if (sender.selected == YES) {
        return;
    }
    for (int i =0; i<4; i++) {
        UIButton *bt = [self viewWithTag:400+i];
        bt.selected = NO;
    }
    sender.selected =! sender.selected;
    self.viewQieHuan(sender.tag);
    if(sender.tag == 400){
        [UIView animateWithDuration:0.3 animations:^{
             line.frame = CGRectMake(anNIuWights/4,self.frame.size.height-3, anNIuWights/2, 2);
        }];
    }
    if(sender.tag == 401){
        [UIView animateWithDuration:0.3 animations:^{
            line.frame = CGRectMake(anNIuWights+anNIuWights/4,self.frame.size.height-3, anNIuWights/2, 2);
        }];
    }
    if(sender.tag == 402){
        [UIView animateWithDuration:0.3 animations:^{
            line.frame = CGRectMake(anNIuWights*2+anNIuWights/4,self.frame.size.height-3, anNIuWights/2, 2);
        }];
    }
    if(sender.tag == 403){
        [UIView animateWithDuration:0.3 animations:^{
            line.frame = CGRectMake(anNIuWights*3+anNIuWights/4,self.frame.size.height-3, anNIuWights/2, 2);
        }];
        
    }
}

@end
