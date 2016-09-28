//
//  FirstViewController.m
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import "FlightsTableViewController.h"
#import "ConnectionManager.h"
#import "StoreManager.h"
#import "GenericDataTableViewCell.h"

@interface FlightsTableViewController ()

@property (nonatomic, strong) NSMutableArray *flights;

@end

@implementation FlightsTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self customize];
    [self loadFlights];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self requestFlights];
}

#pragma mark - Customization

- (void)customize {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GenericDataTableViewCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"GenericDataTableViewCell"];
}

#pragma mark - Request

- (void)loadFlights {
    
    if (self.flights == nil) {
        self.flights = [[NSMutableArray alloc] init];
    }
    self.flights = [NSMutableArray arrayWithArray:[[StoreManager sharedInstance] retrieveGenericDataOfType:GenericDataType_Flight]];
}

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
    [cell loadInformation:temporalObject];
    
    cell.logoImage.image = nil;
    
    NSString *stringImageURL = [temporalObject.providerLogoURL stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
    
    if (stringImageURL != nil) {
        
        NSURL *url = [NSURL URLWithString:stringImageURL];
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (data) {
                UIImage *temporalImage = [UIImage imageWithData:data];
                if (temporalImage != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        GenericDataTableViewCell *temporalCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                        if (temporalCell != nil) {
                            [temporalCell.logoImage setImage:temporalImage];
                        }
                    });
                }
            }
        }];
        [task resume];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return (self.flights != nil) ? self.flights.count : 0;
}

@end
