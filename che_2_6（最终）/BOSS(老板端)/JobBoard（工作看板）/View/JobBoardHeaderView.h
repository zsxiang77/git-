//
//  JobBoardHeaderView.h
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "DuplexTableHeardView.h"


@interface JobBoardHeaderView : DuplexTableHeardView

@property(nonatomic,strong)UIButton *topTitleButton;

@property(nonatomic,strong)UIImageView *touImaage;

@property(nonatomic,assign)NSInteger xuanZhongIndex;


@property(nonatomic,strong)void (^touXiangDianJiBlock)(void);
@property(nonatomic,strong)void (^playTypeClickBlock)(void);
@property(nonatomic,strong)void (^selectBtMeunChickBlock)(void);
@property(nonatomic,strong)void (^zhongQieHUanBlock)(void);//点击全部任务，重要，紧急切换


- (void)scrollViewDidScroll:(float)offY;

- (void)refreshAllData:(NSDictionary*)dic;

-(void)setTitleStrWithArrar:(NSArray *)array;

-(void)setTitleDiYiwithStr:(NSString *)set;//更改全部


@end
