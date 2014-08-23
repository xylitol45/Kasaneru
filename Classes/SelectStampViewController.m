//
//  SelectStampViewController.m
//  Blue4
//
//  Created by セラフ on 10/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SelectStampViewController.h"
#import "uiimage_extras.h"

@implementation SelectStampViewController

@synthesize arrStamps;
@synthesize btnCancel;
@synthesize myDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
//		arrStamps = [[NSMutableArray alloc] initWithCapacity:0];
	}
    return self;
}

- (void)loadView {
    [super loadView];
	
	pages = [[NSMutableArray alloc] init];
	
	// no.1 - 12
	for (int no = 1;no <= 120;no += 12) 
	{
		UIView *_wk_view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 360)];
		UIImage *img;
		for (int i=0;i<4;i++) {
			for (int j=0;j<3;j++) {
				int n = i * 3 + j + no;
				img = [UIImage imageNamed:[NSString stringWithFormat:@"stamp%d.png", n]];
				if (img == nil) {
					continue;
				}
				UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
				btn.tag =  n;
				btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
				btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
				[btn setFrame:CGRectMake(j * 80 + 45, i * 80, 72, 72)];
				[btn addTarget:self action:@selector(btnStampPress:) forControlEvents:UIControlEventTouchUpInside];
				[btn setImage:img forState:UIControlStateNormal];
				[_wk_view addSubview:btn];
			}
		}
		[pages addObject:_wk_view];
	
		if (img == nil) {
			break;
		}
	}

	scrollView = [[PageScrollView alloc] initWithFrame:CGRectMake(0.0, 30.0, self.view.frame.size.width, 360)];
	scrollView.pages = pages;
	scrollView.delegate = self;
	[self.view addSubview:scrollView];

}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[btnCancel release];
//	[arrStamps release];
	[scrollView release];
    [super dealloc];
}

- (IBAction) btnStampPress:(id)sender {
	
	int stampNo = 0;
	
	UIButton *btn = (UIButton *) sender;
	stampNo = btn.tag;
	
	if (stampNo == 0) {
		return;
	}

	if (self.myDelegate != nil){
		if ([self.myDelegate conformsToProtocol:@protocol(StampPickerDelegate)]){
			if ([self.myDelegate respondsToSelector:@selector(selectStamp:StampNo:)]) {
				[self.myDelegate selectStamp:(SelectStampViewController *) self StampNo:stampNo];
			}
		}
	}
	[self dismissModalViewControllerAnimated:YES];

}

- (IBAction) btnCancelPress:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}


- (void)pageScrollViewDidChangeCurrentPage:(PageScrollView *)pageScrollView currentPage:(int)currentPage {
}

@end
