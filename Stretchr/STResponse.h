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
typedef void (^STFailureBlock)(STRequest* request, NSInteger status,
                               NSArray* errors);

/**
 *  STResponse is an object encapsulating the data from a Stretchr
 *  response object. All responses conform to this particular format, but
 *  not all fields will be populated. Stretchr returns only the fields
 *  that are important and/or requested.
 */
@interface STResponse : NSObject

/**
 *  The response body, decoded into either an NSArray* of NSDictionary* or an
 *  NSDicitonary*.
 */
@property(readonly, nonatomic) id data;

/**
 *  The array of errors returned by Stretchr. nil if there are no errors. Check
 *  the success method before looking at this property.
 */
@property(readonly, nonatomic) NSArray* errors;

/**
 *  The HTTP status of the request.
 */
@property(readonly, nonatomic) NSInteger status;

/**
 *  Creates a new STResponse object from the
 *  URL response and body received from Stretchr.
 *
 *  @param response The NSURLResponse object received from Stretchr.
 *  @param body     The body object in the response from Stretchr.
 *  @param error    Populated only if the body cannot be decoded.
 *
 *  @return An STResponse object ready for use. If the body cannot be decoded,
 *  this method returns nil and the error parameter is populated with the
 *reason.
 */
+ (id)responseWithURLResponse:(NSHTTPURLResponse*)response
                         body:(NSData*)body
                        error:(NSError* __autoreleasing*)error;

/**
 *  Creates a new STResponse object from the
 *  URL response and body received from Stretchr.
 *
 *  @param response The NSURLResponse object received from Stretchr.
 *  @param body     The body object in the response from Stretchr.
 *  @param error    Populated only if the body cannot be decoded.
 *
 *  @return An STResponse object ready for use.
 */
- (id)initWithURLResponse:(NSHTTPURLResponse*)response
                     body:(NSData*)body
                    error:(NSError* __autoreleasing*)error;

/**
 *  hasErrors returns YES if the response contains any errors.
 *
 *  @return YES if errors, else NO.
 */
- (BOOL)success;

// TODO: add additional convenience methods for introspecting the data?

@end
