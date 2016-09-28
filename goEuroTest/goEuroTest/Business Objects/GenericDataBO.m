//
//  GenericDataBO.m
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import "GenericDataBO.h"
#import "Utils.h"

@interface GenericDataBO ()

@property (nonatomic, strong) NSDate *arrivalDateTime;
@property (nonatomic, strong) NSDate *departureDateTime;

@end

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
        [self processInformation];
    }
    return self;
}

- (instancetype)initWithObject:(GenericData *)object {
    
    self = [super init];
    if (self) {
        _identifier = object.identifier;
        _numberOfStops = object.numberOfStops;
        _arrivalTime = object.arrivalTime;
        _departureTime = object.departureTime;
        _priceInEuros = object.priceInEuros;
        _providerLogoURL = object.providerLogoURL;
        [self processInformation];
    }
    return self;
}

- (void)processInformation {
    
    if (_priceInEuros != nil) {
        _processedPrice = [NSString stringWithFormat:@"€ %@", _priceInEuros];
    } else {
        _processedPrice = @"Price not available";
    }
    
    if (_departureTime != nil) {
        _departureDateTime = [Utils getDateFromFormattedString:_departureTime];
    }
    if (_arrivalTime != nil) {
        _arrivalDateTime = [Utils getDateFromFormattedString:_arrivalTime];
    }
    
    NSMutableString *temporalBaseSchedule = [[NSMutableString alloc] init];
    
    if (_departureDateTime != nil) {
        [temporalBaseSchedule appendString:[NSString stringWithFormat:@"%@ -",[Utils getFormattedStringFromDate:_departureDateTime]]];
    } else {
        [temporalBaseSchedule appendString:@" _ -"];
    }
    
    if (_arrivalDateTime != nil) {
        [temporalBaseSchedule appendString:[NSString stringWithFormat:@" %@", [Utils getFormattedStringFromDate:_arrivalDateTime]]];
    } else {
        [temporalBaseSchedule appendString:@" _"];
    }
    
    _processedSchedule = temporalBaseSchedule;
    
    NSString *detailsDuration = @"";
    if (_numberOfStops != nil && [_numberOfStops integerValue] == 0) {
        detailsDuration = @"Direct";
    } else {
        detailsDuration = [NSString stringWithFormat:@"%@ stops -",_numberOfStops];
    }
    
    if (_departureDateTime != nil && _arrivalDateTime != nil) {
        NSTimeInterval differenceTime = [_arrivalDateTime timeIntervalSinceDate:_departureDateTime];
        NSDate *differenceDate = [NSDate dateWithTimeIntervalSinceReferenceDate:differenceTime];
        _processedDuration = [NSString stringWithFormat:@"%@ (%@ hs)",detailsDuration, [Utils getFormattedStringFromDate:differenceDate]];
    }
}

@end
