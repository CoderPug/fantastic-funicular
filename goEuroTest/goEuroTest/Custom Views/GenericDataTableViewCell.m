//
//  GenericDataTableViewCell.m
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import "GenericDataTableViewCell.h"

@implementation GenericDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)loadInformation:(GenericDataBO *)object {
    
    self.labelTime.text = object.processedSchedule;
    self.labelPrice.text = object.processedPrice;
    self.labelNumberOfStops.text = object.processedDuration;
}

@end
