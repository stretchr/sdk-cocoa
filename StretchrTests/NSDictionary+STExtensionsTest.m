//
//  NSDictionary+STExtensionsTest.m
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+STExtensions.h"
#import "NSDictionary+STExtensions.h"

@interface NSDictionary_STExtensionsTest : XCTestCase

@end

@implementation NSDictionary_STExtensionsTest

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

- (void)testStringFromQueryComponents
{
  NSDictionary* dict = @{@"order":@"age",@":upperAge":@">=18",@":lowerAge":@"<10",@"multi":@[@"one",@"two"]};
  
  NSString* json = [dict stringFromQueryComponents];
    
  XCTAssertTrue([json containsString:@"&"]);
  XCTAssertTrue([json containsString:@"order=age"]);
  XCTAssertTrue([json containsString:@"%3AupperAge=%3E%3D18"]);
  XCTAssertTrue([json containsString:@"%3AlowerAge=%3C10"]);
  XCTAssertTrue([json containsString:@"multi=one"]);
  XCTAssertTrue([json containsString:@"multi=two"]);
  
}

@end
