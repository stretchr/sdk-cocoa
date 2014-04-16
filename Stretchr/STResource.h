//
//  STResource.h
//  Stretchr
//
//  Created by Tyler Bunnell on 4/2/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STResource;
@class STResponse;
@class STRequest;

/**
 *  STResourceBlock defines the block signature for the block
 *  that will be called when a resource response is received
 *  from Stretchr
 *
 *  @param request The original STRequest object used to make the request.
 *  @param resource The STResource object from the response returned by
 *  Stretchr.
 */
typedef void (^STResourceBlock)(STRequest* request, STResource* resource);

/**
 *  STResource contains the resource data encapsulated in a Stretchr
 *  response object. This data is extracted from an STResponse object
 *  and the original STResponse object is contained within this object
 *  for deeper inspection of the response if desired.
 */
@interface STResource : NSObject

/**
 *  The Stretchr ID of the resource.
 */
@property(readonly, nonatomic) NSString* ID;

/**
 *  The path to the resource inside Stretchr.
 */
@property(readonly, nonatomic) NSString* path;

/**
 *  The data contained within the resource.
 */
@property(readonly, nonatomic) NSDictionary* data;

/**
 *  Creates a new STResource object out of the given STResponse object.
 *
 *  @param response The response object from which to create the STResource.
 *
 *  @return The built STResource object.
 */
+ (id)resourceWithResponse:(STResponse*)response;

/**
 *  Creates a new STResource object out of the given STResponse object.
 *
 *  @param response The response object from which to create the STResource.
 *
 *  @return The built STResource object.
 */
- (id)initWithResponse:(STResponse*)response;

@end
