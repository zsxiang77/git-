//
//  FoundCell.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/24.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoundModel.h"
#import "UIImageView+WebCache.h"

@interface FoundCell : UITableViewCell
{
    UILabel *m_titileLabel;
    UIImageView *m_mianImageView;
    
    
    UILabel *m_pingLunLabel;
    UILabel *m_zanLabel;
    UILabel *m_dateLabel;
}


-(void)refleshData:(FoundModel *)dict;
@end
