//
//  ViewController.h
//  Parallax Side Scroll
//
//  Created by Vinay Nair on 19/04/14.
//  Copyright (c) 2014 vin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft
} ScrollDirection;

@interface ViewController : UIViewController <UIScrollViewDelegate>
{
    int currentPageNumber;
    int otherPageNumber;    //Not the main page being scrolled, its the other page that is being pulled.
    int max_no_of_pages;
    double percentageMultiplier;   //Change to play around with amount of parallax
    CGFloat viewWidth;
}

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic) CGFloat lastContentOffset;

@end
