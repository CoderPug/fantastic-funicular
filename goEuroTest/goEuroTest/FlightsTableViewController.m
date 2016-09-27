//
//  FirstViewController.m
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import "FlightsTableViewController.h"
#import "ConnectionManager.h"
#import "GenericDataTableViewCell.h"

@interface FlightsTableViewController ()

@property (nonatomic, strong) NSMutableArray *flights;

@end

@implementation FlightsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"GenericDataTableViewCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"GenericDataTableViewCell"];
    [self requestFlights];
}

#pragma mark - Request

- (void)requestFlights {
    
    ConnectionManager *currentInstance = [ConnectionManager sharedInstanceType];
    if (self.flights == nil) {
        self.flights = [[NSMutableArray alloc] init];
    }
    
    [currentInstance requestFlightsWithHandler:^(NSArray *response) {
       
        self.flights = [NSMutableArray arrayWithArray:response];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GenericDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GenericDataTableViewCell"];
    GenericDataBO *temporalObject = self.flights[indexPath.row];
    
    cell.labelTime.text = [NSString stringWithFormat:@"%@ - %@", temporalObject.departureTime, temporalObject.arrivalTime];
    cell.labelPrice.text = [NSString stringWithFormat:@"€ %@", temporalObject.priceInEuros];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return (self.flights != nil) ? self.flights.count : 0;
}

@end
