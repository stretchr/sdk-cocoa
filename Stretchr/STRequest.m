//
//  STRequest.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/4/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STRequest.h"

@implementation STRequest

+ (id)requestWithMethod:(NSString*)method path:(NSString*)path {
  return [STRequest requestWithMethod:method path:path resource:nil];
}

+ (id)requestWithMethod:(NSString*)method
                   path:(NSString*)path
               resource:(id)object {
  return nil;
}

@end
