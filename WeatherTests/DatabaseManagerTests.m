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

describe(@"DatabaseManager -", ^{

    __block City *city;
    __block NSFetchRequest *request;
    __block DatabaseManager * databaseManager;
    
    before(^{
        city = [[City alloc] init];
        city.name = @"Rafael";
        city.country = @"Maripua";
        
        request = [NSFetchRequest fetchRequestWithEntityName:kCityEntityName];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:kCityName ascending:YES]];
        databaseManager = [[DatabaseManager alloc] init];
    });
    
    
    it(@"Should be able to fetch objects from database", ^{
        
        NSArray * results = [databaseManager executeSynchronizedFetchRequest:request error:nil];
        expect(results).notTo.beEmpty();
        
    });

    it(@"Should Insert an object in database", ^{
        
        [[DatabaseManager sharedInstance] executeSynchronizedInsert:city error:nil];
        
        request.predicate = [NSPredicate predicateWithFormat:@"name like %@ AND country like %@",city.name, city.country];
        NSArray * cityResultList = [databaseManager executeSynchronizedFetchRequest:request error:nil];
        
        expect(cityResultList).notTo.beEmpty();
        
        City * cityResult = [cityResultList firstObject];
        NSLog(@"%@", cityResult);
        
        expect(cityResult.name).to.equal(@"Rafael");
        expect(cityResult.country).to.equal(@"Maripua");
        
    });
    
    it(@"Should Delete an object in database", ^{
        
        [[DatabaseManager sharedInstance] executeSynchronizedDelete:city error:nil];
        
        request.predicate = [NSPredicate predicateWithFormat:@"name like %@ AND country like %@",city.name, city.country];
        NSArray * cityResultList = [databaseManager executeSynchronizedFetchRequest:request error:nil];
        
        expect(cityResultList).to.beEmpty();
    });
    
});

SpecEnd