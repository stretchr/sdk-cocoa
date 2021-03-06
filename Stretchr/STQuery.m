//
//  STQuery.m
//  Stretchr
//
//  Created by Tyler Bunnell on 4/14/14.
//  Copyright (c) 2014 Stretchr, Inc. All rights reserved.
//

#import "STQuery.h"
#import "STConstants.h"
#import "STNSDictionary+STExtensions.h"

@interface STQuery ()
/**
 *  Holds all the parameters assigned via the exposed methods. Used to
 *  generate the final query string.
 */
@property(readwrite, nonatomic, retain) NSMutableDictionary* parameters;

/**
 *  Holds all the aggregations assigned via the exposed methods. Used to
 *  generate the final query string.
 */
@property(readwrite, nonatomic, retain) NSMutableDictionary* aggregations;

/**
 *  Compiles the aggregations map into a URL ready representation.
 *
 *  @return The compiled aggregation in URL format.
 */
- (NSString*)compileAggregation;
@end

NSString* ensureFirstChar(NSString* firstChar, NSString* string) {
  if ([string hasPrefix:firstChar]) {
    return string;
  }
  return [firstChar stringByAppendingString:string];
}

@implementation STQuery

@synthesize parameters = _parameters;
@synthesize limit = _limit;
@synthesize skip = _skip;

+ (id)query {
  return [[STQuery alloc] init];
}

- (id)init {
  if (!(self = [super init])) {
    return nil;
  }

  self.parameters = [[NSMutableDictionary alloc] init];
  self.aggregations = [[NSMutableDictionary alloc] init];
  self.limit = STDefaults.ResourceLimit;
  return self;
}

- (NSString*)URLParameters {

  NSMutableDictionary* encodable =
      [NSMutableDictionary dictionaryWithDictionary:self.parameters];
  encodable[STQueryConstants.Limit] = [NSNumber numberWithInteger:self.limit];
  encodable[STQueryConstants.Skip] = [NSNumber numberWithInteger:self.skip];

  NSString* URLParameters = [encodable stringFromQueryComponents];

  if ([self.aggregations count] != 0) {
    NSString* agg = [self compileAggregation];
    URLParameters = [URLParameters
        stringByAppendingFormat:@"&%@=%@", STQueryConstants.Aggregate, agg];
  }

  return URLParameters;
}

- (NSString*)compileAggregation {
  NSString* agg = @"";

  for (NSString* key in self.aggregations) {
    id value = self.aggregations[key];
    if ([key isEqualToString:STAggregationConstants.Count]) {
      agg = [agg stringByAppendingFormat:@"%@().", key];

    } else {
      agg = [agg stringByAppendingFormat:@"%@(%@).", key,
                                         [value componentsJoinedByString:@","]];
    }
  }
  agg = [agg stringByTrimmingCharactersInSet:
                 [NSCharacterSet characterSetWithCharactersInString:@"."]];
  return agg;
}

- (void)addFilterForKey:(NSString*)key equals:(NSString*)value {
  [self.parameters setObject:value
                      forKey:ensureFirstChar(STQueryConstants.FilterChar, key)];
}

- (void)addFilterForKey:(NSString*)key notEquals:(NSString*)value {
  [self.parameters setObject:ensureFirstChar(STQueryConstants.NotChar, value)
                      forKey:ensureFirstChar(STQueryConstants.FilterChar, key)];
}

- (void)addFilterForKey:(NSString*)key containsOne:(NSArray*)values {
  [self.parameters setObject:
          [values componentsJoinedByString:STQueryConstants.ListSeparatorChar]
                      forKey:ensureFirstChar(STQueryConstants.FilterChar, key)];
}

- (void)addFilterForKey:(NSString*)key containsAll:(NSArray*)values {
  [self.parameters setObject:values
                      forKey:ensureFirstChar(STQueryConstants.FilterChar, key)];
}

- (void)addFilterForKey:(NSString*)key notContains:(NSArray*)values {
  [self.parameters
      setObject:ensureFirstChar(STQueryConstants.NotChar,
                                [values componentsJoinedByString:
                                            STQueryConstants.ListSeparatorChar])
         forKey:ensureFirstChar(STQueryConstants.FilterChar, key)];
}

