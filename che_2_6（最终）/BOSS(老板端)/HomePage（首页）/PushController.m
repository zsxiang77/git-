//
//  PushController.m
//  LeftMenu
//
//  Created by iMac on 17/4/24.
//  Copyright © 2017年 zws. All rights reserved.
//

#import "PushController.h"
#import "CheDianZhangCommon.h"

@interface PushController ()

@end

@implementation PushController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopViewWithTitle:self.titleString withBackButton:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, kWindowW, kWindowH-44)];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];
    
    
}

@end
