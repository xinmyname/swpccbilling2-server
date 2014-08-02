#import <Foundation/Foundation.h>

@protocol ControllerDelegate <NSObject>

- (NSDictionary*)findItemWithId:(NSString*)itemId;
- (NSArray*)findAllItems;
- (NSDictionary*)updateItemWithId:(NSString*)itemId andJson:(NSDictionary*)json;
- (NSDictionary*)createWithJson:(NSDictionary*)json;
- (NSNumber*)deleteItemWithId:(NSString*)itemId;

@end