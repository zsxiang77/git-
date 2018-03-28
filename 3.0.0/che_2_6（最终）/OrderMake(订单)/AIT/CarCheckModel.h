//
//  CarCheckModel.h
//  测试
//
//  Created by sykj on 2018/1/30.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CarCheckDataModel;

@interface CarCheckModel : NSObject
- (void)buildDataSourceWithModel:(CarCheckDataModel *)model;
@property (nonatomic, strong) CarCheckDataModel *model;

@property (nonatomic, strong) NSArray *dataSource;
/// 是否有智能检查
@property (nonatomic, assign) BOOL hasBrainpower;
@end

@interface CarCheckCellModel : NSObject
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *iconName;

@property (nonatomic, assign) BOOL isHiddenLine;
@end

@interface CarCheckDataModel : NSObject
@property (nonatomic, assign) BOOL ait_switch;
@property (nonatomic, strong) NSArray<NSString *> *ait_list;
@end
