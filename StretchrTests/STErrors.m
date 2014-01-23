//
//  STErrors.m
//  Stretchr
//
//  Created by Mat Ryer on 1/22/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STErrors.h"

@interface STErrors : XCTestCase

@end

@implementation STErrors

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testSTIsError
{

  NSError *error = nil;
  XCTAssertFalse(STIsError(&error));
  XCTAssertFalse(STIsError(nil));
  
  error = [NSError errorWithDomain:@"ohai" code:0 userInfo:nil];
  
  XCTAssertTrue(STIsError(&error));
  
}

@end
