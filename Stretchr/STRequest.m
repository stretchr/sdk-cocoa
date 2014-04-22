//
//  STRequest.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/4/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STRequest.h"
#import "STConstants.h"
#import "STNSString+STExtensions.h"
#import "STQuery.h"

@implementation STRequest

@synthesize account = _account;
@synthesize project = _project;
@synthesize key = _key;
@synthesize method = _method;
@synthesize path = _path;
@synthesize object = _object;

+ (id)requestWithProtocol:(NSString*)protocol
                     host:(NSString*)host
                  account:(NSString*)account
                  project:(NSString*)project
                      key:(NSString*)key
                   method:(NSString*)method
                     path:(NSString*)path {
  STRequest* request = [[STRequest alloc] init];
  request.protocol = protocol;
  request.host = host;
  request.account = account;
  request.project = project;
  request.key = key;
  request.method = method;
  request.path = path;
  return request;
}

- (NSString*)URLString {

  if (self.query == nil) {
    self.query = [STQuery query];
  }
  [self.query addInclude:STResourceConstants.Path];
  return [NSString stringWithFormat:@"%@://%@.%@/api/v%@/%@/%@?key=%@&%@",
                                    self.protocol, self.account, self.host,
                                    STDefaults.Version, self.project, self.path,
                                    self.key, [self.query URLParameters]];
}

@end
