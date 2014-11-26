//
//  CityTests.m
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/25/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <Specta/Specta.h>

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import "City+DAO.h"
#import "Constants.h"

SpecBegin(City)

describe(@"CityBO functionalities", ^{
    
    beforeEach(^{
        
    });
    
    it(@"City Init Should not be nil", ^{
        City * city = [[City alloc] init];
        expect(city).notTo.beNil();
    });
    
    it(@"City basic init should not be in database", ^{
        City * city = [[City alloc] init];
        expect(city.managedObjectContext).to.beNil();
    });
    
    
});


SpecEnd