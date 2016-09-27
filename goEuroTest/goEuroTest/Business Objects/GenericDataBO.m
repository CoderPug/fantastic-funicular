//
//  GenericDataBO.m
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import "GenericDataBO.h"
#import "Utils.h"

@implementation GenericDataBO

- (instancetype)initWithData:(NSDictionary *)data {
    
    self = [super init];
    if (self) {
        _identifier = [Utils getNumberValueFromObject:data forKey:@"id"];
        _numberOfStops = [Utils getNumberValueFromObject:data forKey:@"number_of_stops"];
        _arrivalTime = [Utils getStringValueFromObject:data forKey:@"arrival_time"];
        _departureTime = [Utils getStringValueFromObject:data forKey:@"departure_time"];
        _priceInEuros = [Utils getStringValueFromObject:data forKey:@"price_in_euros"];
        _providerLogoURL = [Utils getStringValueFromObject:data forKey:@"provider_logo"];
    }
    return self;
}

@end
