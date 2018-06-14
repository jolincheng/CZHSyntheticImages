//
//  CZHImagePickerBaseController.m
//  CZHSyntheticImages
//
//  Created by 程召华 on 2018/6/13.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "CZHImagePickerBaseController.h"
#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TZGifPhotoPreviewController.h"
#import "TZLocationManager.h"

#define MAX_COLUMN_NUMBER 4  ///PICKER每行展示的数量
#define MAX_IMAGES_COUNT 1  ///每次选择最大数量

@interface CZHImagePickerBaseController ()<TZImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) CLLocation *location;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
///选择的图片
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
///选择的asset
@property (nonatomic, strong) NSMutableArray *selectedAssets;
///<#注释#>
@property (nonatomic, copy) void (^successHandler)(UIImage *image);

@end

@implementation CZHImagePickerBaseController


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"





- (NSMutableArray *)selectedPhotos {
    if (!_selectedPhotos) {
        _selectedPhotos = [NSMutableArray array];
    }
    return _selectedPhotos;
}

- (NSMutableArray *)selectedAssets {
    if (!_selectedAssets) {
        _selectedAssets = [NSMutableArray array];
    }
    return _selectedAssets;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)showImagePickerControllerWithSuccessHandler:(void (^)(UIImage *))successHandler {
    
    self.successHandler = successHandler;
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:MAX_COLUMN_NUMBER delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.isSelectOriginalPhoto = YES;
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    imagePickerVc.allowCrop = NO;
    imagePickerVc.needCircleCrop = NO;
   
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // CZHLog(@"cancel");
}



/**
 *  普通图片
 */
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    
    if (self.successHandler) {
        self.successHandler(photos.firstObject);
    }
}


@end
