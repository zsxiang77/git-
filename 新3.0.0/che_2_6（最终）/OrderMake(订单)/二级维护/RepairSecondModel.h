//
//  RepairSecondModel.h
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RepairSecondDataModel, RepairSecondDataListModel;

@interface RepairSecondModel : NSObject
- (void)buildDataSourceWithModel:(RepairSecondDataModel *)model;
@property (nonatomic, strong) RepairSecondDataModel *model;

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@end


@interface RepairSecondCellModel : NSObject
- (instancetype)initWithModel:(RepairSecondDataListModel *)model;
@property (nonatomic, strong) RepairSecondDataListModel *model;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSAttributedString *desc;
@property (nonatomic, assign) BOOL isHiddenLine;
@end


@interface RepairSecondDataModel : NSObject
@property (nonatomic, strong) NSArray<RepairSecondDataListModel *> *list;
@end

@interface RepairSecondDataListModel : NSObject
@property (nonatomic, copy) NSString *subject_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSString *fee;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, assign) BOOL isLast;
@end
