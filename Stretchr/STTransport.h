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
 *
 *  This method performs a synchronous request, waiting for a response before
 *  returning to the caller. This method, at a higher level, is wrapped in an
 *  asynchronous dispatch block, thus it will not block the main thread.
 */
@interface STTransport : NSObject

+ (STResponse*)executeRequest:(STRequest*)request error:(NSError**)error;

@end
