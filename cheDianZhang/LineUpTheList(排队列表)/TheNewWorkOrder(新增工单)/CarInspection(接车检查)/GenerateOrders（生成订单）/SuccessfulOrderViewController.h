//
//  SuccessfulOrderViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/18.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "BaseViewController.h"

@interface SuccessfulOrderViewController : BaseViewController

@property(nonatomic,strong)NSString *ordercode;
@property(nonatomic,strong)NSString *query_url;

//生成最原始的二维码
+ (CIImage *)qrCodeImageWithContent:(NSString *)content;

//改变二维码尺寸大小
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size;
//改变二维码颜色
+ (UIImage *)qrCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

@end
