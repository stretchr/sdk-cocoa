//
//  STWebTransportTest.m
//  Stretchr
//
//  Created by Mat Ryer on 1/19/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STWebTransport.h"
#import "STRequest.h"
#import "STClient.h"
#import "STResponse.h"
#import "STConstants.h"

@interface STWebTransportTest : XCTestCase

@end

@implementation STWebTransportTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMakeRequest {
  
  STClient *client = [[STClient alloc] initWithProject:@"test.internal" APIKey:@"no-such-key"];
  [client setProtocol:@"http"];
  STRequest *request = [[STRequest alloc] initWithClient:client path:@"something"];
  [request setHTTPMethod:STHTTPMethods.Get];
  
  STWebTransport *transport = [[STWebTransport alloc] init];
  NSError *error;
  STResponse *response = [transport makeRequest:request orError:&error];
  
  XCTAssertNil(error);
  XCTAssertEqual(response.status, (NSInteger)404);  
  XCTAssertTrue([response.body rangeOfString:@"The requested project was not found."].location != NSNotFound);
  
}

@end
