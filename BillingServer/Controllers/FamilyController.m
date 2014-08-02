#import "FamilyController.h"

@implementation FamilyController

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
    return json;
}

- (NSDictionary*)createWithJson:(NSDictionary*)json
{
    // return same json, but with id added in
    return @{};
}

- (NSDictionary*)deleteItemWithId:(NSString*)itemId
{
    return @{};
}


@end
