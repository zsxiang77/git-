//
//  ConstructionPersonnelErCell.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/25.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "ConstructionPersonnelErCell.h"
#import "ConstructionErCollectionCell.h"

@implementation ConstructionPersonnelErCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        float itemWidth = kWindowW/4;
        float itemHeight = kWindowW/4+20;//itemWidth/2.0;
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        layout.sectionInset = UIEdgeInsetsZero;
        layout.headerReferenceSize = (CGSize){kWindowW,  0};
        
        m_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        m_collectionView.backgroundColor = [UIColor whiteColor];
        m_collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        m_collectionView.delegate = self;
        m_collectionView.dataSource = self;
        [m_collectionView registerClass:[ConstructionErCollectionCell class] forCellWithReuseIdentifier:@"Cell"];
        [self.contentView addSubview:m_collectionView];
        [m_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        self.xiuGai = NO;
    }
    return self;
}

-(void)refeleseWithModel:(NSArray *)array withXiuGai:(BOOL)xiu withXiuGaiArray:(NSMutableArray *)ar
{
    self.xiuGaiArray = ar;
    self.xiuGai = xiu;
    self.lotteryInfos = array;
    [m_collectionView reloadData];
}

#pragma mark collection delegete
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.lotteryInfos count];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    ConstructionErCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    ConstructionStaffModel *model = self.lotteryInfos[indexPath.row];
    cell.zhuModel = model;
    cell.maiImageView.hidden = NO;
    cell.titleLabel.text = model.real_name;
    if (self.xiuGai == YES) {
        cell.youShangBt.selected = NO;
        cell.youShangBt.hidden = NO;
        [cell.youShangBt setUserInteractionEnabled:YES];
        kWeakSelf(weakSelf)
        cell.shanChuBtBlock = ^(ConstructionStaffModel *model) {
            [weakSelf.xiuGaiArray removeObject:model];
            model.shiFouXuanZhong = NO;
            ConstructionPersonnelErVC *vc = (ConstructionPersonnelErVC *)weakSelf.superViewController;
            [vc.main_tableView reloadData];
        };
    }else
    {
        cell.youShangBt.selected = YES;
        if (model.shiFouXuanZhong) {
            cell.youShangBt.hidden = NO;
        }else
        {
            cell.youShangBt.hidden = YES;
        }
        [cell.youShangBt setUserInteractionEnabled:NO];
    }
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.shiFouDanXuan == YES) {
        for (int i = 0; i<self.lotteryInfos.count; i++) {
            ConstructionStaffModel *model = self.lotteryInfos[i];
            model.shiFouXuanZhong = NO;
        }
        [self.xiuGaiArray removeAllObjects];
    }
    ConstructionPersonnelErVC *vc = (ConstructionPersonnelErVC *)self.superViewController;
    if ([vc isKindOfClass:[ConstructionPersonnelErVC class]]) {
        ConstructionStaffModel *model = self.lotteryInfos[indexPath.row];
        if (self.xiuGai == NO) {
            if (self.xiuGaiArray.count>=4 && model.shiFouXuanZhong==NO) {
            }else{
                model.shiFouXuanZhong = !model.shiFouXuanZhong;
            }
            
        }
        
        if (model.shiFouXuanZhong == NO) {
            [self.xiuGaiArray removeObject:model];
        }else
        {
            
            if (![self.xiuGaiArray containsObject: model]) {
                if (self.xiuGaiArray.count>=4) {
                    [vc showMessageWindowWithTitle:@"最多选择4人" point:vc.view.center delay:1];
                }else{
                    [self.xiuGaiArray addObject:model];
                }
            }
        }
        [vc.main_tableView reloadData];
    }else{
        SalesStaffViewController *newVc = (SalesStaffViewController *)self.superViewController;
        ConstructionStaffModel *model = self.lotteryInfos[indexPath.row];
        model.shiFouXuanZhong = !model.shiFouXuanZhong;
        
        if (model.shiFouXuanZhong == NO) {
            [self.xiuGaiArray removeObject:model];
        }else
        {
            
            if (![self.xiuGaiArray containsObject: model]) {
                if (self.xiuGaiArray.count>=1) {
                    [newVc showMessageWindowWithTitle:@"最多选择1人" point:vc.view.center delay:1];
                }else{
                    [self.xiuGaiArray addObject:model];
                }
            }
        }
        [newVc.main_tableView reloadData];
        
    }

}

@end
