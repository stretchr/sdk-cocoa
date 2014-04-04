//
//  STRequest.h
//  Stretchr
//
//  Created by Tyler Bunnell on 4/4/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  STRequest is used to build a request that will be sent to Stretchr.
 */
@interface STRequest : NSObject

/**
 *  requestWithMethod creates a new request object which can then be used
 *  to execute the request to Stretchr.
 *
 *  @param method The HTTP method to use.
 *  @param path   The path to the endpoint on Stretchr.
 *
 *  @return The initialized STRequest object.
 */
+ (id)requestWithMethod:(NSString*)method path:(NSString*)path;

/**
 *  requestWithMethod creates a new request object which can then be used
 *  to execute the request to Stretchr. It includes the object to be
 *  serialized and sent in the body.
 *
 *  @param method The HTTP method to use.
 *  @param path   The path to the endpoint on Stretchr.
 *  @param object The object to serialize and send in the request.
 *
 *  @return The initialized STRequest object.
 */
+ (id)requestWithMethod:(NSString*)method
                   path:(NSString*)path
               resource:(id)object;

@end