- (void)addFilterForKey:(NSString*)key
                between:(NSString*)low
                    and:(NSString*)high {
  [self.parameters
      setObject:[NSString stringWithFormat:@"%@%@%@", low,
                                           STQueryConstants.BetweenChar, high]
         forKey:ensureFirstChar(STQueryConstants.FilterChar, key)];
}
- (void)addFilterForKeyExists:(NSString*)key {
  [self.parameters setObject:STQueryConstants.ExistsChar
                      forKey:ensureFirstChar(STQueryConstants.FilterChar, key)];
}

- (void)addFilterForKeyNotExists:(NSString*)key {
  [self.parameters setObject:ensureFirstChar(STQueryConstants.NotChar,
                                             STQueryConstants.ExistsChar)
                      forKey:ensureFirstChar(STQueryConstants.FilterChar, key)];
}

- (void)addFilterForKey:(NSString*)key greaterThan:(NSString*)value {
  [self.parameters
      setObject:ensureFirstChar(STQueryConstants.GreaterThanChar, value)
         forKey:ensureFirstChar(STQueryConstants.FilterChar, key)];
}

- (void)addFilterForKey:(NSString*)key lessThan:(NSString*)value {
  [self.parameters
      setObject:ensureFirstChar(STQueryConstants.LessThanChar, value)
         forKey:ensureFirstChar(STQueryConstants.FilterChar, key)];
}

- (void)addFilterForKey:(NSString*)key greaterThanOrEqualTo:(NSString*)value {
  [self.parameters
      setObject:ensureFirstChar(STQueryConstants.GreaterThanOrEqualChar, value)
         forKey:ensureFirstChar(STQueryConstants.FilterChar, key)];
}

- (void)addFilterForKey:(NSString*)key lessThanOrEqualTo:(NSString*)value {
  [self.parameters
      setObject:ensureFirstChar(STQueryConstants.LessThanOrEqualChar, value)
         forKey:ensureFirstChar(STQueryConstants.FilterChar, key)];
}

- (void)addParameterForKey:(NSString*)key value:(NSString*)value {
  [self.parameters setObject:value forKey:key];
}

- (void)addOrderByKeyAscending:(NSString*)key {
  if (!self.parameters[STQueryConstants.Order]) {
    self.parameters[STQueryConstants.Order] = [[NSMutableArray alloc] init];
  }
  [self.parameters[STQueryConstants.Order] addObject:key];
}

- (void)addOrderByKeyDescending:(NSString*)key {
  if (!self.parameters[STQueryConstants.Order]) {
    self.parameters[STQueryConstants.Order] = [[NSMutableArray alloc] init];
  }
  [self.parameters[STQueryConstants.Order]
      addObject:ensureFirstChar(STQueryConstants.NegateChar, key)];
}

- (void)setPage:(NSUInteger)page {
  self.skip = self.limit * (page - 1);
}

- (void)setAggregateSumForKeys:(NSArray*)keys {
  self.aggregations[STAggregationConstants.Sum] = [keys copy];
}

- (void)setAggregateMaxForKeys:(NSArray*)keys {
  self.aggregations[STAggregationConstants.Max] = [keys copy];
}

- (void)setAggregateMinForKeys:(NSArray*)keys {
  self.aggregations[STAggregationConstants.Min] = [keys copy];
}

- (void)setAggregateAverageForKeys:(NSArray*)keys {
  self.aggregations[STAggregationConstants.Average] = [keys copy];
}

- (void)setAggregateUniqueSetForKeys:(NSArray*)keys {
  self.aggregations[STAggregationConstants.UniqueSet] = [keys copy];
}

- (void)setAggregateGroupByKeys:(NSArray*)keys {
  self.aggregations[STAggregationConstants.Group] = [keys copy];
}

- (void)setAggregateUnwindKeys:(NSArray*)keys {
  self.aggregations[STAggregationConstants.Unwind] = [keys copy];
}

- (void)setAggregateCountResults {
  self.aggregations[STAggregationConstants.Count] = @YES;
}

- (void)addInclude:(NSString*)field {
  if (!self.parameters[STQueryConstants.Include]) {
    self.parameters[STQueryConstants.Include] = [[NSMutableArray alloc] init];
  }
  [self.parameters[STQueryConstants.Include] addObject:field];
}

- (id)copyWithZone:(NSZone*)zone {
  STQuery* query = [STQuery query];
  [query setParameters:[self parameters]];
  [query setAggregations:[self aggregations]];
  [query setLimit:[self limit]];
  [query setSkip:[self skip]];
  return query;
}

@end
