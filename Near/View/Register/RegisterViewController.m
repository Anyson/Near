//
//  RegisterViewController.m
//  Near
//
//  Created by ADC on 14-11-27.
//  Copyright (c) 2014年 ANY. All rights reserved.
//

#import "RegisterViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface RegisterViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *gender;
@property (nonatomic, strong) UISegmentedControl *genderSegmented;
@property (nonatomic, strong) UITextField *nickNameField;
@property (nonatomic, strong) UIButton *searchBn;



@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     //self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB_WHITE;
    self.title = @"注册";
    
    [self.view addSubview:self.portraitImageView];
    [self.view addSubview:self.nickName];
    [self.view addSubview:self.gender];
    [self.view addSubview:self.nickNameField];
    [self.view addSubview:self.genderSegmented];
    [self.view addSubview:self.searchBn];
}

#pragma mark UIView getter
- (UILabel *)nickName{
    
    _nickName = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 -100, self.view.frame.size.height/2, 60, 44)];
    _nickName.backgroundColor =[UIColor whiteColor];
    _nickName.text =@"昵称";
    _nickName.textAlignment = NSTextAlignmentCenter;
    _nickName.layer.masksToBounds =YES;
    _nickName.layer.cornerRadius =8;
//    _nickName.layer.borderColor =[UIColor grayColor].CGColor;
//    _nickName.layer.borderWidth = 2.0f;
   
    
    return _nickName;
}

- (UILabel *)gender{
    _gender =[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 -100, self.view.frame.size.height/2 +54, 60, 44)];
    
    _gender.backgroundColor =[UIColor whiteColor];
    _gender.text =@"性别";
    _gender.textAlignment = NSTextAlignmentCenter;
    _gender.layer.masksToBounds =YES;
    _gender.layer.cornerRadius =8;

    return _gender;
}

- (UITextField *)nickNameField{
    
    _nickNameField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 , self.view.frame.size.height/2 , 120, 44)];
    
    _nickNameField.backgroundColor =[UIColor whiteColor];
    _nickNameField.placeholder =@"有效字符字母";
    _nickNameField.textAlignment = NSTextAlignmentLeft;
    _nickNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nickNameField.layer.masksToBounds =YES;
    _nickNameField.layer.cornerRadius =8;
    _nickNameField.layer.borderColor =[UIColor blueColor].CGColor;
    _nickNameField.layer.borderWidth =0.3f;


    return _nickNameField;
}

- (UISegmentedControl *)genderSegmented{

    _genderSegmented =[[UISegmentedControl alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 , self.view.frame.size.height/2 +54 ,120, 44)];
    
    _genderSegmented.backgroundColor =[UIColor whiteColor];
   
    [_genderSegmented insertSegmentWithTitle:@"男" atIndex:0 animated:YES];
    [_genderSegmented insertSegmentWithTitle:@"女" atIndex:1 animated:YES];
    [_genderSegmented setSelectedSegmentIndex:0]; //首先显示index=0的内容
   // _genderSegmented.momentary = YES;    //设置在点击后是否恢复原样
    _genderSegmented.multipleTouchEnabled=NO;     //可触摸
   
    
    return _genderSegmented;
}

-(UIButton *)searchBn{
_searchBn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 -30 , self.view.frame.size.height/2 +150 ,60, 44)];
    
    _searchBn.backgroundColor =[UIColor grayColor];
    _searchBn.layer.masksToBounds = YES;
    _searchBn.layer.cornerRadius =8;
   
   
    [_searchBn setClipsToBounds:YES];
    [_searchBn setTitle:@"搜索" forState:UIControlStateNormal];
  
    _searchBn.layer.shadowRadius = 2.0;
    _searchBn.layer.borderWidth = 0.5f;
    _searchBn.userInteractionEnabled = YES;
   
    return _searchBn;
}
#pragma mark portraitImageView getter
- (UIImageView *)portraitImageView {
    if (!_portraitImageView) {
        CGFloat w = 150.0f; CGFloat h = w;
        CGFloat x = (self.view.frame.size.width - w) / 2;
        CGFloat y = (self.view.frame.size.height - h) / 4;
        
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        
        [_portraitImageView.layer setCornerRadius:(_portraitImageView.frame.size.height/2)];
        [_portraitImageView.layer setMasksToBounds:YES];
        [_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_portraitImageView setClipsToBounds:YES];
        
        _portraitImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        _portraitImageView.layer.shadowOffset = CGSizeMake(4, 4);
        _portraitImageView.layer.shadowOpacity = 0.5;
        _portraitImageView.layer.shadowRadius = 1.0;
        _portraitImageView.layer.borderColor = [[UIColor blackColor] CGColor];
        _portraitImageView.layer.borderWidth = 2.0f;
        _portraitImageView.userInteractionEnabled = YES;
        _portraitImageView.backgroundColor = [UIColor grayColor];
        
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        [_portraitImageView addGestureRecognizer:portraitTap];
    }
    return _portraitImageView;
}

- (void)editPortrait {
    
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
    
    }

#pragma mark - image picker controller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image =  [info objectForKey:UIImagePickerControllerOriginalImage];
    [_portraitImageView setImage:image];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
   //拍照
  if (buttonIndex == 0)
  {
    if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos])
    {
        UIImagePickerController *imagePickerController =[[UIImagePickerController alloc]init];
        imagePickerController.sourceType  =UIImagePickerControllerSourceTypeCamera;//设置类型
        
        if ([self isFrontCameraAvailable])
        {
            imagePickerController.cameraDevice =UIImagePickerControllerCameraDeviceFront;
        }
        // 设置所支持的类型，设置只能拍照
        NSString *requiredMediaType =(NSString *)kUTTypeImage;
        NSArray *mediaType =[NSArray arrayWithObject:requiredMediaType];
        
        imagePickerController.mediaTypes =mediaType;
        
        imagePickerController.delegate = self;
        
        [imagePickerController setAllowsEditing:YES];//设置是否可以管理已经存在的图片或者视频
        
        [self.navigationController presentViewController:imagePickerController animated:YES completion:^{
             NSLog(@"Picker View Controller is presented");
        }];
    }
  }
//从相册
  else if(buttonIndex ==1)
  {if ([self isPhotoLibraryAvailable])
      {
          UIImagePickerController *controller =[[UIImagePickerController alloc]init];
          controller.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
          controller.allowsEditing = YES;
          controller.navigationBar.tintColor = RGB_PRIMARY;
          NSMutableArray *mediaType =[[NSMutableArray alloc]init];
          [mediaType addObject:(__bridge NSString *)kUTTypeImage];
          controller.mediaTypes =mediaType;
          controller.delegate = self;
          [self.navigationController presentViewController:controller animated:YES completion:^{
              NSLog(@"Picker View Controller is presented");          }];
          
      }
      
  }
 
}


#pragma mark camera utility

// 判断设备是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
// 前面的摄像头是否可用
- (BOOL) isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
// 后面的摄像头是否可用
- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
// 检查摄像头是否支持拍照
- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

// 相册是否可用
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];


}


 // 是否可以在相册中选择视频
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
// 是否可以在相册中选择照片
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
// 判断是否支持某种多媒体类型：拍照，视频
- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
