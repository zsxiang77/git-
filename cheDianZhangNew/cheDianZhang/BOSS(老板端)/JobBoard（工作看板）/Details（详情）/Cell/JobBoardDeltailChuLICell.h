//
//  JobBoardDeltailChuLICell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/20.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobBoardDeltailChuLICell : UITableViewCell
{
    UILabel *shangXianLine;
    UILabel *xiaXianLine;
    UIImageView *xianquFenImageView;
    
    UIImageView *zuiXinImageView;
    
    UILabel *dateLabel;
    UIImageView *jiXueImageView;
    UILabel *jiXueLabel;
    UILabel *jiXueDateLabel;
    UILabel *beiZhuLabel;
    
    UIView *couponView;
}

-(void)refreshIndex:(NSInteger )index withdict:(NSDictionary *)dict xian:(BOOL)xian;
@end
