//
//  City+DAO.h
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/13/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import "City.h"

@interface City (DAO)

+ (City *)cityWithWorldWeatherData:(NSDictionary *)cityRepresentation inManagedObjectContext:(NSManagedObjectContext *)context;
+ (City *)cityFromName:(NSString *)name andCountry:(NSString *)country inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSArray *)citiesInManagedObjectContext:(NSManagedObjectContext *)context;


@end
