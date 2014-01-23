//
//  STChangeInfo.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/17/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STNSDictionary+STExtensions.h"
#import "STResponse.h"
#import "STChangeInfo.h"

@interface STChangeInfoTest : XCTestCase

@end

@implementation STChangeInfoTest

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
  
  NSDictionary *changesDictionary = @{@"~created": @12, @"~updated": @13, @"~deleted": @14, @"~deltas": @[@{@"~id": @"idone", @"~created": @123},@{@"~id":@"idtwo"}]};
  
  STChangeInfo *changeInfo = [[STChangeInfo alloc] initWithChangeDictionary:changesDictionary];
    
  XCTAssertEqual((NSUInteger)12, changeInfo.created);
  XCTAssertEqual((NSUInteger)13, changeInfo.updated);
  XCTAssertEqual((NSUInteger)14, changeInfo.deleted);
  XCTAssertEqualObjects(@"idone", changeInfo.deltas[0][@"~id"]);
  XCTAssertEqualObjects(@123, changeInfo.deltas[0][@"~created"]);
  XCTAssertEqualObjects(@"idtwo", changeInfo.deltas[1][@"~id"]);
  
}

@end
