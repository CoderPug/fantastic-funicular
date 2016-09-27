//
//  SecondViewController.m
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import "TrainsTableViewController.h"
#import "ConnectionManager.h"
#import "GenericDataTableViewCell.h"

@interface TrainsTableViewController ()

@property (nonatomic, strong) NSMutableArray *trains;

@end

@implementation TrainsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GenericDataTableViewCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"GenericDataTableViewCell"];
    [self requestTrains];
}

#pragma mark - Request

- (void)requestTrains {
    
    ConnectionManager *currentInstance = [ConnectionManager sharedInstanceType];
    if (self.trains == nil) {
        self.trains = [[NSMutableArray alloc] init];
    }
    
    [currentInstance requestFlightsWithHandler:^(NSArray *response) {
        
        self.trains = [NSMutableArray arrayWithArray:response];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GenericDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GenericDataTableViewCell"];
    GenericDataBO *temporalObject = self.trains[indexPath.row];
    
    cell.labelTime.text = [NSString stringWithFormat:@"%@ - %@", temporalObject.departureTime, temporalObject.arrivalTime];
    cell.labelPrice.text = [NSString stringWithFormat:@"€ %@", temporalObject.priceInEuros];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return (self.trains != nil) ? self.trains.count : 0;
}

@end
