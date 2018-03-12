//
//  InsuranceModel.m
//  测试
//
//  Created by sykj on 2018/2/1.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "InsuranceModel.h"

@implementation InsuranceModel

- (void)buildDatasWithModel:(InsuranceDataInfoModel *)model
{
    InsuranceCellModel *cell1 = [InsuranceCellModel new];
    cell1.type = InsuranceDataTypeForceDate;
    cell1.title = @"到期日期";
    cell1.selectedContent = model.TCI_expire;
    cell1.key = @"TCI_expire";
    
    InsuranceCellModel *cell2 = [InsuranceCellModel new];
    cell2.type = InsuranceDataTypeForceCompany;
    cell2.title = @"承保公司";
    cell2.selectedContent = model.insurance_force;
    cell2.isHiddenLine = YES;
    cell2.key = @"insurance_force";
    cell2.imageURL = [NSURL URLWithString:model.insurance_force_images];
    cell2.isImageShow = !LC_isStrEmpty(model.insurance_force_images);
    
    InsuranceCellModel *cell3 = [InsuranceCellModel new];
    cell3.type = InsuranceDataTypeBusinessDate;
    cell3.title = @"到期日期";
    cell3.selectedContent = model.VCI_expire;
    cell3.key = @"VCI_expire";
    
    InsuranceCellModel *cell4 = [InsuranceCellModel new];
    cell4.type = InsuranceDataTypeBusinessCompany;
    cell4.title = @"承保公司";
    cell4.selectedContent = model.insurance_company;
    cell4.key = @"insurance_company";
    cell4.isHiddenLine = YES;
    cell4.imageURL = [NSURL URLWithString:model.insurance_company_images];
    cell4.isImageShow = !LC_isStrEmpty(model.insurance_company_images);
    
    InsuranceCellModel *cell5 = [InsuranceCellModel new];
    cell5.type = InsuranceDataTypeYearlyCheck;
    cell5.title = @"年检日期";
    cell5.selectedContent = model.valid_car_date;
    cell5.key = @"valid_car_date";
    cell5.isHiddenLine = YES;
    
    InsuranceSectionModel *section1 = [InsuranceSectionModel new];
    section1.title = @"交强险";
    section1.lists = @[cell1, cell2];
    
    InsuranceSectionModel *section2 = [InsuranceSectionModel new];
    section2.title = @"商业险";
    section2.lists = @[cell3, cell4];
    
    InsuranceSectionModel *section3 = [InsuranceSectionModel new];
    section3.title = @"车辆年检";
    section3.lists = @[cell5];
    
    _dataSource =@[section1, section2, section3];
}

- (NSMutableDictionary *)getSaveData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    for (InsuranceSectionModel *section in _dataSource) {
        for (InsuranceCellModel *cell in section.lists) {
            [dic setValue:cell.selectedContent forKey:cell.key];
        }
    }
    
    return dic;
}
@end

@implementation InsuranceSectionModel

@end

@implementation InsuranceCellModel

- (void)setDate:(NSDate *)date
{
    _date = date;
    
    _selectedContent = [NSDate stringFromDate:date withFormat:@"yyyy-MM-dd"];
}

@end

@implementation InsuranceDataInfoModel
@end
