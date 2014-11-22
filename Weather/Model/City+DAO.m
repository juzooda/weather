//
//  City+DAO.m
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/13/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import "City+DAO.h"
#import "AppDelegate.h"
#import "Constants.h"

@implementation City (DAO)

+ (City *)cityFromName:(NSString *)name andCountry:(NSString *)country inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:kCityEntityName];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:kCityName ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"name like %@ AND country like %@",name, country];

    NSError * error = nil;
    NSArray * cities = [context executeFetchRequest:request error:&error];
    
    return [cities firstObject];
}

+ (City *)cityWithWorldWeatherData:(NSDictionary *)cityRepresentation inManagedObjectContext:(NSManagedObjectContext *)context
{
    
    City * city = [self cityFromName:[cityRepresentation valueForKey:kCityName]
                          andCountry:[cityRepresentation valueForKey:kCityCountry]
              inManagedObjectContext:context];
    
    if (!city) {
        city  = [NSEntityDescription insertNewObjectForEntityForName:kCityEntityName inManagedObjectContext:context];
        
        city.country = [cityRepresentation valueForKey:kCityCountry];
        city.name = [cityRepresentation valueForKey:kCityName];
        city.latitude = [cityRepresentation valueForKey:kCityLatitude];
        city.longitude = [cityRepresentation valueForKey:kCityLongitude];
        city.offset = [NSNumber numberWithInteger:[[cityRepresentation valueForKey:kCityTimeZoneOffset] integerValue]];
    }
    
    return city;
}

+(NSArray *)citiesInManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:kCityEntityName];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:kCityName ascending:YES]];

    NSError * error = nil;
    
    return [context executeFetchRequest:request error:&error];
}

@end
