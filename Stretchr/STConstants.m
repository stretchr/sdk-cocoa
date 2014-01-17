//
//  STConstants.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STConstants.h"

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