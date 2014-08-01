//
//  RouteEmTests.m
//  RouteEmTests
//
//  Created by Andy Sherwood on 7/31/14.
//  Copyright (c) 2014 Andy Sherwood. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Route.h"
#import "Router.h"

@interface BillingServerTests : XCTestCase

@end

@implementation BillingServerTests
{
    Router* _router;
}

- (void)setUp
{
    [super setUp];
    
    _router = [[Router alloc] initWithPrefix:@"/api"];
}

- (void)testActionForGETWithoutItemId_IsFindAll
{
    Route* route = [_router routeForVerb:@"GET" withPath:nil];
    XCTAssertEqual([route action], RouteActionFindAll);
}

- (void)testActionForPOSTWithoutItemId_IsCreate
{
    Route* route = [_router routeForVerb:@"POST" withPath:nil];
    XCTAssertEqual([route action], RouteActionCreate);
}

- (void)testActionForGETWithItemId_IsFind
{
    Route* route = [_router routeForVerb:@"GET" withPath:@"/api/sample/42"];
    XCTAssertEqual([route action], RouteActionFind);
}

- (void)testActionForPUTWithItemId_IsUpdate
{
    Route* route = [_router routeForVerb:@"PUT" withPath:@"/api/sample/42"];
    XCTAssertEqual([route action], RouteActionUpdate);
}

- (void)testActionForDELETEWithItemId_IsDelete
{
    Route* route = [_router routeForVerb:@"DELETE" withPath:@"/api/sample/42"];
    XCTAssertEqual([route action], RouteActionDelete);
}

- (void)testControllerForEmptyPath_IsNil
{
    Route* route = [_router routeForVerb:nil withPath:nil];
    XCTAssertNil([route controller]);
}

- (void)testControllerForIncorrectPrefix_IsNil
{
    Route* route = [_router routeForVerb:nil withPath:@"/ipa/samples"];
    XCTAssertNil([route controller]);
}

- (void)testControllerWithoutId_IsCapitalized
{
    Route* route = [_router routeForVerb:nil withPath:@"/api/sample"];
    XCTAssert([[route controller] isEqualToString:@"Sample"]);
}

- (void)testControllerWithoutId_IsSinglular
{
    Route* route = [_router routeForVerb:nil withPath:@"/api/samples"];
    XCTAssert([[route controller] isEqualToString:@"Sample"]);
}

- (void)testControllerWithId_IsCapitalized
{
    Route* route = [_router routeForVerb:nil withPath:@"/api/sample/42"];
    XCTAssert([[route controller] isEqualToString:@"Sample"]);
}

- (void)testControllerWithId_IsSinglular
{
    Route* route = [_router routeForVerb:nil withPath:@"/api/samples/42"];
    XCTAssert([[route controller] isEqualToString:@"Sample"]);
}

- (void)testItemIdForPathWithoutItemId_IsNil
{
    Route* route = [_router routeForVerb:nil withPath:@"/api/samples"];
    XCTAssertNil([route itemId]);
}

- (void)testItemIdInPath_IsCorrect
{
    Route* route = [_router routeForVerb:nil withPath:@"/api/samples/42"];
    XCTAssert([[route itemId] isEqualToString:@"42"]);
}

- (void)testItemTrailingSlashAfterController_ActionIsFindAll
{
    Route* route = [_router routeForVerb:@"GET" withPath:@"/api/samples/"];
    XCTAssertEqual([route action], RouteActionFindAll);
}

- (void)testItemTrailingSlashAfterController_ControllerIsCorrect
{
    Route* route = [_router routeForVerb:@"GET" withPath:@"/api/samples/"];
    XCTAssert([[route controller] isEqualToString:@"Sample"]);
}

- (void)testItemTrailingSlashAfterController_ItemIdIsNil
{
    Route* route = [_router routeForVerb:@"GET" withPath:@"/api/samples/"];
    XCTAssertNil([route itemId]);
}

@end
