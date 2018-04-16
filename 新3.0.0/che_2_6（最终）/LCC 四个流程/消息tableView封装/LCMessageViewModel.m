//
//  LCMessageViewModel.m
//  测试
//
//  Created by lcc on 2018/1/31.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "LCMessageViewModel.h"

@implementation LCMessageViewModel


- (void)setMessage:(NSString *)message{
    if (LC_isStrEmpty(message)) {
        return;
    }
    _message = message;
    CGFloat maxImgv_W = kScreenWidth - 100 - 15;
    
    CGFloat height = 0;
//    CGFloat width  = [message widthForFont:[UIFont pf_PingFangSCRegularFontOfSize:15]] + 18.5 + 13.5+1;
//
//    if (width > maxImgv_W) {
//        width = maxImgv_W;
//        height = [message heightForFont:[UIFont pf_PingFangSCRegularFontOfSize:15] width:maxImgv_W] + 9 + 9+1;
//    }else{
//        height = 38;
//    }
    
    height = [message heightForFont:[UIFont pf_PingFangSCRegularFontOfSize:15] width:maxImgv_W];

//    self.imageView_H = height;
//    self.imageView_W = width;
    self.cell_H = height + 40;
}
@end
