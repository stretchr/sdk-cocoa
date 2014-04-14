//
//  STConstants.h
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const STResourceKeyID;
extern NSString* const STErrorDomain;
extern const int STNoStatusCode;

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

extern const struct STResponseConstantsStruct {
  __unsafe_unretained NSString* Changes;
  __unsafe_unretained NSString* Created;
  __unsafe_unretained NSString* Updated;
  __unsafe_unretained NSString* Deleted;
  __unsafe_unretained NSString* Deltas;
  __unsafe_unretained NSString* Data;
  __unsafe_unretained NSString* Count;
  __unsafe_unretained NSString* Total;
  __unsafe_unretained NSString* Items;
} STResponseConstants;

extern const struct STQueryConstantsStruct {
  __unsafe_unretained NSString* FilterChar;
  __unsafe_unretained NSString* ListSeparatorChar;
  __unsafe_unretained NSString* NotChar;
  __unsafe_unretained NSString* BetweenChar;
  __unsafe_unretained NSString* ExistsChar;
  __unsafe_unretained NSString* GreaterThanChar;
  __unsafe_unretained NSString* LessThanChar;
  __unsafe_unretained NSString* GreaterThanOrEqualChar;
  __unsafe_unretained NSString* LessThanOrEqualChar;
} STQueryConstants;

extern const struct STErrorStringsStruct {
  __unsafe_unretained NSString* ObjectNotSerializable;
} STErrorStrings;

extern const struct STErrorCodesStruct {
  NSUInteger ObjectNotSerializable;
} STErrorCodes;