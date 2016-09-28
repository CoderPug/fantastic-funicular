//
//  MenuViewController.m
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (nonatomic, weak) IBOutlet UILabel *labelTitle;

@property (nonatomic, strong) UIViewController *flightsTableViewController;
@property (nonatomic, strong) UIViewController *trainsTableViewController;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self customize];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

#pragma mark - Customization

- (void)customize {
    
    if (_flightsTableViewController == nil) {
        _flightsTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"flightsTableViewController"];
    }
    
    if (_flightsTableViewController != nil) {
        
        [self addChildViewController:_flightsTableViewController];
        [_flightsTableViewController.view setFrame:self.scrollView.bounds];
        [self.scrollView addSubview:_flightsTableViewController.view];
        [_flightsTableViewController didMoveToParentViewController:self];
    }
    
    if (_trainsTableViewController == nil) {
        _trainsTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"trainsTableViewController"];
    }
    
    if (_trainsTableViewController != nil) {
        
        CGRect scrollViewFrame = self.scrollView.bounds;
        scrollViewFrame.origin.x = self.view.frame.size.width;
        [self addChildViewController:_trainsTableViewController];
        [_trainsTableViewController.view setFrame:scrollViewFrame];
        [self.scrollView addSubview:_trainsTableViewController.view];
        [_trainsTableViewController didMoveToParentViewController:self];
    }
    
    [self.scrollView setDelegate:self];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width*2.0,
                                               self.scrollView.frame.size.height)];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger currentPage = lround(scrollView.contentOffset.x / pageWidth);
    self.pageControl.currentPage = currentPage;
    
    switch (currentPage) {
        case 0:
            _labelTitle.text = @"FLIGHTS";
            break;
        case 1:
            _labelTitle.text = @"TRAINS";
            break;
        default:
            break;
    }
}

@end
