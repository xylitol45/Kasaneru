//
//  BlueViewController.h
//  Blue
//
//  Created by セラフ on 10/05/20.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectStampViewController.h"

@class ControlView;

@interface BlueViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, StampPickerDelegate> {
	IBOutlet UIImageView *imgView;
	IBOutlet UIImageView *photoView;
	
	UIImage *imgCamera;
	IBOutlet ControlView *controlView;
	IBOutlet UIToolbar *myToolbar;
	IBOutlet UIView *blackView;
	IBOutlet UIView *targetEraseView;
	
	UIActionSheet *eraseActionSheet;
	UIActionSheet *imageActionSheet;
	
	SelectStampViewController *selectStampViewController;
}

@property (nonatomic,retain) UIImageView *imgView;
@property (nonatomic,retain) UIImageView *photoView;
@property (nonatomic,retain) ControlView *controlView;
@property (nonatomic,retain) UIToolbar *myToolbar;
@property (nonatomic,retain) UIView *blackView;
@property (nonatomic,retain) UIView *targetEraseView;
@property (nonatomic,retain) UIActionSheet *eraseActionSheet;
@property (nonatomic,retain) UIActionSheet *imageActionSheet;

@property (nonatomic,retain) SelectStampViewController *selectStampViewController;

- (UIImage *) screenImage:(UIView *)aView ;

- (IBAction) btnImagePress:(id)sender;
- (IBAction) btnStampPress:(id)sender;
- (IBAction) btnSavePress:(id)sender;
- (IBAction) btnErasePress:(id)sender;
- (IBAction) btnInfoPress:(id)sender;

@end




