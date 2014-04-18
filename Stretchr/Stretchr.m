//
//  Stretchr.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/2/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "Stretchr.h"

#import "STNSString+STExtensions.h"

dispatch_queue_t requestQueue = NULL;

@interface Stretchr ()
/**
 *  Constructs an STRequest object to be executed.
 *
 *  @param method   The HTTP method for the request.
 *  @param path     The path for the request.
 *  @param object   The object for the request.
 *  @param query    The query to include with the request or nil.
 *  @param userInfo The userInfo object for the request.
 */
- (STRequest*)constructRequestWithMethod:(NSString*)method
                                    path:(NSString*)path
                                  object:(id)object
                                   query:(STQuery*)query
                                userInfo:(NSDictionary*)userInfo;
@end

@implementation Stretchr

@synthesize protocol = _protocol;
@synthesize host = _host;
@synthesize account = _account;
@synthesize project = _project;
@synthesize key = _key;

+ (void)initialize {
  if (self == [Stretchr class]) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      requestQueue =
          dispatch_queue_create("requestQueue", DISPATCH_QUEUE_SERIAL);
    });
  }
}

static Stretchr* sharedSDK;

+ (void)initializeSharedSDKWithAccount:(NSString*)account
                               project:(NSString*)project
                                   key:(NSString*)key {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedSDK =
        [[Stretchr alloc] initWithAccount:account project:project key:key];
  });
}

+ (id)sharedSDK {
  return sharedSDK;
}

- (id)initWithAccount:(NSString*)account
              project:(NSString*)project
                  key:(NSString*)key {
  if (!(self = [super init])) {
    return nil;
  }

  self.protocol = STDefaults.Protocol;
  self.host = STDefaults.HostSuffix;
  self.account = account;
  self.project = project;
  self.key = key;

  return self;
}

- (void)createResourceAtPath:(NSString*)path
                  withObject:(id)object
                       query:(STQuery*)query
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure
                    userInfo:(NSDictionary*)userInfo {
  [self executeRequest:[self constructRequestWithMethod:STHTTPMethods.Post
                                                   path:path
                                                 object:object
                                                  query:query
                                               userInfo:userInfo]
               success:success
               failure:failure
              userInfo:userInfo];
}

- (void)readResourceAtPath:(NSString*)path
                     query:(STQuery*)query
                   success:(STResourceBlock)success
                   failure:(STFailureBlock)failure
                  userInfo:(NSDictionary*)userInfo {

  STResponseBlock successResponse =
      ^(STRequest * requestObject, STResponse * response) {
    success(requestObject, [STResource resourceWithData:response.data]);
  };

  [self executeRequest:[self constructRequestWithMethod:STHTTPMethods.Get
                                                   path:path
                                                 object:nil
                                                  query:query
                                               userInfo:userInfo]
               success:successResponse
               failure:failure
              userInfo:userInfo];
}

- (void)updateResourceAtPath:(NSString*)path
                  withObject:(id)object
                       query:(STQuery*)query
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure
                    userInfo:(NSDictionary*)userInfo {
  [self executeRequest:[self constructRequestWithMethod:STHTTPMethods.Patch
                                                   path:path
                                                 object:object
                                                  query:query
                                               userInfo:userInfo]
               success:success
               failure:failure
              userInfo:userInfo];
}

- (void)replaceResourceAtPath:(NSString*)path
                   withObject:(id)object
                        query:(STQuery*)query
                      success:(STResponseBlock)success
                      failure:(STFailureBlock)failure
                     userInfo:(NSDictionary*)userInfo {
  [self executeRequest:[self constructRequestWithMethod:STHTTPMethods.Put
                                                   path:path
                                                 object:object
                                                  query:query
                                               userInfo:userInfo]
               success:success
               failure:failure
              userInfo:userInfo];
}

- (void)deleteResourceAtPath:(NSString*)path
                       query:(STQuery*)query
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure
                    userInfo:(NSDictionary*)userInfo {
  [self executeRequest:[self constructRequestWithMethod:STHTTPMethods.Delete
                                                   path:path
                                                 object:nil
                                                  query:query
                                               userInfo:userInfo]
               success:success
               failure:failure
              userInfo:userInfo];
}

- (void)createCollectionAtPath:(NSString*)path
                   withObjects:(NSArray*)objects
                         query:(STQuery*)query
                       success:(STResponseBlock)success
                       failure:(STFailureBlock)failure
                      userInfo:(NSDictionary*)userInfo {
  [self executeRequest:[self constructRequestWithMethod:STHTTPMethods.Post
                                                   path:path
                                                 object:objects
                                                  query:query
                                               userInfo:userInfo]
               success:success
               failure:failure
              userInfo:userInfo];
}

- (void)readCollectionAtPath:(NSString*)path
                       query:(STQuery*)query
                     success:(STCollectionBlock)success
                     failure:(STFailureBlock)failure
                    userInfo:(NSDictionary*)userInfo {
  STResponseBlock successResponse =
      ^(STRequest * requestObject, STResponse * response) {
    success(requestObject, [STCollection collectionWithData:response.data]);
  };

  [self executeRequest:[self constructRequestWithMethod:STHTTPMethods.Get
                                                   path:path
                                                 object:nil
                                                  query:query
                                               userInfo:userInfo]
               success:successResponse
               failure:failure
              userInfo:userInfo];
}

- (void)deleteCollectionAtPath:(NSString*)path
                         query:(STQuery*)query
                       success:(STResponseBlock)success
                       failure:(STFailureBlock)failure
                      userInfo:(NSDictionary*)userInfo {

  [self executeRequest:[self constructRequestWithMethod:STHTTPMethods.Delete
                                                   path:path
                                                 object:nil
                                                  query:query
                                               userInfo:userInfo]
               success:success
               failure:failure
              userInfo:userInfo];
}

- (STRequest*)constructRequestWithMethod:(NSString*)method
                                    path:(NSString*)path
                                  object:(id)object
                                   query:(STQuery*)query
                                userInfo:(NSDictionary*)userInfo {
  STRequest* request = [STRequest requestWithProtocol:self.protocol
                                                 host:self.host
                                              account:self.account
                                              project:self.project
                                                  key:self.key
                                               method:method
                                                 path:[path cleanPath]];
  request.userInfo = userInfo;
  request.object = object;
  request.query = query;

  return request;
}

- (void)executeRequest:(STRequest*)request
               success:(STResponseBlock)success
               failure:(STFailureBlock)failure
              userInfo:(NSDictionary*)userInfo {
  dispatch_async(requestQueue, ^{
    NSError* error;
    STResponse* response = [STTransport executeRequest:request error:&error];
    if (error != nil || !response.success) {
      if (error != nil) {
        failure(request, STNoStatusCode, @[ error ]);
      } else {
        failure(request, response.status, response.errors);
      }
    } else {
      success(request, response);
    }
  });
}

@end
