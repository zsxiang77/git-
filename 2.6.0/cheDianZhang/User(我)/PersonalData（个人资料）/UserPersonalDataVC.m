//
//  UserPersonalDataVC.m
//  cheDianZhang
//
//  Created by 马蜂 on 2017/9/20.
//  Copyright © 2017年 马蜂. All rights reserved.
//

#import "UserPersonalDataVC.h"
#import "LonInViewController.h"
#import "JPUSHService.h"
#import "UIImageView+WebCache.h"
#import "SettingAITSerialNumberVC.h"
#import "AITListViewController.h"


@interface UserPersonalDataVC ()<UIAlertViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic,strong)UILabel *modileLabel;
@property(nonatomic, retain)UIImageView* userImageView;//选择的照片

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *stateLabel;


@property(nonatomic,strong)UIView *aitZhanShiView;

@end

@implementation UserPersonalDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"个人资料" withBackButton:NO];
    
    UIView *shangView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+10, kWindowW, 80)];
    shangView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shangView];
    
    self.userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
    [self.userImageView.layer setMasksToBounds:YES];
    [self.userImageView.layer setCornerRadius:50/2];
    [self.userImageView  sd_setImageWithURL:[NSURL URLWithString:[UserInfo shareInstance].userAvatar] placeholderImage:DJImageNamed(@"touxiang")];
    [shangView addSubview:self.userImageView];
    
    UIButton *touXiangBt = [[UIButton alloc]init];
    [touXiangBt addTarget:self action:@selector(selectImageClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [shangView addSubview:touXiangBt];
    [touXiangBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(shangView);
        make.width.height.mas_equalTo(60);
    }];
    
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.text =  [UserInfo shareInstance].userReal_name;
    [shangView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(shangView.mas_centerY);
        make.left.mas_equalTo(75);
    }];
    
    self.stateLabel = [[UILabel alloc]init];
    self.stateLabel.text =  [UserInfo shareInstance].userRole;
    self.stateLabel.font = [UIFont systemFontOfSize:13];
    [shangView addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(75);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_equalTo(5);
    }];
    
    UIView *view2 = [[UIView alloc]init];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(shangView.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *zhangLabel1 = [[UILabel alloc]init];
    zhangLabel1.text = @"账号:";
    zhangLabel1.font = [UIFont systemFontOfSize:14];
    [view2 addSubview:zhangLabel1];
    [zhangLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(view2);
    }];
    
    UILabel *zhangLabel2 = [[UILabel alloc]init];
    zhangLabel2.tag = 3001;
    zhangLabel2.font = [UIFont systemFontOfSize:14];
    zhangLabel2.textColor = [UIColor grayColor];
    zhangLabel2.text = [UserInfo shareInstance].userZhangHao;
    [view2 addSubview:zhangLabel2];
    [zhangLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(zhangLabel1.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(view2);
    }];
    
    UIView *view3 = [[UIView alloc]init];
    view3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(view2.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *shouJila = [[UILabel alloc]init];
    shouJila.text = @"手机:";
    shouJila.font = [UIFont systemFontOfSize:14];
    [view3 addSubview:shouJila];
    [shouJila mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(view3);
    }];
    
    self.modileLabel = [[UILabel alloc]init];
    self.modileLabel.font = [UIFont systemFontOfSize:14];
    self.modileLabel.text = [UserInfo shareInstance].userMobile;
    self.modileLabel.textColor = [UIColor grayColor];
    [view3 addSubview:self.modileLabel];
    [self.modileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(shouJila.mas_right).mas_equalTo(10);
        make.centerY.mas_equalTo(view3);
    }];
    
    
    UIButton *guanYuBt = [[UIButton alloc]init];
    self.aitZhanShiView = [[UIView alloc]init];
    self.aitZhanShiView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.aitZhanShiView];
    [self.aitZhanShiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(view3.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(40);
    }];
    self.aitZhanShiView.hidden = YES;
    
    UILabel *aITnameLabel = [[UILabel alloc]init];
    aITnameLabel.font = [UIFont systemFontOfSize:14];
    aITnameLabel.text = @"AIT产品";
    [self.aitZhanShiView addSubview:aITnameLabel];
    [aITnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.aitZhanShiView);
    }];
    
    UIImageView *youAitImageView = [[UIImageView alloc]initWithImage:DJImageNamed(@"13_arrow")];
    [self.aitZhanShiView addSubview:youAitImageView];
    [youAitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.aitZhanShiView);
        make.width.mas_equalTo(19/2);
        make.height.mas_equalTo(((19/2)*33)/19);
    }];
    
    self.aITLabel = [[UILabel alloc]init];
    self.aITLabel.font = [UIFont systemFontOfSize:14];
