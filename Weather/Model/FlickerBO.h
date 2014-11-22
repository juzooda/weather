//
//  FlickerBO.h
//  Weather
//
//  Created by Rafael Juzo G Oda on 11/15/14.
//  Copyright (c) 2014 Rafael Juzo Gomes Oda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface FlickerBO : NSObject

- (void)requestImageRepresentationFromCity:(NSString *)name withCompletionBlock:(void (^)(NSString * imageURL))completion;

@end
