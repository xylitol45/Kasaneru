//
//  ControlView.h
//  Blue4
//
//  Created by セラフ on 10/08/04.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StampView;

@interface ControlView : UIView {
	UIToolbar *myToolbar;
	StampView *stampView;
	
	CGFloat preAngle;
	CGFloat preDistance;
	CGPoint firstPoint;
	CGPoint secondPoint;
	CGPoint startPoint;
}

@property (nonatomic,retain) UIToolbar *myToolbar;
@property (nonatomic,retain) StampView *stampView;
@property CGFloat preAngle;
@property CGFloat preDistance;
@property CGPoint firstPoint;
@property CGPoint secondPoint;
@property CGPoint startPoint;

@end
