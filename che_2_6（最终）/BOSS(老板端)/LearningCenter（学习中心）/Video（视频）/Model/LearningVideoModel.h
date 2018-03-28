//
//  LearningVideoModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LearningVideoModel : NSObject

@property(nonatomic,strong)NSString      *video_url;
@property(nonatomic,strong)NSString      *auto_url;
@property(nonatomic,strong)NSString      *exam_id;
@property(nonatomic,strong)NSString      *brief;
@property(nonatomic,strong)NSString      *title;
@property(nonatomic,strong)NSString      *image;
@property(nonatomic,strong)NSString      *video_id;
@property(nonatomic,strong)NSString      *free_time;
@property(nonatomic,strong)NSString      *is_buy;
@property(nonatomic,strong)NSString      *price;
@property(nonatomic,strong)NSString      *num;
@property(nonatomic,strong)NSString      *type_id;
@property(nonatomic,strong)NSString      *user_coll;
@property(nonatomic,strong)NSString      *user_buy;

-(void)setDatashuJu:(NSDictionary*)dic;


@end
