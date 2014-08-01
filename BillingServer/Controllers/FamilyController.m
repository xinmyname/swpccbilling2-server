//
//  FamilyController.m
//  BillingServer
//
//  Created by Andy Sherwood on 8/1/14.
//  Copyright (c) 2014 Andy Sherwood. All rights reserved.
//

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

- (NSNumber*)updateItemId:(NSString*)itemId withJson:(NSDictionary*)json
{
    return [NSNumber numberWithInt:42];
}

- (NSString*)create:(NSDictionary*)json
{
    return @"42";
}

- (NSNumber*)deleteItemWithId:(NSString*)itemId
{
    return [NSNumber numberWithInt:42];
}


@end
