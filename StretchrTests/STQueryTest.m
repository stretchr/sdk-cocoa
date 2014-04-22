//
//  STQueryTest.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/14/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STQuery.h"
#import "Stretchr.h"

@interface STQuery ()
/**
 *  Holds all the parameters assigned via the exposed methods. Used to
 *  generate the final query string.
 */
@property(readwrite, nonatomic, copy) NSMutableDictionary* parameters;
@property(readwrite, nonatomic, copy) NSMutableDictionary* aggregations;
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

- (void)testEndToEnd {
  [Stretchr initializeSharedSDKWithAccount:@"sandiego"
                                   project:@"crime"
                                       key:@"de0128c1cb7b70f583f56dd71da857df"];
  Stretchr* stretchr = [Stretchr sharedSDK];
STResourceBlock success = ^(STRequest * request, STResource * resource) {
  NSLog(@"Response: %@", resource);
};
STFailureBlock failure =
    ^(STRequest * request, NSInteger status, NSArray * errors) {
  NSLog(@"Failure! Status: %ld, errors: %@", status, errors);
};
[stretchr readResourceAtPath:@"user/tyler"
                       query:nil
                     success:success
                     failure:failure];
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

  [query setAggregateSumForKeys:@[ @"Tyler", @"Mat" ]];
  XCTAssertEqualObjects([query aggregations][@"sum"][0], @"Tyler");
  XCTAssertEqualObjects([query aggregations][@"sum"][1], @"Mat");

  [query setAggregateMaxForKeys:@[ @"Tyler", @"Mat" ]];
  XCTAssertEqualObjects([query aggregations][@"max"][0], @"Tyler");
  XCTAssertEqualObjects([query aggregations][@"max"][1], @"Mat");

  [query setAggregateMinForKeys:@[ @"Tyler", @"Mat" ]];
  XCTAssertEqualObjects([query aggregations][@"min"][0], @"Tyler");
  XCTAssertEqualObjects([query aggregations][@"min"][1], @"Mat");

  [query setAggregateAverageForKeys:@[ @"Tyler", @"Mat" ]];
  XCTAssertEqualObjects([query aggregations][@"avg"][0], @"Tyler");
  XCTAssertEqualObjects([query aggregations][@"avg"][1], @"Mat");

  [query setAggregateUniqueSetForKeys:@[ @"Tyler", @"Mat" ]];
  XCTAssertEqualObjects([query aggregations][@"uniqueSet"][0], @"Tyler");
  XCTAssertEqualObjects([query aggregations][@"uniqueSet"][1], @"Mat");

  [query setAggregateGroupByKeys:@[ @"Tyler", @"Mat" ]];
  XCTAssertEqualObjects([query aggregations][@"group"][0], @"Tyler");
  XCTAssertEqualObjects([query aggregations][@"group"][1], @"Mat");

  [query setAggregateUnwindKeys:@[ @"Tyler", @"Mat" ]];
  XCTAssertEqualObjects([query aggregations][@"unwind"][0], @"Tyler");
  XCTAssertEqualObjects([query aggregations][@"unwind"][1], @"Mat");

  [query setAggregateCountResults];
  XCTAssertEqualObjects([query aggregations][@"count"], @YES);

  query = [STQuery query];
  [query addFilterForKey:@"name" equals:@"Tyler"];
  [query addFilterForKey:@"age" between:@"18" and:@"34"];
  [query addFilterForKeyExists:@"active"];
  [query setAggregateGroupByKeys:@[ @"name", @"age" ]];
  [query setAggregateSumForKeys:@[ @"sales" ]];
  [query setAggregateCountResults];

  XCTAssertEqualObjects([query URLParameters], @"%3Aage=18..34&%3Aname=Tyler&%"
                                                "3Aactive=%2A&agg=group(name,"
                                                "age).sum(sales).count()");
}

@end
