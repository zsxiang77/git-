//
//  LearningModel.h
//  cheDianZhang
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LearningModel : NSObject

@property(nonatomic,strong)NSString      *url;
@property(nonatomic,strong)NSString      *title;
@property(nonatomic,strong)NSString      *video_id;
@property(nonatomic,strong)NSString      *playnum;
@property(nonatomic,strong)NSString      *image;
@property(nonatomic,strong)NSString      *teacher;
@property(nonatomic,strong)NSString      *likenum;

@property(nonatomic,strong)NSString      *is_buy;
@property(nonatomic,strong)NSString      *price;
@property(nonatomic,strong)NSString      *user_coll;
@property(nonatomic,strong)NSString      *user_buy;



-(void)setDatashuJu:(NSDictionary*)dic;
@end
