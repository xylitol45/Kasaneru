//
//  SelectStampViewController.h
//  Blue4
//
//  Created by セラフ on 10/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageScrollView.h"

@interface SelectStampViewController : UIViewController <PageScrollViewDelegate> {
	IBOutlet UIButton *btnCancel;
	
	NSMutableArray *arrStamps;
	
	id myDelegate;

	NSMutableArray *pages;
	PageScrollView *scrollView;
}

@property (nonatomic,assign) id myDelegate;

@property (nonatomic,retain) NSMutableArray *arrStamps;
@property (nonatomic,retain) UIButton *btnCancel;

- (IBAction) btnStampPress:(id)sender;
- (IBAction) btnCancelPress:(id)sender;

- (void)pageScrollViewDidChangeCurrentPage:(PageScrollView *)pageScrollView currentPage:(int)currentPage;

@end

@protocol StampPickerDelegate <NSObject>

@optional

- (void)selectStamp:(SelectStampViewController *)selectStampViewController StampNo:(int)stampNo;

@end

