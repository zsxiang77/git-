//
//  MyKechengModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyKechengModel : NSObject
@property(nonatomic,strong)NSString      *date;
@property(nonatomic,strong)NSString      *total_fee;
@property(nonatomic,strong)NSString      *title;
@property(nonatomic,strong)NSString      *image;
@property(nonatomic,strong)NSString      *video_id;
@property(nonatomic,strong)NSString      *num;


-(void)setDatashuJu:(NSDictionary*)dic;
@end
