//
//  ConnectionManager.h
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionManager : NSObject

@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfig;
@property (nonatomic, strong) NSURLSession *session;

+ (instancetype)sharedInstanceType;

- (void)requestFlightsWithHandler:(void (^)(NSArray *response))completion;

@end
