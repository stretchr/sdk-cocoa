//
//  STQueryTest.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/14/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STQuery.h"

@interface STQuery ()
/**
 *  Holds all the parameters assigned via the exposed methods. Used to
 *  generate the final query string.
 */
@property(readwrite, nonatomic, copy) NSMutableDictionary* parameters;
@end

@interface STQueryTest : XCTestCase

@end

@implementation STQueryTest

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each
  // test method in the class.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each
  // test method in the class.
  [super tearDown];
}

- (void)testFilters {
  STQuery* query = [STQuery query];

  [query addFilterForKey:@"name" equals:@"Tyler"];
  XCTAssertEqualObjects([query parameters][@":name"], @"Tyler");
  [query addFilterForKey:@":name" equals:@"Mat"];
  XCTAssertEqualObjects([query parameters][@":name"], @"Mat");

  [query addFilterForKey:@"name" notEquals:@"Tyler"];
  XCTAssertEqualObjects([query parameters][@":name"], @"!Tyler");
  [query addFilterForKey:@"name" notEquals:@"!Mat"];
  XCTAssertEqualObjects([query parameters][@":name"], @"!Mat");

  [query addFilterForKey:@"name" containsOne:@[ @"Tyler", @"Mat" ]];
  XCTAssertEqualObjects([query parameters][@":name"], @"Tyler,Mat");

  [query addFilterForKey:@"name" containsAll:@[ @"Tyler", @"Mat" ]];
  XCTAssertEqualObjects([query parameters][@":name"][0], @"Tyler");
  XCTAssertEqualObjects([query parameters][@":name"][1], @"Mat");

  [query addFilterForKey:@"name" notContains:@[ @"Tyler", @"Mat" ]];
  XCTAssertEqualObjects([query parameters][@":name"], @"!Tyler,Mat");

  [query addFilterForKey:@"age" between:@"18" and:@"34"];
  XCTAssertEqualObjects([query parameters][@":age"], @"18..34");

  [query addFilterForKeyExists:@"suspended"];
  XCTAssertEqualObjects([query parameters][@":suspended"], @"*");

  [query addFilterForKeyNotExists:@"suspended"];
  XCTAssertEqualObjects([query parameters][@":suspended"], @"!*");

  [query addFilterForKey:@"age" greaterThan:@"25"];
  XCTAssertEqualObjects([query parameters][@":age"], @">25");

  [query addFilterForKey:@"age" lessThan:@"25"];
  XCTAssertEqualObjects([query parameters][@":age"], @"<25");

  [query addFilterForKey:@"age" greaterThanOrEqualTo:@"25"];
  XCTAssertEqualObjects([query parameters][@":age"], @">=25");

  [query addFilterForKey:@"age" lessThanOrEqualTo:@"25"];
  XCTAssertEqualObjects([query parameters][@":age"], @"<=25");

  [query addParameterForKey:@"agg" value:@"group(name).sum(sales)"];
  XCTAssertEqualObjects([query parameters][@"agg"], @"group(name).sum(sales)");

  [query addOrderByKeyAscending:@"age"];
  XCTAssertEqualObjects([query parameters][@"order"][0], @"age");

  [query addOrderByKeyDescending:@"year"];
  XCTAssertEqualObjects([query parameters][@"order"][1], @"-year");

  [query setPage:10];
  XCTAssertEqual(query.limit, 100);
  XCTAssertEqual(query.skip, 900);
}

@end
