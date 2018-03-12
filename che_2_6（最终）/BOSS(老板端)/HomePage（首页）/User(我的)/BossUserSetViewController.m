//
//  BossUserSetViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/1/9.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "BossUserSetViewController.h"
#import "BUserCell.h"
#import "NSString+MD5.h"
#import "UserAgreementViewController.h"
#import "BOSSAboutUsViewController.h"
#import "LonInViewController.h"


@interface BossUserSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,assign)CGFloat neiCun;

@end

@implementation BossUserSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"设置" withBackButton:YES];
    self.neiCun = [self readCacheSize];
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kBOSSNavBarHeight, kWindowW, kWindowH-kBOSSNavBarHeight) style:UITableViewStylePlain];
    _mainTableView.dataSource = self;
    _mainTableView.delegate  = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mainTableView];
    
    
}

-(CGFloat)readCacheSize
{
    NSString *cachePath = [@"articleContent" cacheDir];
    return [self folderSizeAtPath :cachePath];
}
// 遍历文件夹获得文件夹大小，返回多少 M
- (CGFloat)folderSizeAtPath:(NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [self fileSizeAtPath :fileAbsolutePath];
    }
    
    return folderSize/( 1024.0 * 1024.0);
    
}
// 计算 单个文件的大小
- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}

// 清除缓存
- (void)clearFile
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
    
    //读取缓存大小
    self.neiCun = [self readCacheSize];
    [self.mainTableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    BUserCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[BUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.jianTouImageView.hidden = NO;
    
    if (indexPath.row == 0) {
        cell.mainImageView.image = DJImageNamed(@"boss_huanCun");
        cell.rightLabl.text = [NSString stringWithFormat:@"%.1fM",self.neiCun];
        cell.mainLabl.text = @"清理缓存";
    } else if (indexPath.row == 1) {
        cell.mainImageView.image = DJImageNamed(@"boss_user");
        cell.mainLabl.text = @"关于我们";
    } else if (indexPath.row == 2) {
        cell.mainImageView.image = DJImageNamed(@"boss_Xieyi");
        cell.mainLabl.text = @"用户协议";
    } 
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footvowe = [[UIView alloc]init];
    
    UIButton *tuiChuBt = [[UIButton alloc]init];
    tuiChuBt.backgroundColor = kRGBColor(239, 239, 239);
    tuiChuBt.titleLabel.font = [UIFont systemFontOfSize:17];
    [tuiChuBt setTitle:@"退出登录" forState:(UIControlStateNormal)];
    [tuiChuBt setTitleColor:kRGBColor(74, 74, 74) forState:(UIControlStateNormal)];
    [tuiChuBt.layer setMasksToBounds:YES];
    [tuiChuBt.layer setCornerRadius:5];
    [tuiChuBt addTarget:self action:@selector(tuiChuBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [footvowe addSubview:tuiChuBt];
    [tuiChuBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(63);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(48);
    }];
    return footvowe;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 61;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self clearFile];
    }
    
    if (indexPath.row == 1) {
        BOSSAboutUsViewController *vc = [[BOSSAboutUsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        UserAgreementViewController *vc = [[UserAgreementViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)tuiChuBtChick:(UIButton *)sender
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"确定退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    alert.tag = 100;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            
            [self loginOut];
        }
    }
}

- (void)loginOut
{
    NSString *path = [NSString stringWithFormat:@"%@store_staff/staff_user/staff",HOST_URL];
    NPrintLog(@"%@",path);
    
    
    [self requestPUTWithURLStr:path paramDic:nil Api_key:nil];
}
- (void)requestPUTWithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic Api_key:(NSString *)api_key{
    kWeakSelf(weakSelf)
    [self showOrHideLoadView:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    [manager.requestSerializer setValue:KISDictionaryHaveKey([UserInfo shareInstance].userNameDict, @"Set-Cookie") forHTTPHeaderField:@"Set-Cookie"];
    [manager DELETE:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self showOrHideLoadView:NO];
        [[UserInfo shareInstance] cleanUserInfor];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];//发送退出登录成功
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
        } seq:1];
        
        LonInViewController *vc = [[LonInViewController alloc]init];
        [weakSelf presentViewController:vc animated:YES completion:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NPrintLog(@"请求失败 %@",error);
        [self showOrHideLoadView:NO];
    }];
}

@end
