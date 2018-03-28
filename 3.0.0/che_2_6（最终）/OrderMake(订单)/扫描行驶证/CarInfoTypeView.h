//
//  CarInfoTypeView.h
//  测试
//
//  Created by sykj on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarInfoTypeView : UIView
@property (nonatomic, strong) NSString *selectedCar;

- (NSString *)getSelectedCarParam;

- (void)setSelectedCarWithCatTypeInt:(NSInteger)carTypeInt;

@end
