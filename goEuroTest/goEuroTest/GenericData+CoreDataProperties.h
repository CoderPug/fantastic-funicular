//
//  GenericData+CoreDataProperties.h
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GenericData.h"

NS_ASSUME_NONNULL_BEGIN

@interface GenericData (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSString *providerLogoURL;
@property (nullable, nonatomic, retain) NSString *priceInEuros;
@property (nullable, nonatomic, retain) NSNumber *numberOfStops;
@property (nullable, nonatomic, retain) NSNumber *identifier;
@property (nullable, nonatomic, retain) NSString *departureTime;
@property (nullable, nonatomic, retain) NSString *arrivalTime;

@end

NS_ASSUME_NONNULL_END
