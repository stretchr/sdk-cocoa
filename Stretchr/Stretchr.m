//
//  Stretchr.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/2/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "Stretchr.h"
#import "STRequest.h"

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
    sharedSDK = [[Stretchr alloc] init];
    sharedSDK.protocol = STDefaults.Protocol;
    sharedSDK.host = STDefaults.HostSuffix;
    sharedSDK.account = account;
    sharedSDK.project = project;
    sharedSDK.key = key;
  });
}

+ (id)sharedSDK {
  return sharedSDK;
}

- (void)createResource:(id)object
                atPath:(NSString*)path
               success:(STResponseBlock)success
               failure:(STFailureBlock)failure {
  STRequest* request = [STRequest requestWithProtocol:self.protocol
                                                 host:self.host
                                              account:self.account
                                              project:self.project
                                                  key:self.key
                                               method:STHTTPMethods.Post
                                                 path:path
                                               object:object];

  dispatch_async(requestQueue, ^{
    NSError* error;
    STResponse* response = [STTransport executeRequest:request error:&error];
    if (error != nil || [response hasErrors]) {
      if (error != nil) {
        failure(request, STNoStatusCode, @[ error ]);
      } else {
        failure(request, [response statusCode], [response errors]);
      }
    } else {
      success(response);
    }
  });
}

- (void)readResourceAtPath:(NSString*)path
                   success:(STResourceBlock)success
                   failure:(STFailureBlock)failure {
  STRequest* request = [STRequest requestWithProtocol:self.protocol
                                                 host:self.host
                                              account:self.account
                                              project:self.project
                                                  key:self.key
                                               method:STHTTPMethods.Get
                                                 path:path];

  dispatch_async(requestQueue, ^{
    NSError* error;
    STResponse* response = [STTransport executeRequest:request error:&error];
    if (error != nil || [response hasErrors]) {
      if (error != nil) {
        failure(request, STNoStatusCode, @[ error ]);
      } else {
        failure(request, [response statusCode], [response errors]);
      }
    } else {
      STResource* resource = [STResource resourceWithResponse:response];
      success(resource);
    }
  });
}

- (void)updateResourceAtPath:(NSString*)path
                withResource:(id)object
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure {
  STRequest* request = [STRequest requestWithProtocol:self.protocol
                                                 host:self.host
                                              account:self.account
                                              project:self.project
                                                  key:self.key
                                               method:STHTTPMethods.Patch
                                                 path:path
                                               object:object];
  dispatch_async(requestQueue, ^{
    NSError* error;
    STResponse* response = [STTransport executeRequest:request error:&error];
    if (error != nil || [response hasErrors]) {
      if (error != nil) {
        failure(request, STNoStatusCode, @[ error ]);
      } else {
        failure(request, [response statusCode], [response errors]);
      }
    } else {
      success(response);
    }
  });
}

- (void)replaceResourceAtPath:(NSString*)path
                 withResource:(id)object
                      success:(STResponseBlock)success
                      failure:(STFailureBlock)failure {
  STRequest* request = [STRequest requestWithProtocol:self.protocol
                                                 host:self.host
                                              account:self.account
                                              project:self.project
                                                  key:self.key
                                               method:STHTTPMethods.Put
                                                 path:path
                                               object:object];
  dispatch_async(requestQueue, ^{
    NSError* error;
    STResponse* response = [STTransport executeRequest:request error:&error];
    if (error != nil || [response hasErrors]) {
      if (error != nil) {
        failure(request, STNoStatusCode, @[ error ]);
      } else {
        failure(request, [response statusCode], [response errors]);
      }
    } else {
      success(response);
    }
  });
}

- (void)deleteResourceAtPath:(NSString*)path
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure {
  STRequest* request = [STRequest requestWithProtocol:self.protocol
                                                 host:self.host
                                              account:self.account
                                              project:self.project
                                                  key:self.key
                                               method:STHTTPMethods.Delete
                                                 path:path];
  dispatch_async(requestQueue, ^{
    NSError* error;
    STResponse* response = [STTransport executeRequest:request error:&error];
    if (error != nil || [response hasErrors]) {
      if (error != nil) {
        failure(request, STNoStatusCode, @[ error ]);
      } else {
        failure(request, [response statusCode], [response errors]);
      }
    } else {
      success(response);
    }
  });
}

@end
