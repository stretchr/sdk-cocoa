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

+ (id)sharedSDK {
  static Stretchr* sharedSDK;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{ sharedSDK = [[Stretchr alloc] init]; });
  return sharedSDK;
}

- (void)createResource:(id)object
                atPath:(NSString*)path
               success:(STResponseBlock)success
               failure:(STFailureBlock)failure {
  STRequest* request = [STRequest requestWithMethod:STHTTPMethods.Post
                                               path:path
                                           resource:object];
  dispatch_async(requestQueue, ^{
    NSError* error;
    STResponse* response = [STTransport executeRequest:request error:&error];
    if (error != nil || [response hasErrors]) {
      if (error != nil) {
        failure(0, @[ error ]);
      } else {
        failure([response statusCode], [response errors]);
      }
    } else {
      success(response);
    }
  });
}

- (void)readResourceAtPath:(NSString*)path
                   success:(STResourceBlock)success
                   failure:(STFailureBlock)failure {
  STRequest* request =
      [STRequest requestWithMethod:STHTTPMethods.Get path:path];

  dispatch_async(requestQueue, ^{
    NSError* error;
    STResponse* response = [STTransport executeRequest:request error:&error];
    if (error != nil || [response hasErrors]) {
      if (error != nil) {
        failure(0, @[ error ]);
      } else {
        failure([response statusCode], [response errors]);
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
  STRequest* request = [STRequest requestWithMethod:STHTTPMethods.Patch
                                               path:path
                                           resource:object];
  dispatch_async(requestQueue, ^{
    NSError* error;
    STResponse* response = [STTransport executeRequest:request error:&error];
    if (error != nil || [response hasErrors]) {
      if (error != nil) {
        failure(0, @[ error ]);
      } else {
        failure([response statusCode], [response errors]);
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
  STRequest* request =
      [STRequest requestWithMethod:STHTTPMethods.Put path:path resource:object];
  dispatch_async(requestQueue, ^{
    NSError* error;
    STResponse* response = [STTransport executeRequest:request error:&error];
    if (error != nil || [response hasErrors]) {
      if (error != nil) {
        failure(0, @[ error ]);
      } else {
        failure([response statusCode], [response errors]);
      }
    } else {
      success(response);
    }
  });
}

- (void)deleteResourceAtPath:(NSString*)path
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure {
  STRequest* request =
      [STRequest requestWithMethod:STHTTPMethods.Delete path:path];
  dispatch_async(requestQueue, ^{
    NSError* error;
    STResponse* response = [STTransport executeRequest:request error:&error];
    if (error != nil || [response hasErrors]) {
      if (error != nil) {
        failure(0, @[ error ]);
      } else {
        failure([response statusCode], [response errors]);
      }
    } else {
      success(response);
    }
  });
}

@end
