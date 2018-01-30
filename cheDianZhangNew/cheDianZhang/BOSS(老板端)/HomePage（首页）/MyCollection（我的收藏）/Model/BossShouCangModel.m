//
//  BossShouCangModel.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BossShouCangModel.h"
#import "BOSSCheDianZhangCommon.h"
@implementation BossShouCangModel
-(void)setCellData:(NSDictionary *)dic{
    self.time=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic,@"time")];
    self.title=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"title")];
    self.image=[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(dic, @"image")];
    
}
@end
