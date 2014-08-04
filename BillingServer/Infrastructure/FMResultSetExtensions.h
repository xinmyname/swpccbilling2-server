#import <FMResultSet.h>

@interface FMResultSet(Extensions)

- (int)nextInt:(int*)pColumn;
- (id)nextIntNumber:(int*)pColumn;
- (double)nextDouble:(int*)pColumn;
- (id)nextDoubleNumber:(int*)pColumn;
- (BOOL)nextBool:(int*)pColumn;
- (id)nextBoolNumber:(int*)pColumn;
- (id)nextString:(int*)pColumn;
- (id)nextDate:(int*)pColumn;
- (id)nextJsonDate:(int*)pColumn;

@end

//
//  Copyright (c) 2014 Clean Water Services. All rights reserved.
//
