#import <Foundation/Foundation.h>

@protocol ControllerDelegate <NSObject>

- (NSDictionary*)findItemWithId:(NSString*)itemId;
- (NSDictionary*)findAllItems;
- (NSDictionary*)updateItemWithId:(NSString*)itemId andJson:(NSDictionary*)json;
- (NSDictionary*)createWithJson:(NSDictionary*)json;
- (NSDictionary*)deleteItemWithId:(NSString*)itemId;

@end