//
//  TopDanXuanViewModel.h
//  cheDianZhang
//
//  Created by lcc on 2018/1/30.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopDanXuanViewModel : NSObject
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *market_price;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *serviceid;
@property(nonatomic,strong)NSString *title;

-(void)setDictData:(NSDictionary *)dict;


@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) BOOL isSelect;

@end
