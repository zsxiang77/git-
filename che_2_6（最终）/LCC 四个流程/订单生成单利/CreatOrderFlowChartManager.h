//
//  CreatOrderFlowChartManager.h
//  测试
//
//  Created by lcc on 2018/2/2.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCMessageViewModel.h"

//
//@interface SecondarySafeguardModel :NSObject
//@property (nonatomic, strong) NSString *weiHuName;
//@property (nonatomic, strong) NSString *price;
//@property (nonatomic, strong) NSString *time;
//@property (nonatomic, strong) NSString *subjectId;
//@end

//车牌单里
@interface ChePaiDanLi : NSObject
@property (nonatomic, strong) NSString *chePaiStr;
@property (nonatomic, strong) NSString *chePaiYanSe;
@end


//项目 model
@interface ProjectModel :NSObject
@property (nonatomic, strong) NSString *projectName;
@property (nonatomic, strong) NSString *price; //总工时费
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *subjectId;
@end
//配件 model
@interface PartsModel :NSObject
@property (nonatomic, strong) NSString *partsName;
@property (nonatomic, strong) NSString *unitPrice;
@property (nonatomic, strong) NSString *num; //个数
@property (nonatomic, strong) NSString *partsId;
@end

@interface ProjectListModel :NSObject
@property (nonatomic, strong) NSArray <ProjectModel *>*projectModelArr;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) float allGongShiPrice;
@end

@interface PartsListModel :NSObject
@property (nonatomic, strong) NSArray <PartsModel *>*partsModelArr;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) float allPeiJianPrice;
@end



@interface BaseCreatOrderFlowChart : NSObject
@property (nonatomic, readonly) NSString *classImageName;
@property (nonatomic, readonly) NSString *classTitle;
@property (nonatomic, assign) BOOL isSelect;
- (instancetype)initWithTitle:(NSString *)string nameImageName:(NSString *)nameImageName;
- (void)qingKongData;
@end


//小修
@interface SmallFixCreatOrderFlowChart : BaseCreatOrderFlowChart

@end
//保养
@interface MaintenanceCreatOrderFlowChart : BaseCreatOrderFlowChart
@property (nonatomic, strong) ProjectListModel *projectListModel; //项目
@property (nonatomic, strong) PartsListModel   *partsListModel;
@end
//事故车
@interface AccidentCarCreatOrderFlowChart : BaseCreatOrderFlowChart
@property (nonatomic, assign) BOOL isBaoXian;
@end

//二级维护
@interface SecondarySafeguardCreatOrderFlowChart : BaseCreatOrderFlowChart
@property (nonatomic, strong) NSArray <ProjectModel *>*projectModelArr;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) float allGongShiPrice;
@end



@interface CreatOrderFlowChartManager : NSObject
+ (instancetype)defaultOrderFlowChartManager;
@property (nonatomic, strong) NSMutableArray <LCMessageViewModel *> *messageVModelArr; //消息
@property (nonatomic, readonly) NSArray <BaseCreatOrderFlowChart *> *creatOrderFlowArr;

@property (nonatomic, strong) SmallFixCreatOrderFlowChart           *smallFix;   //小修
@property (nonatomic, strong) MaintenanceCreatOrderFlowChart        *maintenance;//保养
@property (nonatomic, strong) AccidentCarCreatOrderFlowChart        *accidentCar;//事故车
@property (nonatomic, strong) SecondarySafeguardCreatOrderFlowChart *secondarySafeguard;//二级维护
@property (nonatomic, strong) NSString *orderNun;
@property (nonatomic, strong) ChePaiDanLi *chePaiDict;
- (void)resetDefault;
@end
