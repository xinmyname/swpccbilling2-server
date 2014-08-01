//
//  Route.m
//  RegExTest
//
//  Created by Andy Sherwood on 7/31/14.
//  Copyright (c) 2014 Clean Water Services. All rights reserved.
//

#import "Route.h"

@implementation Route

@synthesize controller=_controller;
@synthesize itemId=_itemId;
@synthesize action=_action;

- (instancetype)initWithController:(NSString*)controller
                            itemId:(NSString*)itemId
                         andAction:(RouteAction)action
{
    self = [super init];
    
    if (self) {
        _controller = controller;
        _itemId = itemId;
        _action = action;
    }
    return self;
}

@end
