//
//  PageScrollView.h
//  Silk
//
//  Created by セラフ on 10/06/15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PageScrollView : UIView <UIScrollViewDelegate> {
	UIScrollView *scrollView;
//	UIPageControl *pageControl;
	
	CGRect _pageRegion, _controlRegion;
	NSMutableArray *_pages;
	id _delegate;
	
}

- (void)layoutViews;
- (void)notifyPageChange;

@property (nonatomic,assign,getter=getPages) NSMutableArray *pages;
@property (nonatomic,assign,getter=getCurrentPage) int currentPage;
@property (nonatomic,assign,getter=getDelegate) id delegate;

@end

@protocol PageScrollViewDelegate <NSObject>

@optional

- (void)pageScrollViewDidChangeCurrentPage:(PageScrollView *)pageScrollView
							   currentPage:(int)currentPage;


@end

