//
//  ControllerDelegate.h
//  RouteEm
//
//  Created by Andy Sherwood on 7/31/14.
//  Copyright (c) 2014 Clean Water Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ControllerDelegate <NSObject>

@optional

- (NSDictionary*)findItemWithId:(NSString*)itemId;
- (NSArray*)findAllItems;
- (NSNumber*)updateItemId:(NSString*)itemId withJson:(NSDictionary*)json;
- (NSString*)create:(NSDictionary*)json;
- (NSNumber*)deleteItemWithId:(NSString*)itemId;

@end