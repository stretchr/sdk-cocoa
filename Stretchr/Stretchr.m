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

+ (void)initialize {
  if (self == [Stretchr class]) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      requestQueue =
          dispatch_queue_create("requestQueue", DISPATCH_QUEUE_SERIAL);
    });
  }
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
}

- (void)replaceResourceAtPath:(NSString*)path
                 withResource:(id)object
                      success:(STResponseBlock)success
                      failure:(STFailureBlock)failure {
}

- (void)deleteResourceAtPath:(NSString*)path
                     success:(STResponseBlock)success
                     failure:(STFailureBlock)failure {
}

@end
