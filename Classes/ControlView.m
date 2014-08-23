//
//  ControlView.m
//  Blue4
//
//  Created by セラフ on 10/08/04.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ControlView.h"
#import "CGPointUtils.h"
#import "StampView.h"

@implementation ControlView

@synthesize myToolbar;
@synthesize stampView;
@synthesize preAngle;
@synthesize preDistance;
@synthesize firstPoint;
@synthesize secondPoint;
@synthesize startPoint;

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		myToolbar = nil;
		stampView = nil;
		preAngle = 0.0f;
		preDistance = 0.0f;
		firstPoint.x = firstPoint.y = 0.0f;
		secondPoint.x = secondPoint.y = 0.0f;
		startPoint.x = startPoint.y = 0.0f;
		
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


- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event  
{  
	if (myToolbar != nil) {
		CATransition *animation = [[CATransition alloc] init];
		animation.duration = .2;
		animation.timingFunction = 
		[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear ];
		animation.type = kCATransitionReveal;
		animation.subtype = kCATransitionFromBottom;
		[[myToolbar  layer] addAnimation:animation forKey:@"reveal animation"];
		myToolbar.hidden = YES;
	}

	if ([self.subviews count] < 0) {
		return;
	}
	
	self.stampView = nil;
	id wk = [self.subviews objectAtIndex:[self.subviews count] - 1];
	if ([wk isKindOfClass:[StampView class]]) {
		self.stampView = wk;
	}
	
	if (self.stampView == nil) {
		return;
	}
	
	if ([touches count] == 1) {
		startPoint = [[touches anyObject] locationInView:self];
	} else	
    if ([touches count] == 2) {
        NSArray *twoTouches = [touches allObjects]; // 全タッチ情報を取得
        UITouch *first = [twoTouches objectAtIndex:0];
        UITouch *second = [twoTouches objectAtIndex:1];		
		
		preAngle = angleBetweenPoints([first locationInView:[self superview]], [second locationInView:[self superview]]);
		preDistance = distanceBetweenPoints([first locationInView:[self superview]], [second locationInView:[self superview]]);
	}
	
}  

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event  
{

//	NSLog(@"ControlView touches Moved touch count:%d", [touches count]);
	
	if ([touches count] == 1) {
		UITouch* touch = [touches anyObject];

		if (startPoint.x == 0 || startPoint.y == 0) {
			startPoint = [touch locationInView:self];
		} else {
			
			CGPoint pt = [touch locationInView:self];
			CGRect r = stampView.frame;
			
			if ((pt.x - startPoint.x) > 2) {
				r.origin.x += 4;
				startPoint.x = pt.x;
			} else 
			if ((startPoint.x - pt.x) > 2) {
				r.origin.x -= 4;
				startPoint.x = pt.x;
			}
			
			if ((pt.y - startPoint.y) > 2) {
				r.origin.y += 4;
				startPoint.y = pt.y;
			} else 
			if ((startPoint.y - pt.y) > 2) {
				r.origin.y -= 4;
				startPoint.y = pt.y;
			}
			
			[stampView setFrame:r];
		}
		
		return;
	}
	
	if ([touches count] == 2) {
        NSArray *twoTouches = [touches allObjects]; // 全タッチ情報を取得
        UITouch *first = [twoTouches objectAtIndex:0];
        UITouch *second = [twoTouches objectAtIndex:1];

		CGFloat diffAngle;
		CGFloat diffDistance;
		
		diffAngle = 0.0f;
		diffDistance = 0.0f;
		
		
		if (preAngle == 0) {
			firstPoint = [first locationInView:self];
			secondPoint = [second locationInView:self];
			preAngle = angleBetweenPoints(firstPoint, secondPoint);
		} else {
			CGFloat nowAngle = angleBetweenPoints([first locationInView:self], [second locationInView:self]);			
			if ((preAngle - nowAngle) > 2) {
				diffAngle = 2.0f;
				preAngle = nowAngle;
			} else 
			if ((nowAngle - preAngle) > 2) {
				diffAngle = -2.0f;
				preAngle = nowAngle;
			}
		}
		
		if (preDistance == 0) {
			preDistance = distanceBetweenPoints([first locationInView:self], [second locationInView:self]);
		} else {
			
			CGFloat nowDistance = distanceBetweenPoints([first locationInView:self], [second locationInView:self]);
			if ((preDistance - nowDistance) > 8) {
				diffDistance = -0.1f; 
				preDistance = nowDistance;
			} else
			if ((nowDistance - preDistance) > 8) {
				diffDistance = 0.1f; 
				preDistance = nowDistance;
			}	
		}
		
		if (stampView != nil) {
			[stampView addScaleAndAngle:diffDistance angle:diffAngle];
		} else {
			NSLog(@"stampView is nil");
		}
		
		return;
	}
}  

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{	
	if (myToolbar != nil) {
		CATransition *animation = [[CATransition alloc] init];
		animation.duration = .2;
		animation.timingFunction = 
		[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear ];
		animation.type = kCATransitionMoveIn;
		animation.subtype = kCATransitionFromTop;
		[[myToolbar layer] addAnimation:animation forKey:@"movein animation"];
	
		myToolbar.hidden = NO;
	}
	
	self.stampView = nil;
	
	preAngle = preDistance = 0.0f;
}



@end
