//
//  BossShouCangModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BossShouCangModel : NSObject
@property(nonatomic,strong)NSString*image;
@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)NSString*time;
-(void)setCellData:(NSDictionary*)dic;
@end
