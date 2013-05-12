//
//  ALScrollViewPaging.m
//  ScrollViewPaging
//
//  Created by Andrea Lufino on 15/02/13.
//  Copyright (c) 2013 Andrea Lufino. All rights reserved.
//

#import "ALScrollViewPaging.h"

@implementation ALScrollViewPaging

const int kDotWidth = 7;

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //setting the 'must have' properties
        [self setBackgroundColor:[UIColor clearColor]];
        self.pagingEnabled = YES;
        self.delegate = self;
        pageControlBeingUsed = NO;
        self.bounces = NO;
        pageControl = [[UIPageControl alloc] init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pages
{
    self = [super initWithFrame:frame];
    if (self) {
        //add pages to scrollview
        [self addPages:pages];
    }
    return self;
}

#pragma mark - Setter

//setter for hasPageControl property
//if is YES, we can create the page control and place it under the scrollview
- (void)setHasPageControl:(BOOL)hasPageControl {
    _hasPageControl = hasPageControl;
    //if hasPageControl is true
    if (hasPageControl) {
        //set number of page based on number of pages to show and set current page to the first object
        [pageControl setNumberOfPages:[_pages count]];
        [pageControl setCurrentPage:0];
        //calculate the page control width considering that a dot is 20px, so we can multiply by the number of page to have the width of the page control
        int pWidth = kDotWidth * [_pages count];
        //calculate the scroll view center
        CGFloat scrollViewCenterPointX = self.frame.size.width / 2;
        //calculate the X and Y coordinates of the page control
        int pageControlX = scrollViewCenterPointX - (pWidth / 2);
        int pageControlY = self.frame.origin.y + self.frame.size.height + 5;
        //set the frame of the page control
        [pageControl setFrame:CGRectMake(pageControlX, pageControlY, pWidth, 36)];
        //set target and selector for page control
        [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        //set colors for indicators
        [pageControl setPageIndicatorTintColor:[UIColor yellowColor]];
        [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
        //add page control to superview
        [[self superview] addSubview:pageControl];
    } else {
        //remove the page control from superview
        for (UIPageControl *pControl in [[self superview] subviews]) {
            if ([pControl isEqual:pageControl]) {
                [pageControl removeFromSuperview];
            }
        }
    }
}

//set the color of the current page dot
- (void)setPageControlCurrentPageColor:(UIColor *)pageControlCurrentPageColor {
    _pageControlCurrentPageColor = pageControlCurrentPageColor;
    pageControl.currentPageIndicatorTintColor = pageControlCurrentPageColor;
}

//set the color of the others pages indicators
- (void)setPageControlOtherPagesColor:(UIColor *)pageControlOtherPagesColor {
    _pageControlOtherPagesColor = pageControlOtherPagesColor;
    pageControl.pageIndicatorTintColor = pageControlOtherPagesColor;
}

#pragma mark - Add pages

//add pages to the scrollview
- (void)addPages:(NSArray *)pages {
    _pages = pages;
    int numberOfPages = [pages count];
    for (int i = 0; i < [pages count]; i++) {
        CGRect frame;
        frame.origin.x = self.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.frame.size;
        UIView *view = [pages objectAtIndex:i];
        [view setFrame:frame];
        [self addSubview:view];
    }
    self.contentSize = CGSizeMake(self.frame.size.width * numberOfPages, self.frame.size.height);
}

#pragma mark - Change page through page control

//method for paging
- (void)changePage:(id)sender {
    //update the scroll view to the appropriate page
	CGRect frame;
	frame.origin.x = self.frame.size.width * pageControl.currentPage;
	frame.origin.y = 0;
	frame.size = self.frame.size;
	[self scrollRectToVisible:frame animated:YES];
	pageControlBeingUsed = YES;
}

#pragma mark - ScrollView delegate

//methods for paging
- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (!pageControlBeingUsed) {
		//switch the page when more than 50% of the previous/next page is visible
		CGFloat pageWidth = self.frame.size.width;
		NSInteger page = floor((self.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		self.currentPage = page;
        pageControl.currentPage = self.currentPage;
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

@end
