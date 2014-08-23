//
//  BlueAppDelegate.h
//  Blue
//
//  Created by セラフ on 10/05/20.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlueViewController;
@class OpeningViewController;

@interface BlueAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    BlueViewController *blueViewController;
	OpeningViewController *openingViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BlueViewController *blueViewController;
@property (nonatomic, retain) IBOutlet OpeningViewController *openingViewController;

- (void)displayBlueViewController;
- (NSString *)uniqueFileNameWithExtention:(NSString*)ext;

@end

