//
//  PerctInfoModel.h
//  测试
//
//  Created by sykj on 2018/1/30.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PerctInfoDataScheduleModel, PerctInfoDataModel;

@interface PerctInfoModel : NSObject
@property (nonatomic, strong) NSArray *dataSource;
- (void)buildDataSourceWithModel:(PerctInfoDataModel *)model;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) BOOL isNoUserID;
@end

@interface PerctInfoCellModel : NSObject
- (instancetype)initWithModel:(PerctInfoDataScheduleModel *)model;
@property (nonatomic, strong) PerctInfoDataScheduleModel *model;

@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *perct;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) UIColor *numberColor;
@property (nonatomic, assign) BOOL isHiddenLine;

@end



@interface PerctInfoDataModel : NSObject
@property (nonatomic, assign) NSInteger inspect_percent;
@property (nonatomic, strong) NSArray<PerctInfoDataScheduleModel *> *schedule;
@property (nonatomic, assign) NSInteger user_id;
@end

@interface PerctInfoDataScheduleModel : NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger percent;
@end
