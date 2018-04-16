//
//  ScanDrivingLicenseTFCell.h
//  测试
//
//  Created by sykj on 2018/2/3.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMUITextField.h"

@interface ScanDrivingLicenseTFCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) QMUITextField *textField;

@property (nonatomic, assign) BOOL isHiddenLine;

@property(nonatomic, copy) void (^textFieldTextChangeBlock)(NSString *text);
@property(nonatomic, copy) void (^textFieldTextShouldChangeBlock)(NSString *text);
@end
