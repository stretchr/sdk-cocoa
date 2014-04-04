//
//  STTransport.h
//  Stretchr
//
//  Created by Tyler Bunnell on 4/4/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STResponse;
@class STRequest;

/**
 *  STTransport is responsible for issuing requests to Stretchr
 *  and receiving the responses. It constructs the appropriate
 *  objects that are then sent to the various callbacks.
 */
@interface STTransport : NSObject

+ (STResponse*)executeRequest:(STRequest*)request error:(NSError**)error;

@end
