//
//  FoundDetailHeaderView.h
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/24.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<WebKit/WebKit.h>
#import "BOSSCheDianZhangCommon.h"
#import "FoundDetailModel.h"

@interface FoundDetailHeaderView : UIView<WKUIDelegate,WKNavigationDelegate>
{
    UILabel *m_titleLable;
    UILabel *m_nameLable;
    UILabel *m_dateLable;
    
    
    UIButton *m_dianZanBt;
    
    UILabel *m_zanNumberLable;
    UILabel *m_pingNumberLable;
    UILabel *m_yueDuNumberLable;
}

@property(nonatomic,strong)WKWebView*    webView;
@property(nonatomic,strong)UIImageView*    webViewimb;
@property(nonatomic,strong)void  (^dianZanBtChickBlock)(void);

-(void)refleshdata:(FoundDetailModel *)model withBuju:(BOOL)buju;
-(void)setanniuDianJidata:(FoundDetailModel *)model;


@end
