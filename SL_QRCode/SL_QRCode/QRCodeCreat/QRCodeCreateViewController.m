//
//  QRCodeCreateViewController.m
//  SL_QRCode
//
//  Created by 王胜龙 on 2017/8/24.
//  Copyright © 2017年 王胜龙. All rights reserved.
//

#import "QRCodeCreateViewController.h"
#import <CoreImage/CoreImage.h>

@interface QRCodeCreateViewController ()

@property (nonatomic, strong) UITextField *contentField;
@property (nonatomic, strong) UIButton *creatBT;
@property (nonatomic, strong) UIImageView *codeView;

@end

@implementation QRCodeCreateViewController

- (UITextField *)contentField {
    if (!_contentField) {
        _contentField = [[UITextField alloc] init];
        _contentField.placeholder = @"输入内容";
        _contentField.font = [UIFont systemFontOfSize:16];
        _contentField.textColor = [UIColor blackColor];
        _contentField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _contentField;
}

- (UIButton *)creatBT {
    if (!_creatBT) {
        _creatBT = [[UIButton alloc] init];
        [_creatBT setTitle:@"生成二维码" forState:UIControlStateNormal];
        [_creatBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _creatBT.backgroundColor = [UIColor lightGrayColor];
        
        _creatBT.layer.cornerRadius = 4;
        
        [_creatBT addTarget:self action:@selector(creatAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _creatBT;
}

- (UIImageView *)codeView {
    if (!_codeView) {
        _codeView = [[UIImageView alloc] init];
        _codeView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _codeView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"生成二维码";
    
    CGFloat screew = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    self.contentField.frame = CGRectMake(20, 50, screew - 40, 40);
    self.creatBT.frame = CGRectMake(20, CGRectGetMaxY(self.contentField.frame)+ 10, screew-40, 40);
    self.codeView.frame = CGRectMake(0, CGRectGetMaxY(self.creatBT.frame) + 20, screew, 200);
    
    [self.view addSubview:self.contentField];
    [self.view addSubview:self.creatBT];
    [self.view addSubview:self.codeView];
}

- (void)creatAction: (UIButton *)button {
    
    [self.contentField resignFirstResponder];
    NSString *content = _contentField.text;
    if (content.length > 0) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
            [filter setDefaults];

            NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
            [filter setValue:data forKey:@"inputMessage"];
            
            CIImage *image = [filter outputImage];
            UIImage *code = [self createNonInterpolatedUIImageFormCIImage:image withSize:500];
            dispatch_async(dispatch_get_main_queue(), ^{
               
                self.codeView.image = code;
            });
        });
        
        return;
    }
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入二维码内容" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
    
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
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
