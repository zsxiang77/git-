//
//  ScanDrivingLicenseVinCell.h
//  cheDianZhang
//
//  Created by kingdream on 2018/2/6.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMUITextField.h"

@interface ScanDrivingLicenseVinCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) QMUITextField *textField;
@property (nonatomic, strong) UILabel *numberTipLb;

@property (nonatomic, assign) BOOL isHiddenLine;

@property(nonatomic, copy) void (^textFieldTextChangeBlock)(NSString *text);

@end
