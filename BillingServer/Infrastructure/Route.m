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
