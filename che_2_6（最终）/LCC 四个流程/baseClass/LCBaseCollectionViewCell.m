//
//  LCBaseCollectionViewCell.m
//  PigTrading
//
//  Created by lcc on 2017/7/18.
//  Copyright © 2017年 Lori. All rights reserved.
//

#import "LCBaseCollectionViewCell.h"

@implementation LCBaseCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.contentView.clipsToBounds = YES;
        self.clipsToBounds = YES;
        [self setUpViews];
//        if ([self conformsToProtocol:@protocol(LCBaseCellProtocol)] && [self respondsToSelector:@selector(setUpViews)]) {
//            
//        }
    }
    return self;
}
-(void)setUpViews{}
-(void)bingViewModel:(id)viewModel{};
@end
