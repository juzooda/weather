//
//  DatabaseManager.h
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/22/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DatabaseManager : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (instancetype)sharedInstance;
- (void)executeSynchronizedInsert:(NSManagedObject *)objectToBeInserted error:(NSError **)error;
- (void)executeSynchronizedUpdate:(NSManagedObject *)objectToBeUpdated error:(NSError **)error;
- (void)executeSynchronizedDelete:(NSManagedObject *)objectToBeDeleted error:(NSError **)error;
- (NSArray *)executeSynchronizedFetchRequest:(NSFetchRequest *)request error:(NSError **)error;
- (NSString *) executeSynchronized;

@end
