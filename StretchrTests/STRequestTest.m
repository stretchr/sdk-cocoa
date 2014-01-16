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
@property(readwrite,strong)STClient* client;
@property(readwrite,strong)STRequest* request;
@end

@implementation STRequestTest

- (void)setUp
{
  [super setUp];
  self.client = [[STClient alloc] init];
  self.request = [[STRequest alloc] initWithClient:self.client path:@"people"];
  
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
  XCTAssertNotNil(request.parameters);
  XCTAssertNotNil(request.filters);
}

- (void)testSetParams
{
  [self.request setValue:@"age" forParameter:@"order"];
  XCTAssertEqualObjects(@"age", self.request.parameters[@"order"]);
}

- (void)testSetFilters
{
  [self.request setValue:@"18" forFilter:@":upperAge"];
  [self.request setValue:@"10" forFilter:@"lowerAge"];
  
  XCTAssertEqualObjects(@"18", self.request.filters[@":upperAge"]);
  XCTAssertEqualObjects(@"10", self.request.filters[@":lowerAge"]);
}

/*
 
 request.where("age>=18").where("active=true")
 
 A: [request where:@"age" is:">18"];
 B: [request addFilter:@":age=>18"];
 
 
 [request addFilters:@[@"blah",@"blah2"]]
 
 */

@end
