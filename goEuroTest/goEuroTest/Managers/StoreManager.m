//
//  StoreManager.m
//  goEuroTest
//
//  Created by Santex on 9/27/16.
//  Copyright © 2016 goeuro. All rights reserved.
//

#import "StoreManager.h"
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@implementation StoreManager

#pragma mark - Initialization

+ (instancetype)sharedInstance {
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    
    if (self = [super init]) {
    }
    return self;
}

#pragma mark - Private

- (NSManagedObjectContext *)managedObjectContext {
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

#pragma mark - Public

- (void)saveObject:(GenericDataBO *)object withType:(GenericDataType)type {
    
    if (object == nil || object.identifier == nil) {
        return;
    }
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error = nil;
    
    NSFetchRequest *newRequest = [NSFetchRequest fetchRequestWithEntityName:@"GenericData"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@ AND type == %d", [object.identifier stringValue], type];
    [newRequest setPredicate:predicate];
    NSUInteger count = [context countForFetchRequest:newRequest error:&error];
    if (!error) {
        if (count > 0) {
            NSLog(@"ERROR: Object already exists!");
            return;
        }
    } else {
        NSLog(@"ERROR: Could not save - %@ %@", error, [error localizedDescription]);
        return;
    }
    
    NSManagedObject *newObject = [NSEntityDescription insertNewObjectForEntityForName:@"GenericData" inManagedObjectContext:context];
    [newObject setValue:object.identifier forKey:@"identifier"];
    [newObject setValue:object.departureTime forKey:@"departureTime"];
    [newObject setValue:object.arrivalTime forKey:@"arrivalTime"];
    [newObject setValue:object.providerLogoURL forKey:@"providerLogoURL"];
    [newObject setValue:object.priceInEuros forKey:@"priceInEuros"];
    [newObject setValue:object.numberOfStops forKey:@"numberOfStops"];
    [newObject setValue:[NSNumber numberWithInteger:type] forKey:@"type"];
    
    error = nil;
    [context save:&error];
    
    if (error != nil) {
        NSLog(@"ERROR: Could not save - %@ %@", error, [error localizedDescription]);
    }
}

- (void)saveArray:(NSArray *)elements withType:(GenericDataType)type {
    
    if (elements == nil) {
        return;
    }
    
    for (int i=0; i<elements.count; i++) {
        NSDictionary *temporalDictionary = elements[i];
        GenericDataBO *temporalObject = [[GenericDataBO alloc] initWithData:temporalDictionary];
        [self saveObject:temporalObject withType:type];
    }
}

- (NSArray *)retrieveGenericDataOfType:(GenericDataType)type {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *newRequest = [NSFetchRequest fetchRequestWithEntityName:@"GenericData"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"identifier" ascending:YES];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type == %d", type];
    [newRequest setSortDescriptors:@[sortDescriptor]];
    [newRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *arrayCoreDataEntities = [context executeFetchRequest:newRequest error:&error];
    if (error != nil) {
        return nil;
    }
    
    NSMutableArray *arrayBusinessObjects = [[NSMutableArray alloc] init];
    for (int i=0; i<arrayCoreDataEntities.count; i++) {
        GenericData *temporalObject = arrayCoreDataEntities[i];
        if (temporalObject != nil) {
            GenericDataBO *temporalElement = [[GenericDataBO alloc] initWithObject:temporalObject];
            [arrayBusinessObjects addObject:temporalElement];
        }
    }
    
    return arrayBusinessObjects;
}

@end
