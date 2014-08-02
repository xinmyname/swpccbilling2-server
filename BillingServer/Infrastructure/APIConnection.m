#import "APIConnection.h"
#import "ControllerDelegate.h"
#import "Router.h"
#import "Route.h"
#import "HTTPMessage.h"
#import "HTTPDataResponse.h"

@implementation APIConnection
{
    Router* _router;
}

- (id)initWithAsyncSocket:(GCDAsyncSocket *)newSocket configuration:(HTTPConfig *)aConfig
{
    self = [super initWithAsyncSocket:newSocket configuration:aConfig];

    if (self)
        _router = [[Router alloc] initWithPrefix:@"/api"];
    
    return self;
}

- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path
{
    if ([method isEqualToString:@"GET"])
        return YES;
    if ([method isEqualToString:@"POST"])
        return YES;
    if ([method isEqualToString:@"PUT"])
        return YES;
    if ([method isEqualToString:@"DELETE"])
        return YES;
    
    return NO;
}

- (BOOL)expectsRequestBodyFromMethod:(NSString *)method atPath:(NSString *)path
{
    if ([method isEqualToString:@"POST"])
        return YES;
    if ([method isEqualToString:@"PUT"])
        return YES;
    
    return NO;
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
    Route* route = [_router routeForVerb:method withPath:path];
    
    if (!route)
        return [super httpResponseForMethod:method URI:path];
    
    Class controllerClass = NSClassFromString([[route controller] stringByAppendingString:@"Controller"]);
    
    if (!controllerClass)
        return [super httpResponseForMethod:method URI:path];
    
    id<ControllerDelegate> controller = [[controllerClass alloc] init];

    id result = nil;
    
    switch ([route action])
    {
        case RouteActionNone:
            break;
        case RouteActionFind:
            result = [controller findItemWithId:[route itemId]];
            break;
        case RouteActionFindAll:
            result = [controller findAllItems];
            break;
        case RouteActionUpdate:
        {
            NSData* postData = [request body];
            NSError* error = nil;
            NSDictionary* requestJson = [NSJSONSerialization JSONObjectWithData:postData options:0 error:&error];
            result = [controller updateItemWithId:[route itemId] andJson:requestJson];
            break;
        }
        case RouteActionCreate:
        {
            NSData* postData = [request body];
            NSError* error = nil;
            NSDictionary* requestJson = [NSJSONSerialization JSONObjectWithData:postData options:0 error:&error];
            result = [controller createWithJson:requestJson];
            break;
        }
        case RouteActionDelete:
            result = [controller deleteItemWithId:[route itemId]];
            break;
    }
    
    NSError* error = nil;
    NSData* responseData = [NSJSONSerialization dataWithJSONObject:result options:0 error:&error];
    
    return [[HTTPDataResponse alloc] initWithData:responseData];
}

- (void)processBodyData:(NSData *)postDataChunk
{
    [request appendData:postDataChunk];
}

@end
