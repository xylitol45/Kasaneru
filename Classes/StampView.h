//
//  StampView.h
//  Blue4
//
//  Created by セラフ on 10/08/04.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StampImageView;

@interface StampView : UIView {
	StampImageView *imgView;
	CGFloat imgAngle;
	CGFloat imgScale;
}

@property (nonatomic,retain) StampImageView *imgView;
@property CGFloat imgAngle;
@property CGFloat imgScale;

- (void) addScaleAndAngle:(CGFloat)aScale angle:(CGFloat)aAngle;


@end
