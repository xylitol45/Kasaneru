//
//  BlueAppDelegate.m
//  Blue
//
//  Created by セラフ on 10/05/20.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "BlueAppDelegate.h"
#import "BlueViewController.h"
#import "OpeningViewController.h"

@implementation BlueAppDelegate

@synthesize window;
@synthesize openingViewController;
@synthesize blueViewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {

	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//	viewController = [[BlueViewController alloc] initWithNibName:@"BlueViewController" bundle:nil];
	openingViewController = [[OpeningViewController alloc] initWithNibName:@"OpeningViewController" bundle:nil];
	
//	viewController.view.frame = [[UIScreen mainScreen] applicationFrame];
//	[window addSubview:viewController.view];
	openingViewController.view.frame = [[UIScreen mainScreen] applicationFrame];
	[window addSubview:openingViewController.view];
	[window makeKeyAndVisible];
	
	return;
}


- (void)dealloc {
    [blueViewController release];
	[openingViewController release];
    [window release];
    [super dealloc];
}

- (void)displayBlueViewController {
	
	blueViewController = [[BlueViewController alloc] initWithNibName:@"BlueViewController" bundle:nil];
	blueViewController.view.frame = [[UIScreen mainScreen] applicationFrame];
	
	[UIView beginAnimations:@"displayTabBarController" context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView	setAnimationTransition:UIViewAnimationTransitionCurlUp forView:window cache:YES];
	

	[window addSubview:blueViewController.view];
	[openingViewController.view removeFromSuperview];
	
	[UIView commitAnimations];
	
}


- (NSString *)uniqueFileNameWithExtention:(NSString*)ext {
	CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
	CFStringRef uuidStr = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
	CFRelease(uuidRef);
	
	NSString *fileName = [NSString stringWithFormat:@"%@.%@", uuidStr, ext];
	
	return fileName;
}

@end
