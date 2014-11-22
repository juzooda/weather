//
//  DateFormatterTests.m
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
#import "DateFormatter.h"


SpecBegin(DateFormatter)

describe(@"CityBO functionalities", ^{
    
    __block DateFormatter * dateFormatter;
    
    beforeEach(^{
        dateFormatter =[[DateFormatter alloc] init];
    });
    
    it (@"Should return a valid NSDate if a corret format NSString is passed.", ^{
        NSDate * date = [DateFormatter dateFromString:@"2014-12-21" withOffSet:@(3)];
        expect(date).notTo.beNil();
    });
    
    it (@"Should return a not nil string from NSDate", ^{
        NSString * weekDayFormat = [DateFormatter weekDayFromDate:[NSDate date]];
        expect(weekDayFormat).notTo.beNil();
    });
    
});


SpecEnd