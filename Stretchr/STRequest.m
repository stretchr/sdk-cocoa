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

NSString* cleanPath(NSString* path) {
  if ([path beginsWithString:@"/"]) {
    return [path substringFromIndex:1];
  }
  return path;
}

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
  return [STRequest requestWithProtocol:protocol
                                   host:host
                                account:account
                                project:project
                                    key:key
                                 method:method
                                   path:path
                                 object:nil];
}
+ (id)requestWithProtocol:(NSString*)protocol
                     host:(NSString*)host
                  account:(NSString*)account
                  project:(NSString*)project
                      key:(NSString*)key
                   method:(NSString*)method
                     path:(NSString*)path
                   object:(id)object {
  STRequest* request = [[STRequest alloc] init];
  request.protocol = protocol;
  request.host = host;
  request.account = account;
  request.project = project;
  request.key = key;
  request.method = method;
  request.path = cleanPath(path);
  if (object) {
    [request setObject:object];
  }
  return request;
}

- (NSString*)URLString {

  if (self.query != nil) {
    return
        [NSString stringWithFormat:@"%@://%@.%@/api/v%@/%@/%@?key=%@&%@",
                                   self.protocol, self.account, self.host,
                                   STDefaults.Version, self.project, self.path,
                                   self.key, [self.query URLParameters]];
  }
  return [NSString stringWithFormat:@"%@://%@.%@/api/v%@/%@/%@?key=%@",
                                    self.protocol, self.account, self.host,
                                    STDefaults.Version, self.project, self.path,
                                    self.key];
}

@end
