#import "DatabaseFactory.h"
#import <FMDatabase.h>

@implementation DatabaseFactory
{
    NSFileManager* _fileManager;
    NSString* _databaseFileName;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _databaseFileName = @"Billing.sqlite";
        _fileManager = [NSFileManager defaultManager];
    }
    
    return self;
}

- (FMDatabase*)openDatabase
{
    NSString* path = [self databasePath];
    BOOL isNew = ![_fileManager fileExistsAtPath:path];
    
    FMDatabase* db = [FMDatabase databaseWithPath:path];
    
    [db open];
    
    if (isNew)
    {
        NSLog(@"Initializing new database");
        [self createSchema:db];
    }
    
    return db;
}

- (void)dropDatabase
{
    NSLog(@"Dropping database");
    
    NSError* error;
    NSString* path = [self databasePath];
    
    if ([_fileManager fileExistsAtPath:path])
    {
        BOOL success = [_fileManager removeItemAtPath:path
                                                error:&error];
        
        if (!success)
            @throw [NSException exceptionWithName:@"Failed to remove database"
                                           reason:[error localizedDescription]
                                         userInfo:nil];
    }
}

- (NSString*)databasePath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:_databaseFileName];
}

- (void)createSchema:(FMDatabase*)db
{
    [db beginTransaction];

    NSError* error;
    NSString* path = [[NSBundle mainBundle] pathForResource:@"CreateSchema" ofType:@"sql"];
    NSString* sql = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    [db executeStatements:sql];
    
    [db commit];
}

@end
