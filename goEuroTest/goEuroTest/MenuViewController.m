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

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width*2.0,
                                               self.scrollView.frame.size.height)];
}

@end
