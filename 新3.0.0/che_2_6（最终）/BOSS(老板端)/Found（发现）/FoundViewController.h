//
//  FoundViewController.h
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/5.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BOSSBaseViewController.h"
#import "FoundModel.h"

@interface FoundViewController : BOSSBaseViewController
{
    UIImageView                   *touImaage;
    NSInteger                   page;
}

@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)NSMutableArray  *mainDataArray;
@property(nonatomic,strong)NSDictionary *mainDataDict;

@end


@interface FoundViewController (Net)
-(void)postrequest_methodDatawithShuaXin:(BOOL)shuaX;
-(void)postdo_article_praise:(FoundModel *)model;
@end
