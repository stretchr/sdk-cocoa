//
//  STConstants.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STConstants.h"

NSString *const STResourceKeyID = @"~id";
NSString *const STErrorDomain = @"com.stretchr.error";
const int STNoStatusCode = -1;

const struct STDefaultsStruct STDefaults = {.Protocol = @"https",
                                            .HostSuffix = @"stretchr.com",
                                            .Version = @"1.1",
                                            .ResourceLimit = 100};

const struct STHTTPMethodsStruct STHTTPMethods = {.Get = @"GET",
                                                  .Put = @"PUT",
                                                  .Delete = @"DELETE",
                                                  .Post = @"POST",
                                                  .Patch = @"PATCH"};

const struct STResponseConstantsStruct STResponseConstants = {
    .Changes = @"~changes",
    .Created = @"~created",
    .Updated = @"~updated",
    .Deleted = @"~deleted",
    .Deltas = @"~deltas",
    .Data = @"~data",
    .Count = @"~count",
    .Total = @"~total",
    .Items = @"~items"};

const struct STQueryConstantsStruct STQueryConstants = {
    .FilterChar = @":",
    .ListSeparatorChar = @",",
    .NotChar = @"!",
    .BetweenChar = @"..",
    .ExistsChar = @"*",
    .GreaterThanChar = @">",
    .LessThanChar = @"<",
    .GreaterThanOrEqualChar = @">=",
    .LessThanOrEqualChar = @"<=",
    .NegateChar = @"-",
    .Limit = @"limit",
    .Skip = @"skip",
    .Order = @"order",
    .Aggregate = @"agg"};

const struct STAggregationConstantsStruct STAggregationConstants = {
    .Sum = @"sum",
    .Max = @"max",
    .Min = @"min",
    .Average = @"avg",
    .UniqueSet = @"uniqueSet",
    .Count = @"count",
    .Group = @"group",
    .Unwind = @"unwind"};

const struct STErrorStringsStruct STErrorStrings = {
    .ObjectNotSerializable =
        @"Attempted to serialize an object to JSON that is not serializable."};

// 100s - app level errors
// 200s - transport level errors

const struct STErrorCodesStruct STErrorCodes = {.ObjectNotSerializable = 100};
