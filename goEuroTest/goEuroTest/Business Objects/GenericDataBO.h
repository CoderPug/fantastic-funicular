//
//  GenericDataBO.h
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GenericDataBO : NSObject

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSNumber *numberOfStops;
@property (nonatomic, strong) NSNumber *dataType;
@property (nonatomic, strong) NSString *priceInEuros;
@property (nonatomic, strong) NSString *arrivalTime;
@property (nonatomic, strong) NSString *departureTime;
@property (nonatomic, strong) NSString *providerLogoURL;

@property (nonatomic, strong, readonly) NSString *processedDuration;
@property (nonatomic, strong, readonly) NSString *processedPrice;
@property (nonatomic, strong, readonly) NSString *processedSchedule;

- (instancetype)initWithData:(NSDictionary *)data;

@end
