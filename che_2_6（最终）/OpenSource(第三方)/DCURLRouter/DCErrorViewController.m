//
//  DCErrorViewController.m
//  DaJiang365
//
//  Created by 黄鑫 on 16/11/2.
//  Copyright © 2016年 泰宇. All rights reserved.
//

#import "DCErrorViewController.h"

@interface DCErrorViewController ()

@end

@implementation DCErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTopViewWithTitle:@"出错了" withBackButton:YES];
    
    UILabel *errorMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake((kWindowW-80)*0.5, (kWindowH-100)*0.5, kWindowW-80, 100)];
    errorMessageLabel.text = @"不好意思，页面走丢了～";
    errorMessageLabel.textAlignment = 1;
    errorMessageLabel.textColor = UIColorFromRGBA(0x999999, 1.0);
    errorMessageLabel.numberOfLines = 0;
    errorMessageLabel.font = [UIFont boldSystemFontOfSize:20.0];
    [self.view addSubview:errorMessageLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
