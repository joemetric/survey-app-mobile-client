//
//  SurveyManager.m
//  JoeMetric
//
//  Created by Scott Barron on 3/25/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import "SurveyManager.h"
#import "RestConfiguration.h"
#import "JSON.h"

@implementation SurveyManager

- (void)cancelConnection {
    [conn cancel];
    [conn release];
    conn = nil;
}

- (void)startConnection:(NSURLRequest *)aRequest {
    [self cancelConnection];
    conn = [[NSURLConnection alloc] initWithRequest:aRequest delegate:self startImmediately:YES];
    if (!conn) {
        NSLog(@"Survey load connection failed");
    }
}

// STODO - need to also use didFinishLoading
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString *dataStr;
    NSArray *surveys;
    
    dataStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    surveys = [dataStr JSONFragmentValue];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *surveyDirectory = [documentsDirectory stringByAppendingPathComponent:@"surveys"];
    
    // Ensure surveys directory exists
    [[NSFileManager defaultManager] createDirectoryAtPath:surveyDirectory attributes:nil];
    
    // Write one plist file per survey, surveys/n.plist
    // Can do 'sync' by checking updated_at from the plist
    for (id survey in surveys) {
        NSString *surveyFilePath = [surveyDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", 
                                                                                    [[survey objectForKey:@"survey"] objectForKey:@"id"]]];
        [[survey objectForKey:@"survey"] writeToFile:surveyFilePath atomically:YES];
        NSLog(@"Wrote survey: %@", surveyFilePath);
    }

    [dataStr release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection error: %@", error);
}


- (BOOL)loadSurveysFromNetwork {
    // connection to app, download, write plist
    NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:[NSString stringWithFormat:@"%@:%d", host, port] path:@"/surveys.json"];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];

    [self startConnection:request];
    
    [url release];
    
    return YES;
}

+ (NSArray *)loadSurveysFromLocal {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *surveyDirectory = [documentsDirectory stringByAppendingPathComponent:@"surveys"];
    NSMutableArray *surveys = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (id surveyFile in [[NSFileManager defaultManager] directoryContentsAtPath:surveyDirectory]) {
        [surveys addObject:[NSDictionary dictionaryWithContentsOfFile:[surveyDirectory stringByAppendingPathComponent:surveyFile]]];
    }
    
    return [surveys autorelease];
}

- (id)init {
    if (self = [super init]) {
        host   = [RestConfiguration host];
        port   = [RestConfiguration port];
        buffer = [[NSMutableData alloc] init];
        
        NSMutableDictionary *headers = [[[NSMutableDictionary alloc] init] autorelease];
        [headers setValue:@"application/json" forKey:@"Content-Type"];
        [headers setValue:@"text/json" forKey:@"Accept"];
        [headers setValue:@"no-cache" forKey:@"Cache-Control"];
        [headers setValue:@"no-cache" forKey:@"Pragma"];
        [headers setValue:@"close" forKey:@"Connection"];
        
        request = [NSMutableURLRequest requestWithURL:nil
                                          cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                      timeoutInterval:60.0];
        
        [request setAllHTTPHeaderFields:headers];
    }
    return self;
}

- (void)dealloc {
//    [host release];
//    [buffer release];
//    [request release];
    [super dealloc];
}
@end
