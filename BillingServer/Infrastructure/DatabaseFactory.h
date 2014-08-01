//
//  DatabaseFactory.h
//  StemCount
//
//  Created by Andy Sherwood on 5/20/14.
//  Copyright (c) 2014 Clean Water Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;

@interface DatabaseFactory : NSObject

- (FMDatabase*)openDatabase;
- (void)dropDatabase;

@end
