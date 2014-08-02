#import <Foundation/Foundation.h>

@class FMDatabase;

@interface DatabaseFactory : NSObject

- (FMDatabase*)openDatabase;
- (void)dropDatabase;

@end
