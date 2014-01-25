//
//  STClientTest.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "STClient.h"
#import "STRequest.h"
#import "STConstants.h"
#import "STWebTransport.h"
#import "STResource.h"

@interface STClientTest : XCTestCase
@property(readwrite,strong)STClient* client;
@end

@implementation STClientTest

- (void)setUp
{
  [super setUp];
  self.client = [[STClient alloc] initWithAccount:@"company" project:@"project" APIKey:@"ABC123"];
}

- (void)tearDown
{
  // Put teardown code here; it will be run once, after the last test case.
  [super tearDown];
}

- (void)testInit
{
  STClient* client = [[STClient alloc] initWithAccount:@"company" project:@"project" APIKey:@"ABC123"];
  XCTAssertNotNil(client);
  XCTAssertEqualObjects(@"project", client.project);
  XCTAssertEqualObjects(@"company", client.account);
  XCTAssertEqualObjects(@"ABC123", client.APIKey);
  
  // Test defaults
  XCTAssertEqualObjects(client.host, @"company.stretchr.com");
  XCTAssertEqualObjects(client.protocol, STDefaults.Protocol);
  
  // make sure a real web transport was created 
  XCTAssertNotNil(client.transport);
  XCTAssertEqual([STWebTransport class], [client.transport class]);
}

- (void)testMakeRequest
{
  STRequest *request = [self.client requestAt:@"people/tyler"];
  XCTAssertNotNil(request);
  XCTAssertEqualObjects(request.client, self.client);
  XCTAssertEqualObjects(request.path, @"people/tyler");
}

- (void)testBaseURL
{
  STClient* client = [[STClient alloc] initWithAccount:@"company" project:@"project" APIKey:@"ABC123"];
  NSString* url = [client baseURLString];
  XCTAssertEqualObjects(@"https://company.stretchr.com/api/v1.1/project/", url);
}

- (void)testResourceWithPath
{
  STResource* res = [self.client newResourceWithPath:@"people/tyler/books"];
  XCTAssertNotNil(res);
  XCTAssertEqualObjects(res.path, @"people/tyler/books");
  XCTAssertEqualObjects(res.client, self.client);
}



@end
