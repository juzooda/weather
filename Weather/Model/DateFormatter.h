//
//  DateFormatter.h
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/15/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatter : NSObject

+ (NSDate *)dateFromString:(NSString *)stringDate withOffSet:(NSNumber *)offset;
+ (NSString*)weekDayFromDate:(NSDate *)date;

@end
