//
//  BackgroungManager.m
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/16/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import "BackgroungManager.h"

@implementation BackgroungManager

+(UIImage *)imageForCondition:(NSString *)condition
{
    UIImage * backgroundImage;
    
    BOOL snow = [self string:condition containsString:@"snow"] || [self string:condition containsString:@"ice"] || [self string:condition containsString:@"sleet"] ||  [self string:condition containsString:@"blizzard"];
    if(snow){
        backgroundImage = [UIImage imageNamed:@"snow"];
        return backgroundImage;
    }
    
    BOOL rain = [self string:condition containsString:@"rain"] || [self string:condition containsString:@"showers"];
    if(rain){
        backgroundImage = [UIImage imageNamed:@"rain"];
        return backgroundImage;
    }
    
    BOOL sunny = [self string:condition containsString:@"clear"] || [self string:condition containsString:@"sunny"];
    if(sunny){
        backgroundImage = [UIImage imageNamed:@"clear"];
        return backgroundImage;
    }
    
    BOOL cloudy = [self string:condition containsString:@"cloudy"] || [self string:condition containsString:@"overcast"] || [self string:condition containsString:@"mist"];
    if(cloudy){
        backgroundImage = [UIImage imageNamed:@"cloudy"];
        return backgroundImage;
    }
    
    backgroundImage = [UIImage imageNamed:@"default"];

    return backgroundImage;
}

+(BOOL)string:(NSString *)condition containsString:(NSString *)word
{
    BOOL found = NO;
    
    if ([[condition lowercaseString] containsString:word]) {
        found = YES;
    }
    
    return found;
    
}

@end
