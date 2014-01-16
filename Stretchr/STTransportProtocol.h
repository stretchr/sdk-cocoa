//
//  STTransportProtocol.h
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STResponse;
@class STRequest;

@protocol STTransportProtocol <NSObject>

- (STResponse*)makeRequest:(STRequest*)request;

@end
