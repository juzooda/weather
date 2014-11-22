//
//  FlickerBO.m
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/15/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import "FlickerBO.h"
#import "AFNetworking.h"
#import "Constants.h"

@implementation FlickerBO

- (void)requestImageRepresentationFromCity:(NSString *)name withCompletionBlock:(void (^)(NSString * imageURL))completion
{
 
    NSDictionary * parameters = @{@"tags":name,
                                  @"media":@"photos",
                                  @"sort":@"relevance",
                                  @"api_key":kFlickrKey,
                                  @"format":@"json",
                                  @"nojsoncallback":@"1",
                                  @"pages":@"1",
                                  @"perpage":@"1"
                                  };
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager GET:kFlickrURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * responseObjectRepresentation = responseObject;
        NSDictionary * photoListRepresentation = [responseObjectRepresentation objectForKey:@"photos"];
        NSArray * photoList = [photoListRepresentation objectForKey:@"photo"];
        NSDictionary * firstPhotoResultRepresentation = [photoList firstObject];
        
        [self requestFlickrURLwithRepresentation:firstPhotoResultRepresentation withCompletionBlock:^(NSString *imageURL) {
            
            completion(imageURL);
            
        }];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@: Error: %@",[self class], error);
    }];

}

- (void)requestFlickrURLwithRepresentation:(NSDictionary *)photoRepresentation withCompletionBlock:(void (^)(NSString * imageURL))completion
{
    NSDictionary * parameters = @{@"photo_id":[photoRepresentation objectForKey:@"id"],
                                  @"api_key":kFlickrKey,
                                  @"format":@"json",
                                  @"nojsoncallback":@"1"
                                  };
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    [operationManager GET:kFlickrGetSizeURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * responseObjectRepresentation = (NSDictionary *)responseObject;
        NSDictionary * sizes = [responseObjectRepresentation objectForKey:@"sizes"];
        NSArray * sizesList = [sizes objectForKey:@"size"];
        NSDictionary * image = [sizesList lastObject];
        
        completion([image objectForKey:@"source"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@: Error: %@",[self class], error);
        
    }];
}

@end