//    if (indexAit>0) {
//        self.aITLabel.text = [NSString stringWithFormat:@"%ld",(long)indexAit];
//    }else{
//        self.aITLabel.text = @"前往设置序列号";
//    }
    
    self.aITLabel.textColor = UIColorFromRGBA(0x00d383, 1);
    [self.aitZhanShiView addSubview:self.aITLabel];
    [self.aITLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(youAitImageView.mas_left).mas_equalTo(-5);
        make.centerY.mas_equalTo(self.aitZhanShiView);
    }];
    
    UIButton *aitBt = [[UIButton alloc]init];
    [aitBt addTarget:self action:@selector(aitBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.aitZhanShiView addSubview:aitBt];
    [aitBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    guanYuBt.titleLabel.font = [UIFont systemFontOfSize:14];
    [guanYuBt setTitle:@"关于我们" forState:(UIControlStateNormal)];
    [guanYuBt setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [guanYuBt addTarget:self action:@selector(guanYuMeChick:) forControlEvents:(UIControlEventTouchUpInside)];
    guanYuBt.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:guanYuBt];
    [guanYuBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.aitZhanShiView.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(40);
    }];
    
    
    
    
    
    
    
    
    
    
    UIButton *tuiChuBt = [[UIButton alloc]init];
    tuiChuBt.backgroundColor = [UIColor whiteColor];
    [tuiChuBt addTarget:self action:@selector(tuiChuBtChick:) forControlEvents:(UIControlEventTouchUpInside)];
    [tuiChuBt setTitle:@"退出当前账户" forState:(UIControlStateNormal)];
    [tuiChuBt setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [tuiChuBt.layer setMasksToBounds:YES];
    [tuiChuBt.layer setCornerRadius:3];
    [self.view addSubview:tuiChuBt];
    [tuiChuBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(35);
        make.bottom.mas_equalTo(-100);
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self postHuoQuModele];
}

-(void)postHuoQuModele
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"data_center/privateinfo/staff_detail" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        NSDictionary *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        weakSelf.chiZhiDict = adData;
        [UserInfo shareInstance].userMobile = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(adData, @"mobile")];
        [UserInfo shareInstance].userAvatar = [NSString stringWithFormat:@"%@",KISDictionaryHaveKey(adData, @"avatar")];
        [UserInfo saveUserName];
        
        [weakSelf.userImageView  sd_setImageWithURL:[NSURL URLWithString:[UserInfo shareInstance].userAvatar] placeholderImage:DJImageNamed(@"touxiang")];
        weakSelf.aITLabel.text =  [UserInfo shareInstance].userReal_name;
        weakSelf.stateLabel.text =  [UserInfo shareInstance].userRole;
        
        UILabel *zhaLa = [weakSelf.view viewWithTag:3001];
        zhaLa.text = [UserInfo shareInstance].userZhangHao;
        
        weakSelf.modileLabel.text = [UserInfo shareInstance].userMobile;
        
        NSInteger indexAit = [KISDictionaryHaveKey(weakSelf.chiZhiDict, @"ait_num") integerValue];
        BOOL ait_switch = [KISDictionaryHaveKey(weakSelf.chiZhiDict, @"ait_switch") boolValue];
        if (ait_switch == YES) {
            weakSelf.aitZhanShiView.hidden = NO;
            if (indexAit>0) {
                weakSelf.aITLabel.text = [NSString stringWithFormat:@"%ld",(long)indexAit];
            }else{
                weakSelf.aITLabel.text = @"前往设置序列号";
            }
        }else{
            weakSelf.aitZhanShiView.hidden = YES;
        }
    } failure:^(id error) {
        
    }];
}

