//
//  TheWorkbenchSearchViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/4/16.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BaseViewController.h"
#import "SegmentButtonsView.h"
#import "BJDC_headerTitleView.h"

@interface TheWorkbenchSearchViewController : BaseViewController<UITextFieldDelegate>
{
    UIButton *          m_mySegBtn[11];
    SegmentButtonsView* m_segButtonsView;
    BJDC_headerTitleView   *qieHuanView;
}



@property(nonatomic, retain)UIView* searchGrayBg;
@property(nonatomic, retain)UIImageView* searchImageView;
@property(nonatomic, retain)UITextField* searchText;//搜索内容
@property(nonatomic,strong)UIButton *searchOKbt;
@property(nonatomic,strong)UIButton *searchClearBt;
@property(nonatomic,strong)NSMutableArray *seachArray;
@property(nonatomic,strong)UITableView *seachTableView;
@property(nonatomic,assign)NSInteger   searchIndex;


@property(nonatomic,strong)NSDictionary *numberDict;
@property(nonatomic,strong)NSArray *channelsArray;

@property(nonatomic,assign)BOOL   shiFouWeiXiu;
@end
