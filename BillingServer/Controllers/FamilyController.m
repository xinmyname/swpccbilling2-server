#import "FamilyController.h"
#import "DatabaseFactory.h"
#import "FMDB.h"

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
    return @{@"id":@42, @"name":@"item"};
}

- (NSArray*)findAllItems
{
    return @[@{@"id":@42, @"name":@"item"}];
}

- (NSDictionary*)updateItemWithId:(NSString*)itemId andJson:(NSDictionary*)json
{
    NSDictionary* family = [json objectForKey:@"family"];
    FMDatabase* db = [_dbFactory openDatabase];
    
    [db executeUpdate:@"UPDATE Family SET Name=?,StreetAddress=?,City=?,State=?,Zip=?,DueDay=?,NumChildren=?,BillableDays=?,Disposition=?,IsGraduating=?,CheckSHA256=?,Joined=?,Departed=? WHERE Id=?",
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
     [family objectForKey:@"departed"],
     [family objectForKey:@"id"]
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
    return @{};
}


@end
