//
//  TestObject.h
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface TestObject : JSONModel

@property(readwrite,copy)NSString* name;
@property(readwrite,assign)NSInteger age;

@end
