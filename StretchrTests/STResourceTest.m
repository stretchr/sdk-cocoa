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
#import "STConstants.h"
#import "TestObject.h"

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
  STClient* client = [[STClient alloc] initWithAccount:@"company" project:@"abc123" APIKey:@"def456"];
  STResource* res = [[STResource alloc] initWithClient:client forPath:@"people/1/books"];
  XCTAssertNotNil(res);
  XCTAssertEqualObjects(res.path, @"people/1/books");
  XCTAssertEqualObjects(res.client, client);
}

- (void)testHasId
{

  STResource *resource = [[STResource alloc] initWithClient:nil forPath:@"path"];
  
  XCTAssertFalse([resource hasId], @"hasId should be false");
  
  // set an ID
  resource.data[@"~id"] = @"abc123";
  
  XCTAssertTrue([resource hasId], @"hasId should be true");

}

- (void)testSaveNewResource
{
  STTestTransport* transport = [[STTestTransport alloc] init];
  STClient* client = [[STClient alloc] initWithAccount:@"company" project:@"abc123" APIKey:@"def456"];
  client.transport = transport;
  
  STRequest* request = [[STRequest alloc] initWithClient:client path:@"people"];
  STResponse* fakeResponse = [[STResponse alloc] initWithRequest:request];
  fakeResponse.status = 200;
  fakeResponse.body = @"{\"~changes\":{\"~created\":1,\"~deltas\":[{\"~id\":\"new-id\",\"something\":\"else\"}]},\"~status\":201}";
  
  [transport.responses enqueue:fakeResponse];
  
  STResource *resource = [client newResourceWithPath:@"people"];
  [resource.data setObject:@"Tyler" forKey:@"name"];
  
  NSError *error = nil;
  STResponse* response = [resource saveOrError:&error];
  
  XCTAssertNotNil(response);
  XCTAssertNil(error);
  XCTAssertEqualObjects(resource.data[STResourceKeyID], @"new-id", @"Saving a resource should include the details in the change info in the resource");
  XCTAssertEqualObjects(resource.data[@"something"], @"else");
  
  request = transport.requests[0];
  XCTAssertEqualObjects(request.path, @"people");
  XCTAssertEqualObjects(request.HTTPMethod, STHTTPMethods.Post);
  XCTAssertEqualObjects(request.body, @"{\"name\":\"Tyler\"}");
  
}

- (void)testSaveNewJSONModelResource
{
  STTestTransport* transport = [[STTestTransport alloc] init];
  STClient* client = [[STClient alloc] initWithAccount:@"company" project:@"abc123" APIKey:@"def456"];
  client.transport = transport;
  
  STRequest* request = [[STRequest alloc] initWithClient:client path:@"people"];
  STResponse* fakeResponse = [[STResponse alloc] initWithRequest:request];
  fakeResponse.status = 200;
  fakeResponse.body = @"{\"~changes\":{\"~created\":1,\"~deltas\":[{\"~id\":\"new-id\",\"something\":\"else\"}]},\"~status\":201}";
  
  [transport.responses enqueue:fakeResponse];
  
  STResource *resource = [client newResourceWithPath:@"people"];
  TestObject* to = [[TestObject alloc] init];
  to.name = @"Tyler";
  to.age = 29;
  [resource setDataFromObject:to];
  
  NSError *error;
  STResponse* response = [resource saveOrError:&error];
  
  XCTAssertNotNil(response);
  XCTAssertFalse(STIsError(&error));
  XCTAssertEqualObjects(resource.data[STResourceKeyID], @"new-id", @"Saving a resource should include the details in the change info in the resource");
  XCTAssertEqualObjects(resource.data[@"something"], @"else");
  
  request = [transport.requests objectAtIndex:0];
  XCTAssertEqualObjects(request.path, @"people");
  XCTAssertEqualObjects(request.HTTPMethod, STHTTPMethods.Post);
  XCTAssertEqualObjects(request.body, @"{\"name\":\"Tyler\",\"age\":29}");
  
}

- (void)testUpdateExistingResource
{
  STTestTransport* transport = [[STTestTransport alloc] init];
  STClient* client = [[STClient alloc] initWithAccount:@"company" project:@"abc123" APIKey:@"def456"];
  client.transport = transport;
  
  STRequest* request = [[STRequest alloc] initWithClient:client path:@"people"];
  STResponse* fakeResponse = [[STResponse alloc] initWithRequest:request];
  fakeResponse.status = 200;
  fakeResponse.body = @"{\"~changes\":{\"~updated\":1,\"~deltas\":[{\"~id\":\"new-id\",\"something\":\"else\"}]},\"~status\":201}";
  
  [transport.responses enqueue:fakeResponse];
  
  STResource *resource = [client newResourceWithPath:@"people"];
  [resource.data setObject:@"Tyler" forKey:@"name"];
  [resource.data setObject:@"ABC123" forKey:STResourceKeyID];
  
  NSError *error = nil;
  STResponse* response = [resource saveOrError:&error];
  
  XCTAssertNotNil(response);
  XCTAssertNil(error);
  XCTAssertEqualObjects(resource.data[STResourceKeyID], @"new-id", @"Saving a resource should include the details in the change info in the resource");
  XCTAssertEqualObjects(resource.data[@"something"], @"else");
  
  request = transport.requests[0];
  XCTAssertEqualObjects(request.path, @"people/ABC123");
  XCTAssertEqualObjects(request.HTTPMethod, STHTTPMethods.Put);
  XCTAssertEqualObjects(request.body, @"{\"name\":\"Tyler\",\"~id\":\"ABC123\"}");
  
}

@end
