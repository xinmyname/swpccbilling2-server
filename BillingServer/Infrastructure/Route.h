//
//  Route.h
//  RegExTest
//
//  Created by Andy Sherwood on 7/31/14.
//  Copyright (c) 2014 Clean Water Services. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RouteAction) {
    RouteActionNone,
    RouteActionFind,
    RouteActionFindAll,
    RouteActionUpdate,
    RouteActionCreate,
    RouteActionDelete
};

@interface Route : NSObject

@property (nonatomic,copy) NSString* controller;
@property (nonatomic,copy) NSString* itemId;
@property (nonatomic) RouteAction action;

- (instancetype)initWithController:(NSString*)controller
                            itemId:(NSString*)itemId
                         andAction:(RouteAction)action;


@end
