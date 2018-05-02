//
//  StoreYuanXingtuView.h
//  cheDianZhang
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CPArcModel;
@interface StoreYuanXingtuView : UIView
{
    UIView * gundongView;
}
/**
 *  弧度模型数组
 */
@property (nonatomic, strong)NSArray<CPArcModel *> *arcs;
@property (nonatomic, strong)UIBezierPath *bezierPath;
@property (nonatomic, assign) BOOL isSelectXuan;
@end
