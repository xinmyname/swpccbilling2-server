#import <Foundation/Foundation.h>

@class Route;

@interface Router : NSObject

- (instancetype)initWithPrefix:(NSString*)prefix;
- (Route*)routeForVerb:(NSString*)verb withPath:(NSString*)path;

@end
