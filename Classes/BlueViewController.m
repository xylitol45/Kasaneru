//
//  BlueViewController.m
//  Blue
//
//  Created by セラフ on 10/05/20.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import <QuartzCore/CALayer.h>

#import "BlueViewController.h"
#import "ControlView.h"
#import "StampView.h"
#import "InfoViewController.h"
#import "uiimage_extras.h"

@implementation BlueViewController

@synthesize imgView;
@synthesize controlView;
@synthesize photoView;
@synthesize myToolbar;
@synthesize blackView;
@synthesize targetEraseView;
@synthesize selectStampViewController;
@synthesize eraseActionSheet;
@synthesize imageActionSheet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		selectStampViewController = [[SelectStampViewController alloc] initWithNibName:@"SelectStampViewController" bundle:nil];
		selectStampViewController.myDelegate = self;
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
	controlView.myToolbar = self.myToolbar;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[imgView release];
//	[saveView release];
	[controlView release];
	[myToolbar release];
	[photoView release];
	[selectStampViewController release];
	
    [super dealloc];
}

- (IBAction) btnImagePress:(id)sender {
	
	imageActionSheet = [[[UIActionSheet alloc] initWithTitle:@"どの写真を使いますか" 
													delegate:self 
										   cancelButtonTitle:@"キャンセル" 
									  destructiveButtonTitle:nil 
										   otherButtonTitles:@"保存してある写真",@"カメラ",nil] autorelease];
	[imageActionSheet showInView:self.view];
}

- (IBAction) btnStampPress:(id)sender {
		
	[self presentModalViewController:selectStampViewController animated:YES];

}

- (IBAction) btnSavePress:(id)sender {
	
	UIImage *_img = [self screenImage:self.controlView];
	UIImageWriteToSavedPhotosAlbum(_img, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (IBAction) btnErasePress:(id)sender {

	int n = [[controlView subviews] count];
	
	if (n <= 0) {
		return;
	}
	
	id wk = [[controlView subviews] objectAtIndex:n - 1];
	if ([wk isKindOfClass:[StampView class]]) {
		StampView *wk2 = wk;
		
		if (blackView == nil) {
			blackView = [[UIView alloc] initWithFrame:controlView.frame];
//			blackView.alpha = 0.9;
			blackView.backgroundColor = [UIColor blackColor];
		}
		
		[controlView insertSubview:blackView belowSubview:wk2];	
		self.targetEraseView = wk2;
//		[wk2 removeFromSuperview];
//		[wk2 release];

		eraseActionSheet = 
		[[[UIActionSheet alloc] initWithTitle:@"このスタンプを削除しますか" 
									 delegate:self 
							cancelButtonTitle:@"キャンセル" 
					   destructiveButtonTitle:@"削除する" 
							otherButtonTitles:nil] autorelease];
		[eraseActionSheet showInView:self.view];
	
	}	
}

- (void)btnInfoPress:(id)sender {
	InfoViewController *vc = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
	[self presentModalViewController:vc animated:YES];
	[vc release];
}

- (UIImage *) screenImage:(UIView *)aView {
	UIImage *screenImage;
	
	UIGraphicsBeginImageContext(aView.frame.size);
	[aView.layer renderInContext:UIGraphicsGetCurrentContext()];
	screenImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return screenImage;
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

    UIImage *image = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];

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
	
	[picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissModalViewControllerAnimated:YES];
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
	NSString *message = @"保存しました！";
	if(error) message = @"エラーが起こりました！";
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"保存" 
													message:message 
												   delegate:self 
										  cancelButtonTitle:@"OK" 
										  otherButtonTitles:nil] autorelease];
	[alert show];
}

#pragma mark -
#pragma mark UIActionSheetDelegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (actionSheet == self.eraseActionSheet) {
		if (buttonIndex != [actionSheet cancelButtonIndex]) {
			if (self.targetEraseView != nil) {
				[self.targetEraseView removeFromSuperview];
				[self.targetEraseView release];
			}
		}
		[self.blackView removeFromSuperview];
	} else 
	if (actionSheet == self.imageActionSheet){
		
		
		if (buttonIndex != [actionSheet cancelButtonIndex]) {
			UIImagePickerController *picker = [[[UIImagePickerController alloc] init] autorelease];
			NSLog(@"buttonIndex: %d", buttonIndex);
			if (buttonIndex == 0) {
				picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
			} else {
				picker.sourceType = UIImagePickerControllerSourceTypeCamera;
			}
			picker.delegate = self;
			[self presentModalViewController:picker animated:YES];
		}
	}

//	self.blackView.hidden = YES;
}

#pragma mark -
#pragma mark StampPickerDelegate methods
- (void)selectStamp:(SelectStampViewController *)selectStampViewController StampNo:(int)stampNo {

	UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"stamp%d.png", stampNo]];
	if (img == nil) {
		return;
	}
	
	StampView *_stampView = [[StampView alloc] initWithImage:img];
	
	CGRect f = _stampView.frame;
	
	_stampView.frame = CGRectMake((self.controlView.frame.size.width -  _stampView.frame.size.width) / 2, 40, f.size.width, f.size.height);
	
	[self.controlView addSubview:_stampView];
	
	controlView.stampView = _stampView;

	[img release];
}

@end

@implementation UIImage (Extras)

- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor) 
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5; 
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}

@end
