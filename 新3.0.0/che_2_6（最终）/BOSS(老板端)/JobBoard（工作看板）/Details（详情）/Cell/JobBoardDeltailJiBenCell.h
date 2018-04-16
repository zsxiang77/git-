//
//  JobBoardDeltailJiBenCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/19.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobBoardDeltailJiBenCell : UITableViewCell
{
    UILabel   *zuoLabel;
    UILabel   *youLabel;
    
    UILabel   *chePaiLabel;
    UIView   *chePaiView;
    
    UILabel   *haoLabel;
    UIImageView   *jiantouImageView;
}

-(void)refreshIndex:(NSInteger )index withYouStr:(NSString *)str;

@end
