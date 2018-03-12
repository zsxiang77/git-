//
//  ErMenModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/7.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheDianZhangCommon.h"

@interface ErMenModel : NSObject

@property(nonatomic,strong)NSString *bfirstletter;
@property(nonatomic,assign)NSInteger brand_id;
@property(nonatomic,strong)NSString *imges;
@property(nonatomic,strong)NSString *name;

-(void)setdataWithDict:(NSDictionary *)dict;


@end


