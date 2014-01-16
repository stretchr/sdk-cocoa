//
//  STRequestTest.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "STClient.h"
#import "STRequest.h"

@interface STRequestTest : XCTestCase

@end

@implementation STRequestTest

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

- (void)testInit
{
  STClient* client = [[STClient alloc] init];
  STRequest* request = [[STRequest alloc] initWithClient:client path:@"people"];
  XCTAssertNotNil(request);
  XCTAssertEqualObjects(request.client, client);
  XCTAssertEqualObjects(request.path, @"people");
}

@end
