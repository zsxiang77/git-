//
//  JobBoardHeaderView.h
//  laoBanDuan
//
//  Created by 马蜂 on 2018/1/8.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "DuplexTableHeardView.h"


@interface JobBoardHeaderView : DuplexTableHeardView
- (void)scrollViewDidScroll:(float)offY;

- (void)refreshAllData:(NSDictionary*)dic;

@end
