//
//  FoundDetailModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/24.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoundDetailModel : NSObject

@property(nonatomic,strong)NSString *articleid;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *praisenum;
@property(nonatomic,strong)NSString *commentnum;
@property(nonatomic,strong)NSString *readnum;
@property(nonatomic,strong)NSString *is_praise;
@property(nonatomic,strong)NSString *now_time;

-(void)setdataWithDict:(NSDictionary *)dict;

@end


@interface FoundDetailListModel : NSObject

@property(nonatomic,strong)NSString *c_id;
@property(nonatomic,strong)NSString *articleid;
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *createdate;
@property(nonatomic,strong)NSString *pid;
@property(nonatomic,strong)NSString *to_user_id;
@property(nonatomic,strong)NSString *praise;
@property(nonatomic,strong)NSString *fid;
@property(nonatomic,strong)NSString *is_praise;
@property(nonatomic,strong)NSString *now_time;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *avatar;
@property(nonatomic,strong)NSString *to_username;
@property(nonatomic,strong)NSString *original;

-(void)setdataWithDict:(NSDictionary *)dict;

@end

