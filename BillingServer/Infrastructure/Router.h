//
//  Router.h
//  RegExTest
//
//  Created by Andy Sherwood on 7/31/14.
//  Copyright (c) 2014 Clean Water Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Route;

@interface Router : NSObject

- (instancetype)initWithPrefix:(NSString*)prefix;
- (Route*)routeForVerb:(NSString*)verb withPath:(NSString*)path;

@end
