//
//  GenericDataTableViewCell.h
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericDataBO.h"

@interface GenericDataTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *logoImage;
@property (nonatomic, weak) IBOutlet UILabel *labelPrice;
@property (nonatomic, weak) IBOutlet UILabel *labelTime;
@property (nonatomic, weak) IBOutlet UILabel *labelNumberOfStops;

- (void)loadInformation:(GenericDataBO *)object;

@end
