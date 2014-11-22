//
//  Constants.h
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/13/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#ifndef Weather_Constants_h
#define Weather_Constants_h

#define CELSIUS 0
#define FAHRENHEIT 1

//Flicker

static NSString *const kFlickrKey = @"eac2ffd03460e01ab1aaf4b957b9d893";
static NSString *const kFlickrSecret = @"c46093793a17c8fc";
static NSString *const kFlickrURL = @"https://api.flickr.com/services/rest/?method=flickr.photos.search";
static NSString *const kFlickrGetSizeURL = @"https://api.flickr.com/services/rest/?method=flickr.photos.getSizes";

//Network

static NSString *const kApiKey = @"7e031c4a8f7055a9c7b6cffb42e9a";
static NSString *const kSearchURL = @"http://api.worldweatheronline.com/free/v2/search.ashx";
static NSString *const kWeatherURL = @"http://api.worldweatheronline.com/free/v2/weather.ashx";

//City Representation

static NSString *const kCityEntityName = @"City";
static NSString *const kCityCountry = @"country";
static NSString *const kCityName = @"name";
static NSString *const kCityLatitude = @"latitude";
static NSString *const kCityLongitude = @"longitude";
static NSString *const kCityTimeZoneOffset = @"offset";


#endif
