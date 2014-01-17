//
//  STTestTransport.h
//  Stretchr
//
//  Created by Tyler Bunnell on 1/16/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STTransportProtocol.h"

@interface STTestTransport : NSObject <STTransportProtocol>
@property(readonly,strong)NSMutableArray* requests;
@property(readonly,strong)NSMutableArray* responses;
@end
