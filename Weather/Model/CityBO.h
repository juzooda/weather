//
//  CityBO.h
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/13/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "City+DAO.h"
#import "Weather.h"

@interface CityBO : NSObject

+ (NSArray *)all;
+ (void)remove:(City*)city;
+ (City *)getSelected;
+ (void)setSelectedCity:(City *)city;
+ (City *)addWithRepresentation:(NSDictionary *)representation;
- (void)findByName:(NSString *)name withCompletionBlock:(void (^)(NSArray * cities))completion;
- (void)weatherFrom:(City *)city withCompletionBlock:(void (^)(Weather * currentWeather, NSArray * weathers))completion;

@end
