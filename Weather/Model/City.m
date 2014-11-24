//
//  City.m
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/13/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import "City.h"
#import "DatabaseManager.h"
#import "Constants.h"

@implementation City

@dynamic name;
@dynamic country;
@dynamic latitude;
@dynamic longitude;
@dynamic offset;
@dynamic url;

- (id)init
{
    // integration with coredata
    NSManagedObjectContext *context = [[DatabaseManager sharedInstance] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:kCityEntityName inManagedObjectContext:context];
    
    // initialize object
    self = [[City alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:nil];
    
    return self;
}

@end
