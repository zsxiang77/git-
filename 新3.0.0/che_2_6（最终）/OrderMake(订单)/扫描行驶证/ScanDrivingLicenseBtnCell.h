//
//  ScanDrivingLicenseBtnCell.h
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanDrivingLicenseBtnCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLb;
/// YES=运营, NO=非运营
@property (nonatomic, assign) BOOL isOperate;

@property (nonatomic, assign) BOOL isHiddenLine;

@property(nonatomic, copy) void (^valueChangeBlock)(NSString *operateText);

@end
