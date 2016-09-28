//
//  SecondViewController.m
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import "TrainsTableViewController.h"
#import "ConnectionManager.h"
#import "StoreManager.h"
#import "GenericDataTableViewCell.h"

@interface TrainsTableViewController ()

@property (nonatomic, strong) NSMutableArray *trains;

@end

@implementation TrainsTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self customize];
    [self loadTrains];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self requestTrains];
}

#pragma mark - Customization

- (void)customize {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GenericDataTableViewCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"GenericDataTableViewCell"];
}

#pragma mark - Public

- (void)reloadData {
    
    [self loadTrains];
    [self.tableView reloadData];
}

#pragma mark - Load

- (void)loadTrains {
    
    if (self.trains == nil) {
        self.trains = [[NSMutableArray alloc] init];
    }
    self.trains = [NSMutableArray arrayWithArray:[[StoreManager sharedInstance] retrieveGenericDataOfType:GenericDataType_Train]];
}

#pragma mark - Request

- (void)requestTrains {
    
    ConnectionManager *currentInstance = [ConnectionManager sharedInstanceType];
    if (self.trains == nil) {
        self.trains = [[NSMutableArray alloc] init];
    }
    
    [currentInstance requestTrainsWithHandler:^(NSArray *response) {
        
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
    
    return (self.trains != nil) ? self.trains.count : 0;
}

@end
