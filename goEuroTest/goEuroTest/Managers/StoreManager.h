//
//  StoreManager.h
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericDataBO.h"

typedef NS_ENUM(NSInteger, SortingCriteriaType) {
    SortingCriteriaType_Departure,
    SortingCriteriaType_Arrival,
    SortingCriteriaType_Duration
};

@interface StoreManager : NSObject

@property (nonatomic, assign) SortingCriteriaType type;

+ (instancetype)sharedInstance;

- (void)saveObject:(GenericDataBO *)object withType:(GenericDataType)type;
- (void)saveArray:(NSArray *)elements withType:(GenericDataType)type;
- (NSArray *)retrieveGenericDataOfType:(GenericDataType)type;

@end
