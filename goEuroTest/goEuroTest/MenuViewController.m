//
//  MenuViewController.m
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import "MenuViewController.h"
#import "StoreManager.h"
#import "FlightsTableViewController.h"
#import "TrainsTableViewController.h"

@interface MenuViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (nonatomic, weak) IBOutlet UILabel *labelTitle;

@property (nonatomic, strong) SortingOptionsTableViewController *popOverController;
@property (nonatomic, strong) FlightsTableViewController *flightsTableViewController;
@property (nonatomic, strong) TrainsTableViewController *trainsTableViewController;

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

#pragma mark - IBActions

- (IBAction)buttonFilterTouchUpInside:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    if (self.popOverController == nil) {
        self.popOverController = [self.storyboard instantiateViewControllerWithIdentifier:@"sortingOptionsTableViewController"];
    }
    
    self.popOverController.modalPresentationStyle = UIModalPresentationPopover;
    self.popOverController.preferredContentSize = CGSizeMake(180, 70+50*3+20);
    self.popOverController.customDelegate = self;
    UIPopoverPresentationController *temporalPresentationController = self.popOverController.popoverPresentationController;
    if (temporalPresentationController != nil) {
        temporalPresentationController.delegate = self;
        temporalPresentationController.sourceView = button;
        temporalPresentationController.sourceRect = button.bounds;
        [self presentViewController:self.popOverController animated:true completion:nil];
    }
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
 
    return UIModalPresentationNone;
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

#pragma mark - SortingOptionsTableViewControllerDelegate

- (void)sortingOptionsTableViewControllerDidSelectOption:(SortingOptionsTableViewController *)controller selection:(SortingCriteriaType)selection {
 
    if (self.popOverController != nil) {
        [self.popOverController dismissViewControllerAnimated:true completion:^{
            
            [[StoreManager sharedInstance] setType:selection];
            
            if (self.flightsTableViewController != nil) {
                [self.flightsTableViewController reloadData];
            }
            if (self.trainsTableViewController != nil) {
                [self.trainsTableViewController reloadData];
            }
        }];
    }
}

@end
