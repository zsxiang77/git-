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

@interface LearningVideoViewController : BOSSBaseViewController

/**CLplayer*/
@property (nonatomic,strong) CLPlayerView *playerView;

@property(nonatomic,strong)NSString *video_id;

@property(nonatomic,strong)LearningVideoModel *mainModel;

@end


@interface LearningVideoViewController (Net)
-(void)qingQiuLuoBoData;

@end
