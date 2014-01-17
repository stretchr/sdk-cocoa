//
//  STResourceTest.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/17/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STResource.h"
#import "STClient.h"
#import "STTestTransport.h"
#import "STRequest.h"
#import "STResponse.h"
#import "NSMutableArray+Queue.h"

@interface STResourceTest : XCTestCase

@end

@implementation STResourceTest

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
  STClient* client = [[STClient alloc] initWithProject:@"abc123" APIKey:@"def456"];
  STResource* res = [[STResource alloc] initWithClient:client forPath:@"people/1/books"];
  XCTAssertNotNil(res);
  XCTAssertEqualObjects(res.path, @"people/1/books");
  XCTAssertEqualObjects(res.client, client);
}

/*
- (void)testSaveNewResource
{
  STTestTransport* transport = [[STTestTransport alloc] init];
  STClient* client = [[STClient alloc] initWithProject:@"abc123" APIKey:@"def456"];
  client.transport = transport;
  
  STRequest* request = [[STRequest alloc] initWithClient:client path:@"people"];
  STResponse* fakeResponse = [[STResponse alloc] initWithRequest:request];
  fakeResponse.status = 200;
  fakeResponse.body = @""body": "{\"~changes\":{\"~created\":1,\"~deltas\":[{\"~id\":\"IDINURL\"}]},\"~status\":201}";
  
  [transport.responses enqueue:fakeResponse];
  
  STResource *resource = [client newResourceWithPath:@"people"];
  [resource.data setObject:@"Tyler" forKey:@"name"];
  
  STResponse* response = [request save];
  
  XCTAssertNotNil(response);
  XCTAssertEqualObjects(resource.data[@"~id"], @"new-id");
  
}
*/

@end
