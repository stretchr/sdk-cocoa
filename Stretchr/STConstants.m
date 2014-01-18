//
//  STConstants.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STConstants.h"

NSString* const STResourceKeyID = @"~id";
NSString* const STErrorDomain = @"com.stretchr.error";

const struct STDefaultsStruct STDefaults = {
  .Protocol = @"https",
  .HostSuffix = @"stretchr.com",
  .Version = @"1.1"
};

const struct STHTTPMethodsStruct STHTTPMethods = {
  .Get = @"GET",
  .Put = @"PUT",
  .Delete = @"DELETE",
  .Post = @"POST",
  .Patch = @"PATCH"
};

const struct STChangeInfoConstantsStruct STChangeInfoConstants = {
  .Changes = @"~changes",
  .Created = @"~created",
  .Updated = @"~updated",
  .Deleted = @"~deleted",
  .Deltas = @"~deltas"
};

const struct STErrorStringsStruct  STErrorStrings = {
  .ObjectNotSerializable = @"Attempted to serialize an object to JSON that is not serializable."
};


// 100s - app level errors
// 200s - transport level errors

const struct STErrorCodesStruct STErrorCodes = {
  .ObjectNotSerializable = 100
};