//
//  STRequestTest.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/8/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "STRequest.h"
#import "STConstants.h"
#import "STQuery.h"
#import "STNSString+STExtensions.h"

@interface STRequestTest : XCTestCase

@end

@implementation STRequestTest

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

- (void)testURLString {

  STRequest* request = [STRequest requestWithProtocol:@"https"
                                                 host:@"stretchr.com"
                                              account:@"account"
                                              project:@"project"
                                                  key:@"123"
                                               method:@"GET"
                                                 path:@"people/tyler"];

  XCTAssertEqualObjects(@"https://account.stretchr.com/api/v1.2/project/people/"
                         "tyler?key=123&include=~path",
                        [request URLString]);

  request = [STRequest requestWithProtocol:@"https"
                                      host:@"stretchr.com"
                                   account:@"account"
                                   project:@"project"
                                       key:@"123"
                                    method:@"GET"
                                      path:@"people/tyler"];

  STQuery* query = [STQuery query];
  [query addFilterForKey:@"name" equals:@"Tyler"];
  [query addFilterForKey:@"age" between:@"18" and:@"34"];
  [query addFilterForKeyExists:@"active"];
  [query setAggregateGroupByKeys:@[ @"name", @"age" ]];
  [query setAggregateSumForKeys:@[ @"sales" ]];
  [query setAggregateCountResults];

  [request setQuery:query];

  XCTAssertEqualObjects(
      @"https://account.stretchr.com/api/v1.2/project/"
       "people/"
       "tyler?key=123&%3Aage=18..34&%3Aname=Tyler&include=~path&%3Aactive=%"
       "2A&agg=group(name,age).sum(sales).count()",
      [request URLString]);
}

@end
