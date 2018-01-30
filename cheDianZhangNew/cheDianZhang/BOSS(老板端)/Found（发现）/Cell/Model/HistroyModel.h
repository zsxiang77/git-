//
//  HistroyModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistroyModel : NSObject
@property(nonatomic,strong)NSString      *minutes;
@property(nonatomic,strong)NSString      *title;
@property(nonatomic,strong)NSString      *image;
@property(nonatomic,strong)NSString      *num;
-(void)setDatashuJu:(NSDictionary*)dic;
@end
