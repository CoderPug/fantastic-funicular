//
//  FirstViewController.m
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import "FlightsTableViewController.h"
#import "ConnectionManager.h"

@interface FlightsTableViewController ()

@end

@implementation FlightsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[ConnectionManager sharedInstanceType] requestFlightsWithHandler:^(NSArray *response) {
        
        NSLog(@"%@",response);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
