//
//  StampImageView.m
//  Blue4
//
//  Created by セラフ on 10/08/05.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StampImageView.h"


@implementation StampImageView

- (id)initWithImage:(UIImage *)image {
	
	NSLog(@"initWithImage");
	
	if ((self = [super initWithImage:image])) {
		self.userInteractionEnabled	 = YES;
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
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	  [self.nextResponder touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	  [self.nextResponder touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.nextResponder touchesEnded:touches withEvent:event];
}


@end
