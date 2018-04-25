//
//  UserMeViewController.m
//  cheDianZhang
//
//  Created by 马蜂 on 2018/4/20.
//  Copyright © 2018年 马蜂. All rights reserved.
//

#import "UserMeViewController.h"
#import "BossUserMeCell.h"
#import "UIImageView+WebCache.h"


@interface UserMeViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)UITableView *mainTableView;

@property(nonatomic,strong)UIImageView *touImageView;

@property(nonatomic,strong)NSDictionary *mainDataDict;

@end

@implementation UserMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopViewWithTitle:@"个人信息" withBackButton:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self postHuoQuUser_info];
}
-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kWindowW, kWindowH-kNavBarHeight) style:UITableViewStylePlain];
        _mainTableView.dataSource = self;
        _mainTableView.delegate  = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}

-(void)postHuoQuUser_info
{
    kWeakSelf(weakSelf)
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:10];
    [NetWorkManager requestWithParameters:mDict withUrl:@"user/ucenter/user_info" viewController:self withRedictLogin:YES isShowLoading:YES success:^(id responseObject) {
        NSInteger code = [KISDictionaryHaveKey(responseObject, @"code") integerValue];
        if (code == 200)
        {
            NSDictionary* dataDic = kParseData(responseObject);
            weakSelf.mainDataDict = dataDic;
            [UserInfo shareInstance].userAvatar = KISDictionaryHaveKey(dataDic, @"avatar");
            [UserInfo shareInstance].userReal_name = KISDictionaryHaveKey(dataDic, @"real_name");
            [UserInfo shareInstance].userZhangHao = KISDictionaryHaveKey(dataDic, @"username");
            [UserInfo shareInstance].userRole = KISDictionaryHaveKey(dataDic, @"role_name");
            [UserInfo shareInstance].userMobile = KISDictionaryHaveKey(dataDic, @"mobile");
            [UserInfo saveUserName];
            [weakSelf.mainTableView reloadData];
        }else{
            [weakSelf showAlertViewWithTitle:nil Message:KISDictionaryHaveKey(responseObject, @"msg") buttonTitle:@"确定"];
            return;
        }
    } failure:^(id error) {
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    BossUserMeCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[BossUserMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.row == 0) {
        cell.rightLabl.hidden = YES;
        cell.jianTouImageView.hidden = NO;
        cell.mainLabl.text = @"头像";
        [cell.touXiangImageView  sd_setImageWithURL:[NSURL URLWithString:[UserInfo shareInstance].userAvatar] placeholderImage:DJImageNamed(@"touxiang")];
    } else if (indexPath.row == 1) {
        cell.mainLabl.text = @"名字";
        [cell shanXinData:[UserInfo shareInstance].userReal_name withZhanShi:YES xianShiDI:NO];
    } else if (indexPath.row == 2) {
        cell.mainLabl.text = @"个人手机";
        [cell shanXinData:[UserInfo shareInstance].userMobile withZhanShi:YES xianShiDI:NO];
    } else if (indexPath.row == 3) {
        cell.mainLabl.text = @"车店长账户名称";
        [cell shanXinData:[UserInfo shareInstance].userZhangHao withZhanShi:NO xianShiDI:NO];
    } else if (indexPath.row == 4) {
        cell.mainLabl.text = @"角色";
        [cell shanXinData:[UserInfo shareInstance].userRole withZhanShi:NO xianShiDI:YES];
    } else if (indexPath.row == 5) {
        cell.mainLabl.text = @"所属部门";
        [cell shanXinData:[NSString stringWithFormat:@"%@",KISDictionaryHaveKey(self.mainDataDict, @"depart_name")] withZhanShi:NO  xianShiDI:NO];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 91;
    }else
    {
        return 61;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self selectImageClick];
    }
    if (indexPath.row == 1) {
        ChangeNameViewController *vc = [[ChangeNameViewController alloc]init];
        vc.nameStr = @"名字";
        vc.nameKeHuStr = [UserInfo shareInstance].userReal_name;
        [self.navigationController  pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        ChangeMildelViewController *vc = [[ChangeMildelViewController alloc]init];
        vc.dianhauName = [UserInfo shareInstance].userMobile;
        [self.navigationController  pushViewController:vc animated:YES];
    }
}

#pragma mark - 上传图片
- (void)selectImageClick
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
        
        [weakSelf.mainTableView reloadData];
    } failure:^(id error) {
        
    }];
}


@end
