//
//  STRequest.h
//  Stretchr
//
//  Created by Tyler Bunnell on 4/4/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STQuery;

/**
 *  STRequest is used to build a request that will be sent to Stretchr.
 */
@interface STRequest : NSObject

/**
 *  The protocol to use for this request. Default https. Can be http.
 */
@property(readwrite, nonatomic, copy) NSString* protocol;

/**
 *  The host on which Stretchr is running. Default stretchr.com.
 */
@property(readwrite, nonatomic, copy) NSString* host;

/**
 *  The account for this request.
 */
@property(readwrite, nonatomic, copy) NSString* account;

/**
 *  The project for this request.
 */
@property(readwrite, nonatomic, copy) NSString* project;

/**
 *  The key for this request.
 */
@property(readwrite, nonatomic, copy) NSString* key;

/**
 *  The HTTP method for this request.
 */
@property(readwrite, nonatomic, copy) NSString* method;

/**
 *  The path on Stretchr at which the data is located.
 */
@property(readwrite, nonatomic, copy) NSString* path;

/**
 *  The data object to be included with the request.
 *
 *  This object will be copied internally and must implement
 *  copyWithZone:.
 */
@property(readwrite, nonatomic, copy) id object;

/**
 *  The query object to use when making the request.
 */
@property(readwrite, nonatomic, copy) STQuery* query;

/**
 *  Creates a new request object which can then be used to execute a request
 *  to Stretchr.
 *
 *  @param protocol The HTTP protocol to use (http/https)
 *  @param host    The host on which Stretchr is running (default stretchr.com)
 *  @param account The account for this request.
 *  @param project The project for this request.
 *  @param key     The key for this request.
 *  @param method  The HTTP method to use.
 *  @param path    The path to the endpoint on Stretchr.
 *
 *  @return The initialized STRequest object.
 */
+ (id)requestWithProtocol:(NSString*)protocol
                     host:(NSString*)host
                  account:(NSString*)account
                  project:(NSString*)project
                      key:(NSString*)key
                   method:(NSString*)method
                     path:(NSString*)path;

/**
 *  URLString returns the URL as a string for this request. The URL
 *  is constructed from all the various parameters and options
 *  present in the request object.
 *
 *  @return The complete URL as a string.
 */
- (NSString*)URLString;

@end
