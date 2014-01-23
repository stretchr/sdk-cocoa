//
//  STResourceCollectionTest.m
//  Stretchr
//
//  Created by Mat Ryer on 1/19/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STResourceCollection.h"

@interface STResourceCollectionTest : XCTestCase

@end

@implementation STResourceCollectionTest

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

- (void)testInitWithCapacity
{
  
  STResourceCollection *collection = [[STResourceCollection alloc] initWithCapacity:9];
  XCTAssertNotNil(collection);
  
}

@end
