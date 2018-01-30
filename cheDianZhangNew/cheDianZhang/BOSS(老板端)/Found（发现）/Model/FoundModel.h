//
//  FoundModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/23.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoundModel : NSObject

@property(nonatomic,strong)NSString *articleid;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *praisenum;
@property(nonatomic,strong)NSString *commentnum;
@property(nonatomic,strong)NSString *is_praise;


-(void)setdataWithDict:(NSDictionary *)dict;

@end
