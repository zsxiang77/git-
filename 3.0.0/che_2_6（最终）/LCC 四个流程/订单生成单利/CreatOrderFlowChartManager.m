//
//  CreatOrderFlowChartManager.m
//  测试
//
//  Created by lcc on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import "CreatOrderFlowChartManager.h"
@implementation ChePaiDanLi

@end

@implementation ProjectModel

@end

@implementation PartsModel

@end

@implementation ProjectListModel

@end

@implementation PartsListModel

@end


@implementation BaseCreatOrderFlowChart
- (instancetype)initWithTitle:(NSString *)string nameImageName:(NSString *)nameImageName{
    if (self = [super init]) {
        _classTitle = string;
        _classImageName = nameImageName;
        _isSelect = NO;
    }
    return self;
}
- (void)qingKongData{};
@end


//小修
@implementation SmallFixCreatOrderFlowChart

@end
//保养
@implementation MaintenanceCreatOrderFlowChart
- (void)qingKongData{
    self.projectListModel = nil;
    self.partsListModel = nil;
}
@end
//事故车
@implementation AccidentCarCreatOrderFlowChart
- (void)qingKongData{
    self.isBaoXian = NO;
}
@end
//二级维护
@implementation SecondarySafeguardCreatOrderFlowChart
- (void)qingKongData{
    self.projectModelArr = nil;
    self.title = nil;
    self.imageName = nil;
    self.allGongShiPrice = 0.0;
}
@end


@interface CreatOrderFlowChartManager()

@end

@implementation CreatOrderFlowChartManager
+ (instancetype)defaultOrderFlowChartManager{
    static CreatOrderFlowChartManager * orderFlowChartManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        orderFlowChartManager = [[CreatOrderFlowChartManager alloc]init];
        NSLog(@"=orderFlowChartManager 走了几次==");
    });
    return orderFlowChartManager;
}

- (instancetype)init{
    if (self == [super init]) {
        [self resetDefault];
    }
    return self;
}

- (void)resetDefault{
//    @[@"小修",@"保养",@"事故车",@"二级维护"]
    
    self.smallFix           = [[SmallFixCreatOrderFlowChart alloc]initWithTitle:@"小修" nameImageName:@"小修"];
    self.maintenance        = [[MaintenanceCreatOrderFlowChart alloc]initWithTitle:@"保养" nameImageName:@"保养"];
    self.accidentCar        = [[AccidentCarCreatOrderFlowChart alloc]initWithTitle:@"事故车" nameImageName:@"事故车"];
    self.secondarySafeguard = [[SecondarySafeguardCreatOrderFlowChart alloc]initWithTitle:@"二级维护" nameImageName:@"二级维护"];
    
    self.chePaiDict = [[ChePaiDanLi alloc]init];
    
    _creatOrderFlowArr      = @[self.smallFix,self.maintenance,self.accidentCar,self.secondarySafeguard];
    _messageVModelArr       = @[].mutableCopy;
}
@end
