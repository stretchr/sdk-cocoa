//
//  STConstants.h
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const struct STDefaultsStruct {
  __unsafe_unretained NSString* Protocol;
  __unsafe_unretained NSString* HostSuffix;
  __unsafe_unretained NSString* Version;
} STDefaults;

extern const struct STHTTPMethodsStruct {
  __unsafe_unretained NSString* Get;
  __unsafe_unretained NSString* Put;
  __unsafe_unretained NSString* Patch;
  __unsafe_unretained NSString* Delete;
  __unsafe_unretained NSString* Post;
} STHTTPMethods;