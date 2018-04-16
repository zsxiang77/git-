//
//  PopInsuranceListModel.h
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PopInsuranceListCellModel, PopInsuranceDataModel;
@interface PopInsuranceListModel : NSObject

- (void)buildDataSourceWithModels:(NSArray<PopInsuranceDataModel *> *)models;

@property (nonatomic, strong) NSArray<PopInsuranceListCellModel *> *dataSource;
@end

@interface PopInsuranceListCellModel : NSObject
- (instancetype)initWithModel:(PopInsuranceDataModel *)model;
@property (nonatomic, strong) PopInsuranceDataModel *model;

@property (nonatomic, strong) NSURL *iconURL;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) BOOL isCustom;
@property (nonatomic, assign) BOOL isSelected;
@end

@interface PopInsuranceDataModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *images;
@end
