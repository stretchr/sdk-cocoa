//
//  STCollection.h
//  Stretchr
//
//  Created by Tyler Bunnell on 4/17/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STCollection;
@class STResponse;
@class STRequest;

/**
 *  STCollectionBlock defines the block signature for the block
 *  that will be called when a collection response is received
 *  from Stretchr
 *
 *  @param request The original STRequest object used to make the request.
 *  @param resource The STCollection object from the response returned by
 *  Stretchr.
 */
typedef void (^STCollectionBlock)(STRequest* request, STCollection* resource);

@interface STCollection : NSObject

/**
 *  Creates a new STCollection object out of the given STResponse object.
 *
 *  @param response The response received from Stretchr.
 *
 *  @return The builts STCollection* object.
 */
+ (id)collectionWithResponse:(STResponse*)response;

/**
 *  Creates a new STCollection object out of the given STResponse object.
 *
 *  @param response The response received from Stretchr.
 *
 *  @return The builts STCollection* object.
 */
- (id)initWithResponse:(STResponse*)response;

@end
