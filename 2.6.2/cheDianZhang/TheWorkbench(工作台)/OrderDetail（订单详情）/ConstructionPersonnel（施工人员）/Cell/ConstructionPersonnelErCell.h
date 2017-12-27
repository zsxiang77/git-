//
//  ConstructionPersonnelErCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/25.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConstructionPersonnelErModel.h"
#import "CheDianZhangCommon.h"
#import "BaseViewController.h"
#import "ConstructionPersonnelErVC.h"
#import "SalesStaffViewController.h"

@interface ConstructionPersonnelErCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView* m_collectionView;
}
@property(nonatomic,strong)NSMutableArray *xiuGaiArray;
@property(nonatomic,strong)NSArray *lotteryInfos;
@property(nonatomic,assign)BOOL xiuGai;
@property(nonatomic,strong)BaseViewController *superViewController;

@property(nonatomic,assign)BOOL shiFouDanXuan;

-(void)refeleseWithModel:(NSArray *)array withXiuGai:(BOOL)xiu withXiuGaiArray:(NSMutableArray *)ar;


@end
