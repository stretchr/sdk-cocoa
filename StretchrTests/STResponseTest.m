//
//  STResponseTest.m
//  Stretchr
//
//  Created by Mat Ryer on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STResponse.h"

@interface STResponseTest : XCTestCase

@end

@implementation STResponseTest

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

@end
