//
//  STResponse.h
//  Stretchr
//
//  Created by Tyler Bunnell on 4/2/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STResponse;
@class STRequest;

/**
 *  STResponseBlock defines the block signature that will be called
 *  when a response is received from Stretchr
 *
 *  @param request The original STRequest object used to make the request.
 *  @param response The STResponse object containing response data.
 */
typedef void (^STResponseBlock)(STRequest* request, STResponse* response);

/**
 *  STFailureBlock defines the block signature that will be called
 *  when a request to Stretchr fails.
 *
 *  @param request The original STRequest object used to make the request.
 *  @param status The HTTP status code received.
 *  @param errors The errors received from Stretchr, or transport level errors.
 */
typedef void (^STFailureBlock)(STRequest* request, int status, NSArray* errors);

/**
 *  STResponse is an object encapsulating the data from a Stretchr
 *  response object. All responses conform to this particular format, but
 *  not all fields will be populated. Stretchr returns only the fields
 *  that are important and/or requested.
 */
@interface STResponse : NSObject

/**
 *  responseWithURLResponse:body creates a new STResponse object from the
 *  URL response and body received from Stretchr.
 *
 *  @param response The NSURLResponse object received from Stretchr.
 *  @param body     The body object in the response from Stretchr.
 *
 *  @return An STResponse object ready for use.
 */
+ (id)responseWithURLResponse:(NSURLResponse*)response body:(NSData*)body;

/**
 *  hasErrors returns YES if the response contains any errors.
 *
 *  @return YES if errors, else NO.
 */
- (BOOL)hasErrors;

/**
 *  errors returns the array of errors contained in the response.
 *
 *  @return The array of errors in the response, or nil if none.
 */
- (NSArray*)errors;

/**
 *  statusCode retrieves the status code of the response
 *
 *  @return The response status code.
 */
- (int)statusCode;

@end
