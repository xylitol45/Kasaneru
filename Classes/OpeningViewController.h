//
//  OpeningViewController.h
//  Blue4
//
//  Created by セラフ on 11/02/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OpeningViewController : UIViewController <UIImagePickerControllerDelegate> {
    
    
}


@property (retain, nonatomic) IBOutlet UIImageView *prePhotoView;

- (IBAction) btnStart:(id)sender ;


@end
