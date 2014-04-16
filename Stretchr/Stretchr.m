//
//  Stretchr.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/2/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "Stretchr.h"

dispatch_queue_t requestQueue = NULL;

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
  if (!(self = [super init])) return nil;

  self.protocol = STDefaults.Protocol;
  self.host = STDefaults.HostSuffix;
  self.account = account;
  self.project = project;
  self.key = key;

  return self;
}

- (void)createResourceAtPath:(NSString*)path
                  withObject:(id)object
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure
                    userInfo:(NSDictionary*)userInfo {
  STRequest* request = [STRequest requestWithProtocol:self.protocol
                                                 host:self.host
                                              account:self.account
                                              project:self.project
                                                  key:self.key
                                               method:STHTTPMethods.Post
                                                 path:path];
  request.object = object;
  request.userInfo = userInfo;

  [self executeRequest:request
               success:success
               failure:failure
              userInfo:userInfo];
}

- (void)readResourceAtPath:(NSString*)path
                   success:(STResourceBlock)success
                   failure:(STFailureBlock)failure
                  userInfo:(NSDictionary*)userInfo {
  STRequest* request = [STRequest requestWithProtocol:self.protocol
                                                 host:self.host
                                              account:self.account
                                              project:self.project
                                                  key:self.key
                                               method:STHTTPMethods.Get
                                                 path:path];
  request.userInfo = userInfo;

  STResponseBlock successResponse =
      ^(STRequest * requestObject, STResponse * response) {
    success(requestObject, [STResource resourceWithResponse:response]);
  };

  [self executeRequest:request
               success:successResponse
               failure:failure
              userInfo:userInfo];
}

- (void)updateResourceAtPath:(NSString*)path
                  withObject:(id)object
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure
                    userInfo:(NSDictionary*)userInfo {
  STRequest* request = [STRequest requestWithProtocol:self.protocol
                                                 host:self.host
                                              account:self.account
                                              project:self.project
                                                  key:self.key
                                               method:STHTTPMethods.Patch
                                                 path:path];
  request.object = object;
  request.userInfo = userInfo;

  [self executeRequest:request
               success:success
               failure:failure
              userInfo:userInfo];
}

- (void)replaceResourceAtPath:(NSString*)path
                   withObject:(id)object
                      success:(STResponseBlock)success
                      failure:(STFailureBlock)failure
                     userInfo:(NSDictionary*)userInfo {
  STRequest* request = [STRequest requestWithProtocol:self.protocol
                                                 host:self.host
                                              account:self.account
                                              project:self.project
                                                  key:self.key
                                               method:STHTTPMethods.Put
                                                 path:path];

  request.object = object;
  request.userInfo = userInfo;

  [self executeRequest:request
               success:success
               failure:failure
              userInfo:userInfo];
}

- (void)deleteResourceAtPath:(NSString*)path
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure
                    userInfo:(NSDictionary*)userInfo {
  STRequest* request = [STRequest requestWithProtocol:self.protocol
                                                 host:self.host
                                              account:self.account
                                              project:self.project
                                                  key:self.key
                                               method:STHTTPMethods.Delete
                                                 path:path];
  request.userInfo = userInfo;
  [self executeRequest:request
               success:success
               failure:failure
              userInfo:userInfo];
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
