ALScrollViewPaging
==================

This UIScrollView subclass provides a method to add paging and a demo project.

Usage
==================

Drag the ALScrollViewPaging folder to your project.

All the views which have to be added to the scrollview MUST have the same width and height of the scrollview.

    //create the scrollview with specific frame
    ALScrollViewPaging *scrollView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 300)];
    //array for views to add to the scrollview
    NSMutableArray *views = [[NSMutableArray alloc] init];
    //array for colors of views
    NSArray *colors = [[NSArray alloc] initWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor yellowColor],[UIColor greenColor],[UIColor whiteColor], nil];
    //cycle which creates views for the scrollview
    for (int i = 0; i < 5; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        [view setBackgroundColor:[colors objectAtIndex:i]];
        [views addObject:view];
    }
    
    //add pages to scrollview
    [scrollView addPages:views];

You can have also an UIPageControl placed under the scrollview, simply setting to YES the ```hasPageControl``` property after the scrollview is been added to the superview.

    //add scrollview to the view
    [self.view addSubview:scrollView];
    
    [scrollView setHasPageControl:YES];
    
The page control dots can be customized with different colors.

    [scrollView setPageControlCurrentPageColor:[UIColor redColor]];
    [scrollView setPageControlOtherPagesColor:[UIColor yellowColor]];
