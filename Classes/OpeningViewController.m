//
//  OpeningViewController.m
//  Blue4
//
//  Created by セラフ on 11/02/26./Users/seraph2009/Documents/Kasanedori/Kasanedori/Classes/OpeningViewController.h
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OpeningViewController.h"
#import "BlueAppDelegate.h"

@implementation OpeningViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {


        [[self prePhotoView] setHidden:YES];
    
    }
    return self;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {

    [self setPrePhotoView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    
    [_prePhotoView release];
    [super dealloc];
}

- (IBAction) btnStart:(id)sender {
    
    
        UIImagePickerController *picker = [[[UIImagePickerController alloc] init] autorelease];

    
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    
    [self.prePhotoView setHidden:NO];
        [picker setCameraOverlayView:[self prePhotoView]];
    
    
        picker.delegate = self  ;
        [self presentModalViewController:picker animated:YES];

    
    
	//BlueAppDelegate *_delegate = [[UIApplication sharedApplication] delegate];
	//[_delegate displayBlueViewController];
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
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"保存"
                                                     message:message
                                                    delegate:self
                                           cancelButtonTitle:@"OK" 
                                           otherButtonTitles:nil] autorelease];
	[alert show];
}


@end