-(void)aitBtChick:(UIButton *)sender
{
//    SettingAITSerialNumberVC *vc = [[SettingAITSerialNumberVC alloc]init];
    
    
    AITListViewController *vc = [[AITListViewController alloc]init];
    kWeakSelf(weakSelf)
    vc.shuXianNumber = ^(NSInteger sender) {
        if (sender>0) {
            weakSelf.aITLabel.text = [NSString stringWithFormat:@"%ld",(long)sender];
        }else{
            weakSelf.aITLabel.text = @"前往设置序列号";
        }
    };
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)guanYuMeChick:(UIButton *)sender
{
    AboutUsViewController *vc = [[AboutUsViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tuiChuBtChick:(UIButton *)sender
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"确定退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    alert.tag = 100;
    [alert show];
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

- (void)loginOut
{
    NSString *path = [NSString stringWithFormat:@"%@store_staff/staff_user/staff",HOST_URL];
    NPrintLog(@"%@",path);
    
    
    [self requestPUTWithURLStr:path paramDic:nil Api_key:nil];

    
}

#pragma mark - 上传图片
- (void)selectImageClick:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    [actionSheet addButtonWithTitle:@"拍照"];
    [actionSheet addButtonWithTitle:@"从相册获取"];
    [actionSheet addButtonWithTitle:@"取消"];
    actionSheet.cancelButtonIndex = 2;
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    switch (buttonIndex) {
        case 0:
        {
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"未获取到权限" message:@"请前往手机设置－车店长－相机－打开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
                alert.tag = 103;
                [alert show];
                return;
            }
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *imagePicker = [UIImagePickerController new];
                imagePicker.allowsEditing = YES;
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            break;
        }
        case 1:
        {
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied)
            {
                //无权限
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"未获取到权限" message:@"请前往手机设置－车店长－照片－打开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
                alert.tag = 103;
                [alert show];
                return;
            }
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                UIImagePickerController *imagePicker = [UIImagePickerController new];
                imagePicker.allowsEditing = YES;
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            break;
        }
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            
            [self loginOut];
        }
    }
    if (buttonIndex != alertView.cancelButtonIndex) {
        if(alertView.tag == 103){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];//8.0以上方法
        }
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)mediaInfo
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    if ([[mediaInfo allKeys] containsObject:UIImagePickerControllerEditedImage]) {
        [self getQiNiuTokenFromServer:mediaInfo[UIImagePickerControllerEditedImage]];
    }
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)getQiNiuTokenFromServer:(UIImage *)image
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:image];
    kWeakSelf(weakSelf)
    [NetWorkManager touXiangrequestDuoZhangWithParametersUIImageJPEGRepresentationWithUrl:@"order/order_queue/upload_file" viewController:self isShowLoading:YES withimage:array success:^(id responseObject) {
        NSDictionary *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        [weakSelf changTouXiang:KISDictionaryHaveKey(adData, @"names")];
    } failure:^(id error) {
        
    }];
}

-(void)changTouXiang:(NSString *)dizhi
{
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [mDict setObject:dizhi forKey:@"avatar"];
    
    kWeakSelf(weakSelf)
    [NetWorkManager requestWithParameters:mDict withUrl:@"data_center/privateinfo/staff_avatar2" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        
        NSDictionary *adData = kParseData(responseObject);
        if (![adData isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        
        [UserInfo shareInstance].userAvatar = KISDictionaryHaveKey(adData, @"image_url");
        [UserInfo saveUserName];
        [weakSelf.userImageView  sd_setImageWithURL:[NSURL URLWithString:[UserInfo shareInstance].userAvatar] placeholderImage:DJImageNamed(@"touxiang")];
        
    } failure:^(id error) {
        
    }];
}


@end
