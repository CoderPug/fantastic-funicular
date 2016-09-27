//
//  Utils.h
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSString *)getStringValueFromObject:(NSDictionary *)dictionary forKey:(NSString *)key;
+ (NSNumber *)getNumberValueFromObject:(NSDictionary *)dictionary forKey:(NSString *)key;

@end
