//
//  ConnectionManager.m
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import "ConnectionManager.h"
#import "StoreManager.h"

static NSString *const CMFlightsURL = @"https://api.myjson.com/bins/w60i";
static NSString *const CMTrainsURL = @"https://api.myjson.com/bins/3zmcy";

@implementation ConnectionManager

#pragma mark - Initialization

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
        [self initializeValues];
    }
    return self;
}

- (void)initializeValues {
    
    _sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:self.sessionConfig
                                             delegate:nil
                                        delegateQueue:nil];
}

#pragma mark - Private

- (void)performRequestWithURL:(NSString *)stringURL completion:(void (^)(NSArray *response))completionFunction {
    
    if ((self.sessionConfig == nil) || (self.session == nil)) {
        NSLog(@"ERROR: Connection Manager values not initialized");
        return;
    }
    if ((stringURL == nil) || [stringURL isEqualToString:@""]) {
        NSLog(@"ERROR: StringURL is nil or empty");
        return;
    }
    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request
                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *errorA) {
                                                    
                                                     if (errorA == nil) {
                                                         NSError *errorB = nil;
                                                         id responseElement = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                   options:0
                                                                                                                     error:&errorB];
                                                         if (errorB == nil) {
                                                             if ([responseElement isKindOfClass:[NSArray class]]) {
                                                                 NSArray *responseArray = responseElement;
                                                                 completionFunction(responseArray);
                                                             } else {
                                                                 NSLog(@"ERROR: Response not an array");
                                                             }
                                                         } else {
                                                             NSLog(@"ERROR: Can not convert Data into JSON");
                                                         }
                                                     } else {
                                                         NSLog(@"ERROR: URLSessionDataTask failed %@", [errorA localizedDescription]);
                                                     }
                                                 }];
    [task resume];
}

#pragma mark - Public

- (void)requestFlightsWithHandler:(void (^)(NSArray *response))completion {
    
    [self performRequestWithURL:CMFlightsURL
                     completion:^(NSArray *response) {
                         
                         [[StoreManager sharedInstance] saveArray:response
                                                         withType:GenericDataType_Flight];
                         
                         NSArray *result = [[StoreManager sharedInstance] retrieveGenericDataOfType:GenericDataType_Flight];
                         completion(result);
                     }];
}

- (void)requestTrainsWithHandler:(void (^)(NSArray *response))completion {
    
    [self performRequestWithURL:CMTrainsURL
                     completion:^(NSArray *response) {
                         
                         [[StoreManager sharedInstance] saveArray:response
                                                         withType:GenericDataType_Train];
                         
                         NSArray *result = [[StoreManager sharedInstance] retrieveGenericDataOfType:GenericDataType_Train];
                         completion(result);
                     }];
}

@end
