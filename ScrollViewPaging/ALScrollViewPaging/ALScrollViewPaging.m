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
    if (hasPageControl) {
        [pageControl setNumberOfPages:[_pages count]];
        [pageControl setCurrentPage:0];
        int pWidth = kDotWidth * [_pages count];
        CGFloat scrollViewCenterPointX = self.frame.size.width / 2;
        int pageControlX = scrollViewCenterPointX - (pWidth / 2);
        int pageControlY = self.frame.origin.y + self.frame.size.height + 5;
        [pageControl setFrame:CGRectMake(pageControlX, pageControlY, pWidth, 36)];
        [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        [pageControl setPageIndicatorTintColor:[UIColor yellowColor]];
        [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
        [[self superview] addSubview:pageControl];
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
	frame.origin.x = self.frame.size.width * self.currentPage;
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
