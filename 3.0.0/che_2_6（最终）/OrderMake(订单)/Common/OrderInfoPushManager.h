//
//  OrderInfoPushManager.h
//  cheDianZhang
//
//  Created by sykj on 2018/2/4.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

typedef NS_ENUM(NSUInteger, OrderInfoPushType) {
    OrderInfoPushTypeNone = 0,
    OrderInfoPushTypePerctInfo, ///< 完善信息
    OrderInfoPushTypeBuildOrder,///< 订单
    OrderInfoPushTypeOrderDetail///< 订单详情
};

@interface OrderInfoPushManager : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(OrderInfoPushManager)

@property (nonatomic, assign) OrderInfoPushType type;
@end
