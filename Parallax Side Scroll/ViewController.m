//
//  ViewController.m
//  Parallax Side Scroll
//
//  Created by Vinay Nair on 19/04/14.
//  Copyright (c) 2014 vin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    max_no_of_pages = 3;
    percentageMultiplier = 0.3;     //Change to play around with amount of parallax
    viewWidth = self.view.frame.size.width;
    
    for (int i = 0; i < max_no_of_pages; i++) {
        CGFloat diff = 1;   //Border
        CGRect frame = CGRectMake((self.view.frame.size.width * i), 0, viewWidth, self.view.frame.size.height);
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        
        UIScrollView *internalScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake( diff, 0, viewWidth - (diff*2), self.view.frame.size.height)];
        [internalScrollView setScrollEnabled:NO];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, internalScrollView.frame.size.width, self.view.frame.size.height)];
        internalScrollView.tag = (i+1)*10;
        imageView.tag = (i+1)*100;
        
        NSString *imagePath = [NSString stringWithFormat:@"bg_temp_%d.jpg", i+1];
        imageView.image = [UIImage imageNamed:imagePath];
        [internalScrollView addSubview:imageView];
        [subview addSubview:internalScrollView];
        [self.mainScrollView addSubview:subview];
    }
    
    self.mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * max_no_of_pages, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Scroll View Methods


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UIScrollView *internalScrollView = (UIScrollView *)[scrollView viewWithTag:(currentPageNumber+1)*10];
    UIScrollView *otherScrollView = (UIScrollView *)[scrollView viewWithTag:(otherPageNumber+1)*10];
    
    [internalScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    [otherScrollView setContentOffset:CGPointMake(0, 0) animated:NO];

    currentPageNumber = scrollView.contentOffset.x / scrollView.frame.size.width;

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    ScrollDirection scrollDirection;
    int signMultiplier = 1;
    
    //Get the other page than the main view that is being scrolled
    if (self.lastContentOffset > scrollView.contentOffset.x){
        scrollDirection = ScrollDirectionRight;
        if (currentPageNumber > 0) {
            otherPageNumber = currentPageNumber - 1;
        }
        signMultiplier = -1;
    }
    else if (self.lastContentOffset < scrollView.contentOffset.x){
        scrollDirection = ScrollDirectionLeft;
        if (currentPageNumber < max_no_of_pages) {
            otherPageNumber = currentPageNumber + 1;
        }
        signMultiplier = 1;
    }
    
    
    self.lastContentOffset = scrollView.contentOffset.x;
    CGFloat offset = scrollView.contentOffset.x;
    UIScrollView *internalScrollView = (UIScrollView *)[scrollView viewWithTag:(currentPageNumber+1)*10];
    UIScrollView *otherScrollView = (UIScrollView *)[scrollView viewWithTag:(otherPageNumber+1)*10];
    
    
    //Set offset to create parallax effect
    [internalScrollView setContentOffset:CGPointMake(-percentageMultiplier * (offset- (viewWidth * currentPageNumber)), 0) animated:NO];
    [otherScrollView setContentOffset:CGPointMake(signMultiplier * percentageMultiplier*(viewWidth) - (percentageMultiplier * (offset- (viewWidth * currentPageNumber))), 0) animated:NO];
}

@end
