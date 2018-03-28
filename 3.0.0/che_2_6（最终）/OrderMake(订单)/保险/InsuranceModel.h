//
//  InsuranceModel.h
//  测试
//
//  Created by sykj on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, InsuranceDataType) {
    InsuranceDataTypeForceDate,
    InsuranceDataTypeForceCompany,
    InsuranceDataTypeBusinessDate,
    InsuranceDataTypeBusinessCompany,
    InsuranceDataTypeYearlyCheck,
};

@class InsuranceSectionModel, InsuranceCellModel, InsuranceDataInfoModel;

@interface InsuranceModel : NSObject
- (void)buildDatasWithModel:(InsuranceDataInfoModel *)model;
@property (nonatomic, strong) NSArray<InsuranceSectionModel *> *dataSource;

- (NSMutableDictionary *)getSaveData;
@end

@interface InsuranceSectionModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<InsuranceCellModel *> *lists;
@end

@interface InsuranceCellModel : NSObject
@property (nonatomic, assign) InsuranceDataType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *imageURL;
// 上传后台的参数
@property (nonatomic, copy) NSString *selectedContent;
@property (nonatomic, strong) NSString *key;

@property (nonatomic, assign) BOOL isImageShow;

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL isHiddenLine;
@end


@interface InsuranceDataInfoModel : NSObject
@property (nonatomic, copy) NSString *TCI_expire;
@property (nonatomic, copy) NSString *VCI_expire;
@property (nonatomic, copy) NSString *insurance_force;
@property (nonatomic, copy) NSString *insurance_company;
@property (nonatomic, copy) NSString *valid_car_date;
@property (nonatomic, copy) NSString *insurance_company_images;
@property (nonatomic, copy) NSString *insurance_force_images;
@end;

