//
//  StampView.m
//  Blue4
//
//  Created by セラフ on 10/08/04.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StampView.h"
#import "CGPointUtils.h"
#import "StampImageView.h"

@implementation StampView

@synthesize imgView;
@synthesize imgAngle;
@synthesize imgScale;


- (id)initWithImage:(UIImage *)aImage {
	if ((self = [super init])) {
		
		imgAngle = 0.0f;
		imgScale = 1.0f;
		
		imgView = [[StampImageView alloc] initWithImage:aImage];
		
		CGRect r = imgView.frame;
		r.origin.x = 0;
		r.origin.y = 0;
		imgView.frame = r;
		
		self.frame = r;
		
		[self addSubview:imgView];
		
		self.userInteractionEnabled = YES;
		self.multipleTouchEnabled = YES;
		
	}
	return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
	
	[imgView release];
    [super dealloc];
}

- (void) addScaleAndAngle:(CGFloat)aScale angle:(CGFloat)aAngle {
	if (imgView == nil) {
		return;
	}
	
	if ((imgScale + aScale ) > 0) {
		imgScale += aScale;
	}
	imgAngle += aAngle;
	
	CGAffineTransform trans = CGAffineTransformConcat(
													  CGAffineTransformMakeRotation(degreesToRadian(imgAngle)), 
													  CGAffineTransformMakeScale(imgScale, imgScale));
													 
	if (!CGAffineTransformEqualToTransform(trans, imgView.transform)) {
		imgView.transform = trans;
	}
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"2touchesBegan");
	[[self superview] bringSubviewToFront:self];
	[self.nextResponder touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"2touchesMoved");
	[self.nextResponder touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"2touchesEnd");
	[self.nextResponder touchesEnded:touches withEvent:event];
}


@end
