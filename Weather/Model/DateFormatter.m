//
//  DateFormatter.m
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/15/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

+(NSDate *)dateFromString:(NSString *)stringDate withOffSet:(NSNumber *)offset
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    NSString *cleanString = [stringDate stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSDate *date = [dateFormat dateFromString:cleanString];
    [dateFormat setDateFormat:@"EEEE MMMM d, YYYY"]; // make a constant
    
    return date;
}

+(NSString *)weekDayFromDate:(NSDate *)date
{
    NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
    [weekday setDateFormat: @"EEEE"];
    
    return [weekday stringFromDate:date];
}

@end
