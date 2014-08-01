//
//  AppDelegate.m
//  BillingServer
//
//  Created by Andy Sherwood on 7/31/14.
//  Copyright (c) 2014 Andy Sherwood. All rights reserved.
//

#import "AppDelegate.h"
#import <HTTPServer.h>
#import <HTTPConnection.h>
#import <HTTPDataResponse.h>
#import <DDLog.h>
#import <DDTTYLogger.h>
#import "APIConnection.h"
#import "DatabaseFactory.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation AppDelegate
{
    HTTPServer* _httpServer;
    DatabaseFactory* _dbFactory;
}

- (void)awakeFromNib
{
    _httpServer = [[HTTPServer alloc] init];
    [_httpServer setType:@"_http._tcp"];
    [_httpServer setPort:8080];
    [_httpServer setConnectionClass:[APIConnection class]];
    
    NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
    
    [_httpServer setDocumentRoot:webPath];
    
    _dbFactory = [[DatabaseFactory alloc] init];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    NSError *error = nil;
    if(![_httpServer start:&error])
    {
        DDLogError(@"Error starting HTTP Server: %@", error);
    }
}

@end
