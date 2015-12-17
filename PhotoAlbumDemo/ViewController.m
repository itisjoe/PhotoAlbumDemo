//
//  ViewController.m
//  PhotoAlbumDemo
//
//  Created by joe feng on 2015/12/17.
//  Copyright © 2015年 joe feng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UIImageView *imgView;
}

-(void) openPhotoAlbum:(UIButton *) sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // photoalbum btn
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, [UIScreen mainScreen].bounds.size.width - 20, 50)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"從相簿選取" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(openPhotoAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    // image
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 300, [UIScreen mainScreen].bounds.size.width - 20, 200)];
    imgView.hidden = NO;
    [self.view addSubview:imgView];
    
}

// 按下[從相簿選取]按鈕
-(void) openPhotoAlbum:(UIButton *) sender {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if ( status == PHAuthorizationStatusNotDetermined || status == PHAuthorizationStatusAuthorized ) {
        // 尚未詢問使用者權限 or 已取得使用者權限

        //建立一個ImagePickerController
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // 設定影像來源 這裡設定為相簿
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        // 設置 delegate
        imagePicker.delegate = self;
        
        // 設定選完照片後可以編輯
        imagePicker.allowsEditing = YES;
        
        // 顯示相簿
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else if ( status == PHAuthorizationStatusRestricted ) {
        // restricted, 通常不會發生
        NSLog(@"restricted");
    } else if ( status == PHAuthorizationStatusDenied ) {
        // 使用者拒絕提供權限
        NSLog(@"denied");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // 取得編輯後的圖片 UIImage
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    if (img == nil) {
        // 如果沒有編輯 則是取得原始相簿的照片 UIImage
        img = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    // 再來就是對圖片的處理 img 是一個 UIImage
    imgView.image = img;
    
    //移除Picker
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
