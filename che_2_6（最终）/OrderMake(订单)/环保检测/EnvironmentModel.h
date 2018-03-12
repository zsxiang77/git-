//
//  EnvironmentModel.h
//  测试
//
//  Created by sykj on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EnvironmentValueType) {
    EnvironmentValueTypeEqual,
    EnvironmentValueTypeUp,
    EnvironmentValueTypeDown,
};

@class EnvironmentDataModel, EnvironmentProjectsModel, EnvironmentProjectsListModel, EnvironmentSectionModel, EnvironmentCellModel;

@interface EnvironmentModel : NSObject
- (void)buildDataSourceWithModel:(EnvironmentDataModel *)model;
@property (nonatomic, strong) EnvironmentDataModel *model;

@property (nonatomic, strong) NSArray<EnvironmentSectionModel *> *dataSource;
@end

@interface EnvironmentSectionModel : NSObject

- (instancetype)initWithModel:(EnvironmentProjectsModel *)model;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<EnvironmentCellModel *> *rows;
@end

@interface EnvironmentCellModel : NSObject
- (instancetype)initWithModel:(EnvironmentProjectsListModel *)model;
@property (nonatomic, strong) EnvironmentProjectsListModel *model;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSAttributedString *desc;
@property (nonatomic, assign) EnvironmentValueType valueType;
@property (nonatomic, assign) BOOL isIdleSpeed;
@property (nonatomic, assign) BOOL isHiddenLine;

@end


@interface EnvironmentDataModel : NSObject
@property (nonatomic, strong) NSArray<EnvironmentProjectsModel *> *projects;
@property (nonatomic, copy) NSString *result_val;
@end

@interface EnvironmentProjectsModel : NSObject
@property (nonatomic, copy) NSString *project;
@property (nonatomic, strong) NSArray<EnvironmentProjectsListModel *> *list;
@end

@interface EnvironmentProjectsListModel : NSObject
@property (nonatomic, copy) NSString *item;
@property (nonatomic, assign) CGFloat limit;
@property (nonatomic, copy) NSString *result;
@property (nonatomic, assign) CGFloat value;
@end


