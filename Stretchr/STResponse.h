//
//  STResponse.h
//  Stretchr
//
//  Created by Tyler Bunnell on 4/2/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STResponse;

typedef void (^STResponseBlock)(STResponse *response);
typedef void (^STFailureBlock)(int status, NSArray *errors);

@interface STResponse : NSObject

@end
