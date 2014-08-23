//
//  ViewController.m
//  Kasaneru
//
//  Created by yoshimura on 2014/08/23.
//  Copyright (c) 2014年 yoshimura. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *prePhotoView;

- (IBAction)btnStart:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnStart:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];

    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self.prePhotoView setHidden:NO];
    
    
    UIImage *image= [self prePhotoView].image;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    // UIImageView *imageView = [[UIImageView alloc] initWithFrame:[self prePhotoView].frame];
    imageView.image = image;
    imageView.alpha = 0.5;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.userInteractionEnabled=NO;
    
    [picker setCameraOverlayView: imageView] ;
    
    
    // [picker setCameraOverlayView:[self prePhotoView]];
    
    [picker setDelegate:self];
    
    
    [self presentViewController:picker animated:YES completion:nil];

}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate
//- (void)imagePickerController:(UIImagePickerController *)picker
//didFinishPickingImage:(UIImage *)image
//				  editingInfo:(NSDictionary *)editingInfo {

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //  CGSize size = image.size;
    
    //    CGFloat w = image.size.width;
    
    UIImage *image = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage] ;
    
    
    
    [[self prePhotoView] setImage:image];
    
    
    /*
     CGFloat r = photoView.frame.size.width / image.size.width ;
     CGFloat r2 = photoView.frame.size.height / image.size.height ;
     
     if (r2 > r) {
     r = r2;
     }
     
     //    NSLog(@"w %f %f", image.size.width * r, image.size.height * r);
     
     photoView.contentMode = UIViewContentModeTopLeft;
     photoView.image = [[image imageByScalingProportionallyToSize: CGSizeMake(image.size.width * r, image.size.height * r)]
     stretchableImageWithLeftCapWidth:photoView.frame.size.width topCapHeight:photoView.frame.size.height];
     
     //    photoView.image = image;
     
     NSArray *arr = [NSArray arrayWithArray:[self.controlView subviews]];
     for (int i=0;i < [arr count];i++) {
     UIView *v = (UIView *) [arr objectAtIndex:i];
     if ([v isKindOfClass:[StampView class]]) {
     [v removeFromSuperview];
     [v release];
     }
     }
     */
	[picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissModalViewControllerAnimated:YES];
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
	NSString *message = @"保存しました！";
	if(error) message = @"エラーが起こりました！";
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存"
                                                     message:message
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
	[alert show];
}

@end
