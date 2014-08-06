#import "FeeController.h"
#import "DatabaseFactory.h"
#import "FMDB.h"
#import "FMResultSetExtensions.h"

@implementation FeeController
{
    DatabaseFactory* _dbFactory;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _dbFactory = [[DatabaseFactory alloc] init];
    }
    
    return self;
}


- (NSDictionary*)findItemWithId:(NSString *)itemId
{
    NSDictionary* item = nil;
    FMDatabase* db = [_dbFactory openDatabase];
    FMResultSet* results = [db executeQuery:@"SELECT * FROM Fee WHERE Id=?", itemId];
    
    if ([results next])
        item = [self itemFromResult:results];
    
    [db close];
    
    return @{@"fee": item ? item : [NSNull null]};
}

- (NSDictionary*)findAllItems
{
    NSMutableArray* items = [[NSMutableArray alloc] init];
    FMDatabase* db = [_dbFactory openDatabase];
    FMResultSet* results = [db executeQuery:@"SELECT * FROM Fee"];
    
    if ([results next])
    {
        NSDictionary* item = [self itemFromResult:results];
        [items addObject:item];
    }
    
    [db close];
    
    return @{@"fees":items};
}

/*
 CREATE TABLE Fee
 (
 Id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
 Name TEXT,
 Type TEXT,
 Category TEXT,
 Amount NUMERIC
 );
 */

- (NSDictionary*)updateItemWithId:(NSString *)itemId andJson:(NSDictionary *)json
{
    NSDictionary* item = [json objectForKey:@"fee"];
    FMDatabase* db = [_dbFactory openDatabase];
    
    [db executeUpdate:@"UPDATE Fee SET Name=?,Type=?,Category=?,Amount=? WHERE Id=?",
     [item objectForKey:@"name"],
     [item objectForKey:@"type"],
     [item objectForKey:@"category"],
     [item objectForKey:@"amount"]
     ];
    
    [db close];
    
    return json;
}


- (NSDictionary*)createWithJson:(NSDictionary *)json
{
    id item = [[NSMutableDictionary alloc] initWithDictionary:[json objectForKey:@"fee"]];
    
    FMDatabase* db = [_dbFactory openDatabase];
    
    [db executeUpdate:@"INSERT INTO Fee VALUES (NULL,?,?,?,?)",
     [item objectForKey:@"name"],
     [item objectForKey:@"type"],
     [item objectForKey:@"category"],
     [item objectForKey:@"amount"]
     ];
    
    FMResultSet* results = [db executeQuery:@"SELECT MAX(Id) FROM Fee"];
    
    if ([results next])
    {
        int col = 0;
        NSNumber* itemId = [results nextIntNumber:&col];
        [item setObject:itemId forKey:@"id"];
    }
    
    [db close];
    
    return @{@"fee": item};
}

- (NSDictionary*)deleteItemWithId:(NSString *)itemId
{
    FMDatabase* db = [_dbFactory openDatabase];
    
    [db executeUpdate:@"DELETE FROM Fee WHERE Id=?", itemId];
    
    [db close];
    
    return @{};
}

- (NSDictionary*)itemFromResult:(FMResultSet*)results
{
    NSDictionary* item = nil;
    
    int col = 0;
    
    item =
    @{
      @"id": [results nextIntNumber:&col],
      @"name": [results nextString:&col],
      @"type": [results nextString:&col],
      @"category": [results nextString:&col],
      @"amount": [results nextDoubleNumber:&col],
      };
    
    return item;
}

@end




