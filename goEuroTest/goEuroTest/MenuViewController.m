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

@end

@implementation MenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self customize];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

#pragma mark - Customization

- (void)customize {
    
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
