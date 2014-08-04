#import "FamilyController.h"
#import "DatabaseFactory.h"
#import "FMDB.h"
#import "FMResultSetExtensions.h"

@implementation FamilyController
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

- (NSDictionary*)findItemWithId:(NSString*)itemId
{
    NSDictionary* item = nil;
    FMDatabase* db = [_dbFactory openDatabase];
    FMResultSet* results = [db executeQuery:@"SELECT * FROM Family WHERE Id=?", itemId];
    
    if ([results next])
        item = [self itemFromResult:results];
    
    [db close];
    
    return item;
}

- (NSArray*)findAllItems
{
    NSMutableArray* items = [[NSMutableArray alloc] init];
    FMDatabase* db = [_dbFactory openDatabase];
    FMResultSet* results = [db executeQuery:@"SELECT * FROM Family"];
    
    if ([results next])
    {
        NSDictionary* item = [self itemFromResult:results];
        [items addObject:item];
    }
    
    [db close];
    
    return items;
}

- (NSDictionary*)updateItemWithId:(NSString*)itemId andJson:(NSDictionary*)json
{
    NSDictionary* item = [json objectForKey:@"family"];
    FMDatabase* db = [_dbFactory openDatabase];
    
    [db executeUpdate:@"UPDATE Family SET Name=?,StreetAddress=?,City=?,State=?,Zip=?,DueDay=?,NumChildren=?,BillableDays=?,Disposition=?,IsGraduating=?,CheckSHA256=?,Joined=?,Departed=? WHERE Id=?",
     [item objectForKey:@"name"],
     [item objectForKey:@"streetAddress"],
     [item objectForKey:@"city"],
     [item objectForKey:@"state"],
     [item objectForKey:@"zip"],
     [item objectForKey:@"dueDay"],
     [item objectForKey:@"numChildren"],
     [item objectForKey:@"billableDays"],
     [item objectForKey:@"disposition"],
     [item objectForKey:@"isGraduating"],
     [item objectForKey:@"checkSHA256"],
     [item objectForKey:@"joined"],
     [item objectForKey:@"departed"],
     [item objectForKey:@"id"]
     ];
    
    [db close];
    
    return json;
}

- (NSDictionary*)createWithJson:(NSDictionary*)json
{
    id family = [[NSMutableDictionary alloc] initWithDictionary:[json objectForKey:@"family"]];
    
    FMDatabase* db = [_dbFactory openDatabase];
    
    [db executeUpdate:@"INSERT INTO Family VALUES (NULL,?,?,?,?,?,?,?,?,?,?,?,?,?)",
     [family objectForKey:@"name"],
     [family objectForKey:@"streetAddress"],
     [family objectForKey:@"city"],
     [family objectForKey:@"state"],
     [family objectForKey:@"zip"],
     [family objectForKey:@"dueDay"],
     [family objectForKey:@"numChildren"],
     [family objectForKey:@"billableDays"],
     [family objectForKey:@"disposition"],
     [family objectForKey:@"isGraduating"],
     [family objectForKey:@"checkSHA256"],
     [family objectForKey:@"joined"],
     [family objectForKey:@"departed"]
     ];
    
    FMResultSet* resultSet = [db executeQuery:@"SELECT MAX(Id) FROM Family"];
    
    if ([resultSet next])
    {
        int itemId = [resultSet intForColumnIndex:0];
        NSNumber* itemIdNum = [NSNumber numberWithInt:itemId];
        [family setObject:itemIdNum forKey:@"id"];
    }
    
    [db close];
    
    return @{@"family":family};
}

- (NSDictionary*)deleteItemWithId:(NSString*)itemId
{
    FMDatabase* db = [_dbFactory openDatabase];
    
    [db executeUpdate:@"DELETE FROM Family WHERE id=?", itemId];
    
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
      @"streetAddress": [results nextString:&col],
      @"city": [results nextString:&col],
      @"state": [results nextString:&col],
      @"zip": [results nextString:&col],
      @"dueDay": [results nextIntNumber:&col],
      @"numChildren": [results nextIntNumber:&col],
      @"billableDays": [results nextIntNumber:&col],
      @"disposition": [results nextIntNumber:&col],
      @"isGraduating": [results nextBoolNumber:&col],
      @"checkSHA256": [results nextString:&col],
      @"joined": [results nextJsonDate:&col],
      @"departed": [results nextJsonDate:&col]
      };
    
    return item;
}

@end
