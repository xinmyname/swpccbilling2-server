#import <FMDatabase.h>
#import "FMResultSetExtensions.h"

@implementation FMResultSet(Extensions)

- (int)nextInt:(int*)pColumn
{
    int value = [self intForColumnIndex:*pColumn];
    
    (*pColumn)++;
    
    return value;
}

- (id)nextIntNumber:(int*)pColumn
{
    NSNumber* value = nil;
    
    if (![self columnIndexIsNull:*pColumn])
    {
        int val = sqlite3_column_int([_statement statement], *pColumn);
        value = [NSNumber numberWithInt:val];
    }
    
    (*pColumn)++;
    
    return value != nil ? value : [NSNull null];
}

- (double)nextDouble:(int*)pColumn
{
    double value = [self doubleForColumnIndex:*pColumn];
    
    (*pColumn)++;
    
    return value;
}

- (id)nextDoubleNumber:(int*)pColumn
{
    NSNumber* value = nil;
    
    if (![self columnIndexIsNull:*pColumn])
    {
        double val = sqlite3_column_double([_statement statement], *pColumn);
        value = [NSNumber numberWithDouble:val];
    }
    
    (*pColumn)++;
    
    return value != nil ? value : [NSNull null];
}

- (BOOL)nextBool:(int*)pColumn
{
    BOOL value = [self boolForColumnIndex:*pColumn];
    
    (*pColumn)++;
    
    return value;
}

- (id)nextBoolNumber:(int*)pColumn
{
    NSNumber* value = nil;
    
    if (![self columnIndexIsNull:*pColumn])
    {
        BOOL val = sqlite3_column_int([_statement statement], *pColumn) != 0;
        value = [NSNumber numberWithBool:val];
    }
    
    (*pColumn)++;
    
    return value != nil ? value : [NSNull null];
}

- (id)nextString:(int*)pColumn
{
    NSString* value = nil;
    
    if (![self columnIndexIsNull:*pColumn])
        value = [self stringForColumnIndex:*pColumn];

    (*pColumn)++;
    
    return value != nil ? value : [NSNull null];
}

- (id)nextDate:(int*)pColumn
{
    NSDate* value = nil;
    
    if (![self columnIndexIsNull:*pColumn])
        value = [self dateForColumnIndex:*pColumn];
    
    (*pColumn)++;
    
    return value != nil ? value : [NSNull null];
}

- (id)nextJsonDate:(int*)pColumn
{
    NSString* value = nil;
    
    if (![self columnIndexIsNull:*pColumn])
    {
        NSDate* date = [self dateForColumnIndex:*pColumn];
        id formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        value = [formatter stringFromDate:date];
    }
    
    (*pColumn)++;
    
    return value != nil ? value : [NSNull null];
}

@end
