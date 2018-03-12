//
//  ViewPerfectInformationCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/2/26.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewPerfectInformationModel.h"
#import "ViewPerfectInformationVC.h"
#import "PreviewPictureViewController.h"

@interface ViewPerfectInformationCell : UITableViewCell
@property(nonatomic,strong)UIView *mianView;
@property(nonatomic,strong)ViewPerfectInformationVC *superViewController;

@property(nonatomic,strong)NSArray *tuPianArray;


-(void)refeleseWithModel:(ViewPerfectInformationModel *)model;
@end
