//
//  CityBO.m
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/13/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import "CityBO.h"
#import "FlickerBO.h"
#import "DatabaseManager.h"
#import "Constants.h"

@implementation CityBO

+(void)remove:(City*)city
{
    DatabaseManager * databaseManager = [DatabaseManager sharedInstance];
    [databaseManager executeSynchronizedDelete:city error:nil];
}

+(void)setSelectedCity:(City *)city
{
    [[NSUserDefaults standardUserDefaults] setObject:city.name forKey:kCityName];
    [[NSUserDefaults standardUserDefaults] setObject:city.country forKey:kCityCountry];
}

+(City *)applicationLastSelectedCity
{
    NSString *cityName = [[NSUserDefaults standardUserDefaults] stringForKey:kCityName];
    NSString *cityCountry = [[NSUserDefaults standardUserDefaults] stringForKey:kCityCountry];
    
    City *city;
    
    if (cityName && cityName.length > 0 && cityCountry.length > 0) {

        DatabaseManager * databaseManager = [DatabaseManager sharedInstance];
        city = [City cityFromName:cityName andCountry:cityCountry inManagedObjectContext:databaseManager.managedObjectContext];
    }
    
    return city;
}

+(NSArray *)all
{
    DatabaseManager *databaseManager = [DatabaseManager sharedInstance];
    return [City citiesInManagedObjectContext:databaseManager.managedObjectContext];
}

+ (City *)addWithRepresentation:(NSDictionary *)representation
{
    DatabaseManager *databaseManager = [DatabaseManager sharedInstance];
    City * city = [City cityWithWorldWeatherData:representation inManagedObjectContext:databaseManager.managedObjectContext];
    
    [databaseManager executeSynchronizedInsert:city error:nil];
    
    return city;
}

#pragma mark - Web Service

- (void)executeRequestByCityName:(NSString *)cityName withCompletionBlock:(void (^)(NSArray * cities))completion
{
    NSDictionary * parameters = @{@"q":cityName, @"timezone":@"yes", @"key":kApiKey, @"format":@"json"};
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager GET:kSearchURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray * cities = [[NSMutableArray alloc] init];
        
        NSDictionary * jsonRepresentation = (NSDictionary *)responseObject;
        NSDictionary * searchAPI = [jsonRepresentation objectForKey:@"search_api"];
        NSArray * results = [searchAPI objectForKey:@"result"];
        
        for (NSDictionary * places in results) {
            
            NSArray * timezoneList = [places objectForKey:@"timezone"];
            NSArray * areaNameList = [places objectForKey:@"areaName"];
            NSArray * countryList = [places objectForKey:@"country"];
            
            NSDictionary * cityValue = [areaNameList firstObject];
            NSDictionary * countryValue = [countryList firstObject];
            NSDictionary * timezone = [timezoneList firstObject];
            
            NSString * city = [cityValue objectForKey:@"value"];
            NSString * country = [countryValue objectForKey:@"value"];
            NSString * offset = [timezone objectForKey:@"offset"];
            
            NSString * latitude = [places objectForKey:@"latitude"];
            NSString * longitude = [places objectForKey:@"longitude"];
            
            NSDictionary * cityRepresentation = @{kCityName:city,
                                                  kCityCountry:country,
                                                  kCityLatitude:latitude,
                                                  kCityLongitude:longitude,
                                                  kCityTimeZoneOffset:offset
                                                  };
            
            [cities addObject:cityRepresentation];
        }
        
        completion(cities);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)executeRequestForWeatherInCity:(City *)city withCompletionBlock:(void (^)(Weather * currentWeather, NSArray * weathers))completion
{
    NSString * cityLatLong = [NSString stringWithFormat:@"%@,%@", city.latitude, city.longitude];
    
    NSDictionary * parameters = @{@"q":cityLatLong, @"key":kApiKey, @"format":@"json"};
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager GET:kWeatherURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray * allWeatherList = [[NSMutableArray alloc] init];
        
        NSDictionary * jsonRepresentation = (NSDictionary *)responseObject;
        NSDictionary * data = [jsonRepresentation objectForKey:@"data"];
        NSArray * currentCondition = [data objectForKey:@"current_condition"];
        
        NSDictionary * currentConditionData = [currentCondition firstObject];
        NSArray * weatherDescription = [currentConditionData objectForKey:@"weatherDesc"];
        NSDictionary * weatherDescriptionData = [weatherDescription firstObject];

        Weather * weather = [[Weather alloc] init];
        weather.current = YES;
        weather.city = city;
        weather.temperatureC = [currentConditionData objectForKey:@"temp_C"];
        weather.temperatureF = [currentConditionData objectForKey:@"temp_F"];
        weather.value = [weatherDescriptionData objectForKey:@"value"];
        
        completion (weather, nil);
        
        NSArray * weatherList = [data objectForKey:@"weather"];
        
        for (NSDictionary * weatherData in weatherList) {
            
            NSString * date = [weatherData objectForKey:@"date"];
            NSArray * hourly = [weatherData objectForKey:@"hourly"];
            NSDictionary * hourData = [hourly firstObject];
            
            NSArray * hourWeatherDescription = [hourData objectForKey:@"weatherDesc"];
            NSDictionary * hourWeatherDescriptionData = [hourWeatherDescription firstObject];
            
            Weather * weather = [[Weather alloc] init];
            weather.current = NO;
            weather.city = city;
            weather.date = date;
            weather.temperatureC = [hourData objectForKey:@"tempC"];
            weather.temperatureF = [hourData objectForKey:@"tempF"];
            weather.value = [hourWeatherDescriptionData objectForKey:@"value"];
            
            [allWeatherList addObject:weather];
        }
        
        completion(nil, allWeatherList);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
