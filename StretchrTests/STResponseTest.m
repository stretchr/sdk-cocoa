//
//  STResponseTest.m
//  Stretchr
//
//  Created by Mat Ryer on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STResponse.h"
#import "STResource.h"
#import "STRequest.h"
#import "STClient.h"
#import "STChangeInfo.h"

@interface STResponseTest : XCTestCase
@property(readwrite,strong)STClient* client;
@property(readwrite,strong)STRequest* request;

@end

@implementation STResponseTest

- (void)setUp
{
  [super setUp];
  self.client = [[STClient alloc] initWithProject:@"project.company" APIKey:@"ABC123"];
  self.request = [[STRequest alloc] initWithClient:self.client path:@"people"];

}

- (void)tearDown
{
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

- (void)testInit
{
  STRequest* request = [[STRequest alloc] init];
  STResponse* response = [[STResponse alloc] initWithRequest:request];
  
  XCTAssertNotNil(response);
  XCTAssertEqualObjects(response.request, request);
}

- (void)testSuccess {
  
  STResponse *response = [[STResponse alloc] init];
  
  response.status = 100;
  XCTAssertTrue([response success]);

  response.status = 200;
  XCTAssertTrue([response success]);
  response.status = 201;
  XCTAssertTrue([response success]);

  response.status = 400;
  XCTAssertFalse([response success]);
  response.status = 404;
  XCTAssertFalse([response success]);
  response.status = 500;
  XCTAssertFalse([response success]);

}

- (void)testBodyDictionaryOrError
{
  STResponse* response = [[STResponse alloc] init];
  response.body = @"{\"name\":\"Tyler\",\"age\":29}";
  
  NSError *error = nil;
  NSDictionary* body = [response bodyDictionaryOrError:&error];
  
  XCTAssertNotNil(body);
  XCTAssertNil(error);
  XCTAssertEqualObjects(body[@"name"], @"Tyler");
  XCTAssertEqualObjects(body[@"age"], @29);
}

- (void)testResourceOrError
{
  STResponse* response = [[STResponse alloc] initWithRequest:self.request];
  response.body = @"{\"name\":\"Tyler\",\"age\":29}";
  
  NSError *error = nil;
  STResource* resource = [response resourceOrError:&error];
  
  XCTAssertNotNil(resource);
  XCTAssertNil(error);
  XCTAssertEqualObjects(resource.client, self.client);
  XCTAssertEqualObjects(resource.path, self.request.path);
  XCTAssertEqualObjects(resource.data[@"name"], @"Tyler");
  XCTAssertEqualObjects(resource.data[@"age"], @29);
}

- (void)testChangeInfoOrError
{
  
  STResponse* response = [[STResponse alloc] initWithRequest:nil];
  response.body = @"{\"~changes\":{\"~created\":12,\"~updated\":13,\"~deleted\":14,\"~deltas\":[{\"~id\":\"idone\",\"~created\":123},{\"~id\":\"idtwo\"}]},\"~status\":201}";
  
  NSError *error = nil;
  STChangeInfo *changeInfo = [response changeInfoOrError:&error];
  
  XCTAssertNil(error);
  
  XCTAssertEqual((NSUInteger)12, changeInfo.created);
  XCTAssertEqual((NSUInteger)13, changeInfo.updated);
  XCTAssertEqual((NSUInteger)14, changeInfo.deleted);
  XCTAssertEqualObjects(@"idone", changeInfo.deltas[0][@"~id"]);
  XCTAssertEqualObjects(@123, changeInfo.deltas[0][@"~created"]);
  XCTAssertEqualObjects(@"idtwo", changeInfo.deltas[1][@"~id"]);
  
}

@end
