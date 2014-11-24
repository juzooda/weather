//
//  WeatherTests.m
//  WeatherTests
//
//  Created by Rafael Juzo G Oda on 11/13/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <Specta/Specta.h>

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import "AppDelegate.h"
#import "CityBO.h"
#import "City+DAO.h"
#import "Constants.h"


SpecBegin(CityBO)

describe(@"CityBO functionalities", ^{
    
    __block CityBO * cityBO;
    
    beforeEach(^{
        cityBO =[[CityBO alloc] init];
    });
    
    it (@"Cities array should not be nil with a valid City name.", ^{
        [cityBO executeRequestByCityName:@"Dublin" withCompletionBlock:^(NSArray *cities) {
            expect(cities).notTo.beNil();
        }];
    });
    
    it (@"Current Weather and 5 days weather list should be correct.", ^{
        
    });
    
    
});


SpecEnd