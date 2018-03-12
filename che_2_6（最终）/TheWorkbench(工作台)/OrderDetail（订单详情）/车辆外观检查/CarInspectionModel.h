//
//  CarInspectionModel.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/14.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CarInspectionModel : NSObject
@property(nonatomic,strong)NSString *fangXiang;
@property(nonatomic,strong)NSString *beiZhu;
@property(nonatomic,strong)NSMutableArray *wenTiArray;
@property(nonatomic,strong)UIImage *cunImage;

@property(nonatomic,strong)NSString *tuPianNameStr;

@property(nonatomic,strong)NSString *urlDiZhi;

@property(nonatomic,strong)NSURL *url;

@end
