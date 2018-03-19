//
//  LoadView.m
//  RuYiCai
//
//  Created by  on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoadView.h"
#import "CheDianZhangCommon.h"

@implementation LoadView

- (id)init
{
    self = [super init];
    if (self)
    {	
        self.frame = CGRectMake(0, 64, kWindowW, kWindowH - 64);
        self.backgroundColor = [UIColor clearColor];
        
//        UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
//        bgView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-30);
//        bgView.alpha = 0.7f;
//        bgView.backgroundColor = [UIColor blackColor];
//        bgView.layer.cornerRadius = 8;
//        [self addSubview:bgView];
//
//        m_activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        m_activityView.center = CGPointMake(90/2.0, 90/2.0 - 10);
////        [m_activityView performSelectorOnMainThread:@selector(dismissView) withObject:nil waitUntilDone:YES];
//        [bgView addSubview:m_activityView];
//
//        UILabel*  titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
//        titleLabel.text = @"加载中...";
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        titleLabel.textColor = [UIColor whiteColor];
//        titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
//        titleLabel.backgroundColor = [UIColor clearColor];
//        titleLabel.center = CGPointMake(m_activityView.center.x, m_activityView.center.y + 35);
//        [bgView addSubview:titleLabel];
        mainWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 100, kWindowW, 320)];
        mainWebView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:mainWebView];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"gif20" ofType:@"gif"];
        NSURL *url = [NSURL URLWithString:path];
        [mainWebView loadRequest:[NSURLRequest requestWithURL:url]];
        mainWebView.userInteractionEnabled = NO;//用户不可交互
    }
    return self;
}

- (void)displayView
{
  //  [m_activityView startAnimating];

    self.hidden = NO;
}

- (void)dismissView
{
    
  //  [m_activityView stopAnimating];

    self.hidden = YES;
}

@end
