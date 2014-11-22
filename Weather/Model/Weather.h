//
//  Weather.h
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/13/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"

@interface Weather : NSObject

@property (nonatomic, strong) City * city;
@property (nonatomic) BOOL current;

@property (nonatomic, strong) NSString * value;
@property (nonatomic, retain) NSString * date;

@property (nonatomic, retain) NSNumber * temperatureC;
@property (nonatomic, retain) NSNumber * temperatureF;


@end
