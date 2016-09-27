//
//  ConnectionManager.m
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import "ConnectionManager.h"

@implementation ConnectionManager

+ (instancetype)sharedInstanceType {
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)requestFlightsWithHandler:(void (^)(NSArray *response))completion {
    
}

@end
