//
//  LearningVideoViewController.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/3/28.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "LearningVideoModel.h"
#import "CLPlayerView.h"
#import "UIView+CLSetRect.h"
#import "LearningZuoCeShiViewController.h"

@interface LearningVideoViewController : BOSSBaseViewController
{
    UIScrollView *zuoYouScrollView;
}

/**CLplayer*/
@property (nonatomic,strong) CLPlayerView *playerView;

@property(nonatomic,strong)NSString *video_id;


@property(nonatomic,strong)NSMutableArray *mainJiShuArray;
@property(nonatomic,strong)NSMutableArray *mainListArray;

@property(nonatomic,strong)UITableView *mainTableView;

//@property(nonatomic,strong)NSString    * 

@end


@interface LearningVideoViewController (Net)
-(void)qingQiuLuoBoData;
//收藏
-(void)postdo_article_praise:(LearningModel *)model withIndex:(NSIndexPath*)index;

@end
