//
//  StoreManager.h
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericDataBO.h"

@interface StoreManager : NSObject

+ (instancetype)sharedInstance;

- (void)saveObject:(GenericDataBO *)object withType:(GenericDataType)type;
- (void)saveArray:(NSArray *)elements withType:(GenericDataType)type;
- (NSArray *)retrieveGenericDataOfType:(GenericDataType)type;

@end
