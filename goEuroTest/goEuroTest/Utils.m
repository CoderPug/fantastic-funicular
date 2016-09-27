//
//  Utils.m
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)getStringValueFromObject:(NSDictionary *)dictionary forKey:(NSString *)key {
    
    if (dictionary != nil && key != nil) {
        id dataElement = [dictionary objectForKey:key];
        if (dataElement) {
            if ([dataElement isKindOfClass:[NSString class]]) {
                return dataElement;
            } else if ([dataElement isKindOfClass:[NSNumber class]]) {
                return [NSString stringWithFormat:@"%@",dataElement];
            }
        }
    }
    return @"";
}

+ (NSNumber *)getNumberValueFromObject:(NSDictionary *)dictionary forKey:(NSString *)key {
    
    if (dictionary != nil && key != nil) {
        id dataElement = [dictionary objectForKey:key];
        if (dataElement) {
            if ([dataElement isKindOfClass:[NSNumber class]]) {
                return dataElement;
            } else if ([dataElement isKindOfClass:[NSString class]]) {
                return [NSNumber numberWithDouble:[dataElement doubleValue]];
            }
        }
    }
    return [NSNumber numberWithInt:0];
}

@end
