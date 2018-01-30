//
//  BossJianceModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BossJianceModel : NSObject
@property(nonatomic,strong)NSString      *a_id;
@property(nonatomic,strong)NSString      *num;
@property(nonatomic,strong)NSString      *score;
@property(nonatomic,strong)NSString      *exam_id;
@property(nonatomic,strong)NSString      *image;
@property(nonatomic,strong)NSString      *test_paper_name;


-(void)setDatashuJu:(NSDictionary*)dic;
@end
