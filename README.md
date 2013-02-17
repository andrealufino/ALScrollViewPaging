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
    
#License

Copyright (C) 2013 Andrea Lufino

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, 
copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to 
whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the 
Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
