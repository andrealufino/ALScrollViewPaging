ALScrollViewPaging
==================

This UIScrollView subclass provides a method to add paging and a demo project.

Usage
==================

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
