//
//  LCMessageViewModel.h
//  测试
//
//  Created by lcc on 2018/1/31.
//  Copyright © 2018年 lcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCMessageViewModel : NSObject
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *timeStamp;
@property (nonatomic, assign) CGFloat cell_H;

//@property (nonatomic, assign) CGFloat imageView_W;
//@property (nonatomic, assign) CGFloat imageView_H;
@end
