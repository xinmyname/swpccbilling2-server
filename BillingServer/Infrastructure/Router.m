//
//  Router.m
//  RegExTest
//
//  Created by Andy Sherwood on 7/31/14.
//  Copyright (c) 2014 Clean Water Services. All rights reserved.
//

#import "Router.h"
#import "Route.h"
#import "NSString+InflectorKit.h"

@implementation Router
{
    NSString* _prefix;
}

- (instancetype)initWithPrefix:(NSString*)prefix
{
    self = [super init];
    
    if (self) {
        _prefix = prefix;
    }
    
    return self;
}

- (Route*)routeForVerb:(NSString*)verb withPath:(NSString*)path
{
    NSString* controller = nil;
    NSString* itemId = nil;
    RouteAction action = RouteActionNone;
    
    if ([path compare:_prefix options:0 range:NSMakeRange(0, [_prefix length])] == NSOrderedSame)
    {
        NSString* remainder = [path substringFromIndex:[_prefix length] + 1];
        
        NSRange slashRange = [remainder rangeOfString:@"/"];
        
        if (slashRange.location == NSNotFound)
            controller = remainder;
        else
        {
            controller = [remainder substringToIndex:slashRange.location];
            itemId = [remainder substringFromIndex:slashRange.location + 1];
        }
        
        controller = [controller singularizedString];
        controller = [controller capitalizedString];
    }

    if ([verb isEqualToString:@"GET"])
    {
        action = (itemId != nil)
            ? RouteActionFind
            : RouteActionFindAll;
    }
    else if ([verb isEqualToString:@"POST"])
        action = RouteActionCreate;
    else if ([verb isEqualToString:@"PUT"])
        action = RouteActionUpdate;
    else if ([verb isEqualToString:@"DELETE"])
        action = RouteActionDelete;
    
    return [[Route alloc] initWithController:controller
                                      itemId:itemId
                                   andAction:action];
}

@end
