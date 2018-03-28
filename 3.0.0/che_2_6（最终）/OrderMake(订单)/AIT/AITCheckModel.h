//
//  AITCheckModel.h
//  测试
//
//  Created by sykj on 2018/1/31.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarCheckModel.h"

@interface AITCheckModel : NSObject
- (void)buildDataSourceWithModel:(CarCheckDataModel *)model;
@property (nonatomic, strong) CarCheckDataModel *model;

@property (nonatomic, strong) NSArray *dataSource;

@end

@interface AITCheckCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isHiddenLine;

@end
