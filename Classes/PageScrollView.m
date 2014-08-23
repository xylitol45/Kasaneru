//
//  PageScrollView.m
//  Silk
//
//  Created by セラフ on 10/06/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PageScrollView.h"

@implementation PageScrollView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		_pageRegion = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
//		_pageRegion = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height - 60.0);
//		_controlRegion = CGRectMake(frame.origin.x, frame.size.height - 60.0, frame.size.width, 60.0);
		self.delegate = nil;
		
		scrollView = [[UIScrollView alloc] initWithFrame:_pageRegion];
		scrollView.pagingEnabled = YES;
		scrollView.delegate = self;
		scrollView.showsHorizontalScrollIndicator = NO;
		scrollView.showsVerticalScrollIndicator = NO;		
		[self addSubview:scrollView];
		
//		pageControl = [[UIPageControl alloc] initWithFrame:_controlRegion];
//		[pageControl addTarget:self action:@selector(pageControlDidChange:) forControlEvents:UIControlEventValueChanged];
//		[self addSubview:pageControl];
		
	}

    return self;
}

- (void)setPages:(NSMutableArray *)pages {
	for (int i=0;i<[_pages count];i++) {
		[[_pages objectAtIndex:i] removeFromSuperview];
	}
	_pages = pages;
	scrollView.contentOffset = CGPointMake(0.0, 0.0);
	scrollView.contentSize = CGSizeMake(_pageRegion.size.width * [_pages count], _pageRegion.size.height);
//	scrollView.contentSize = CGSizeMake(_pageRegion.size.width * 1, _pageRegion.size.height);
//	pageControl.numberOfPages = [_pages count];
//	pageControl.currentPage = 0;
	
	[self layoutViews];
}

- (void)layoutViews {
	for (int i=0;i<[_pages count]; i++) {
		UIView *page = [_pages objectAtIndex:i];
		CGRect bounds = page.bounds;
		CGRect frame = CGRectMake(_pageRegion.size.width * i, 0.0, _pageRegion.size.width, _pageRegion.size.height);
		page.frame = frame;
//		page.frame = CGRectMake(0.0, 0.0, _pageRegion.size.width, _pageRegion.size.height);
		page.bounds = bounds;
		
//		UIScrollView *zoomView = [[UIScrollView alloc] initWithFrame:CGRectMake(_pageRegion.size.width * i, 0.0, _pageRegion.size.width, _pageRegion.size.height)]; 
//		[zoomView addSubview:page];
//		zoomView.minimumZoomScale = 1.0;
//		zoomView.maximumZoomScale = 3.0;
//		zoomView.delegate = self;
		
		[scrollView addSubview:page];
		//[scrollView addSubview:zoomView];
		//[_zoomPages addObject:zoomView];
	}
}

- (id)getDelegate {
	return _delegate;
}

- (void)setDelegate:(id)delgate {
	_delegate = delgate;
}

- (NSMutableArray *)getPages {
	return _pages;
}

- (void)setCurrentPage:(int)page {
	[scrollView setContentOffset:CGPointMake(_pageRegion.size.width * page, scrollView.contentOffset.y) animated:YES];
//	pageControl.currentPage = page;
}

- (int)getCurrentPage {
	return (int) (scrollView.contentOffset.x / _pageRegion.size.width);
}

- (void)scrollViewDidEndDecelerating:(id)sender {
//	pageControl.currentPage = self.currentPage;
	[self notifyPageChange];
}
/*
- (void)pageControlDidChange:(id)sender {
	UIPageControl *control = (UIPageControl *) sender;
	if (control == pageControl) {
		self.currentPage = control.currentPage;
	}
	[self notifyPageChange];
}
*/
- (void)notifyPageChange {
	
	NSLog(@"notifyPageChange count %d", self.currentPage);

	if (self.delegate != nil) {
		if ([_delegate conformsToProtocol:@protocol(PageScrollViewDelegate)]) {
			if ([_delegate respondsToSelector:@selector(pageScrollViewDidChangeCurrentPage:currentPage:)]) {
				[self.delegate pageScrollViewDidChangeCurrentPage:(PageScrollView *)self currentPage:self.currentPage];
			}
		}
	}
}

- (void)dealloc {
//	[_zoomPages release];
    [super dealloc];
}


@end
