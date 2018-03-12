//
//  ALAsset+mExport.h
//  cheDianZhang
//
//  Created by 马蜂 on 2017/10/10.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

@interface ALAsset (mExport)
- (BOOL) exportDataToURL: (NSURL*) fileURL error: (NSError**) error;

@end
