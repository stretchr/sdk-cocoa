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
#import "TestObject.h"
#import "NSString+STExtensions.h"
#import "STTestTransport.h"
#import "STResponse.h"
#import "NSMutableArray+Queue.h"
#import "STConstants.h"
#import "STResource.h"

@interface STRequestTest : XCTestCase
@property(readwrite,strong)STClient* client;
@property(readwrite,strong)STRequest* request;
@property(readwrite,strong)STTestTransport* transport;
@end

@implementation STRequestTest

- (void)setUp
{
  [super setUp];
  self.client = [[STClient alloc] initWithProject:@"test.internal" APIKey:@"ABC123"];
  self.request = [[STRequest alloc] initWithClient:self.client path:@"people"];
  self.transport = [[STTestTransport alloc] init];
  self.client.transport = self.transport;
  
}

- (void)tearDown
{
  // Put teardown code here; it will be run once, after the last test case.
  [super tearDown];
}

- (void)testInit
{
  STClient* client = [[STClient alloc] initWithProject:@"test.internal" APIKey:@"ABC123"];
  STRequest* request = [[STRequest alloc] initWithClient:client path:@"people"];
  XCTAssertNotNil(request);
  XCTAssertEqualObjects(request.client, client);
  XCTAssertEqualObjects(request.path, @"people");
  XCTAssertEqualObjects(request.parameters[@"key"], @"ABC123");
  
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

- (void)testRequestURL
{
  STClient* client = [[STClient alloc] initWithProject:@"project.company" APIKey:@"ABC123"];
  STRequest* request = [[STRequest alloc] initWithClient:client path:@"people"];
  
  [request setValue:@"age" forParameter:@"order"];
  [request setValue:@"<=18" forFilter:@":upperAge"];
  [request setValue:@">10" forFilter:@"lowerAge"];
  
  NSString* url = [request URLString];
  
  XCTAssertTrue([url beginsWithString:@"https://project.company.stretchr.com/api/v1.1/people"]);
  XCTAssertTrue([url containsString:@"order=age"]);
  XCTAssertTrue([url containsString:@"%3AupperAge=%3C%3D18"]);
  XCTAssertTrue([url containsString:@"%3AlowerAge=%3E10"]);
}

- (void)testRead
{
  STRequest* request = [[STRequest alloc] initWithClient:[self client] path:@"people"];
  
  STResponse* fakeResponse = [[STResponse alloc] init];
  
  [self.transport.responses enqueue:fakeResponse];
  
  STResponse* response = [request readOrError:nil];
  
  XCTAssertNotNil(response);
  XCTAssertEqual([self.transport.requests count], (NSUInteger)1);
  XCTAssertEqualObjects(response, fakeResponse);
  XCTAssertTrue([NSString isNilOrEmpty:request.body], @"There should be no body");
  XCTAssertEqualObjects(STHTTPMethods.Get, request.HTTPMethod);
  
}

- (void)testDelete
{
  STRequest* request = [[STRequest alloc] initWithClient:[self client] path:@"people"];
  
  STResponse* fakeResponse = [[STResponse alloc] init];
  
  [self.transport.responses enqueue:fakeResponse];
  
  STResponse* response = [request deleteOrError:nil];
  
  XCTAssertNotNil(response);
  XCTAssertEqual([self.transport.requests count], (NSUInteger)1);
  XCTAssertEqualObjects(response, fakeResponse);
  XCTAssertTrue([NSString isNilOrEmpty:request.body], @"There should be no body");
  XCTAssertEqualObjects(STHTTPMethods.Delete, request.HTTPMethod);
  
}

- (void)testCreate
{
  STRequest* request = [[STRequest alloc] initWithClient:[self client] path:@"people"];
  STResponse* fakeResponse = [[STResponse alloc] init];
  STResource* resource = [[STResource alloc] initWithClient:self.client forPath:@"people"];
  
  [resource.data setObject:@"Mat" forKey:@"name"];
  [resource.data setObject:@31 forKey:@"age"];
  [resource.data setObject:@YES forKey:@"active"];

  [self.transport.responses enqueue:fakeResponse];
  
  STResponse* response = [request createResource:resource orError:nil];
  
  XCTAssertNotNil(response);
  XCTAssertEqual([self.transport.requests count], (NSUInteger)1);
  XCTAssertEqualObjects(response, fakeResponse);
  XCTAssertFalse([NSString isNilOrEmpty:request.body], @"There should be a body");
  NSLog(@"%@", request.body);
  XCTAssertEqualObjects(@"{\"name\":\"Mat\",\"age\":31,\"active\":true}", request.body);
  XCTAssertEqualObjects(STHTTPMethods.Post, request.HTTPMethod);
  
}

@end
