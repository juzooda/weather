//
//  DatabaseManagerTests.m
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

#import "AppDelegate.h"
#import "DatabaseManager.h"
#import "City+DAO.h"
#import "Constants.h"

SpecBegin(DatabaseManager)

describe(@"DatabaseManager Init methods", ^{
    
    it (@"Database manager init", ^{
        DatabaseManager *databaseManager = [[DatabaseManager alloc] init];
        expect(databaseManager).notTo.beNil();
    });
    
    it(@"Database singlethon should not be nil", ^{
        expect([DatabaseManager sharedInstance]).notTo.beNil();
    });
    
    it(@"Database alloc with zone should not return nil", ^{
        expect([DatabaseManager allocWithZone:NULL]).notTo.beNil();
    });

});

describe(@"DatabaseManager database access methods", ^{

    __block City * city;
    
    before(^{
        city = [[City alloc] init];
        city.name = @"Dublin";
        city.country = @"Ireland";
    });
    
//    it(@"Should Execute syncronzed fetch request", ^{
//        
//        [[DatabaseManager sharedInstance] executeSynchronizedFetchRequest:nil error:nil];
//        
//    });
//    
//    it(@"Should Insert an object in database", ^{
//        [[DatabaseManager sharedInstance] executeSynchronizedInsert:city error:nil];
//        
//    });
    
});

SpecEnd