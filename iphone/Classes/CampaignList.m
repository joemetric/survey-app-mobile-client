//
//  CampaignList.m
//  JoeMetric
//
//  Created by Jon Distad on 1/6/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import "CampaignList.h"
#import "Campaign.h"


@implementation CampaignList

@synthesize currentCampaignObject = _currentCampaignObject;
@synthesize contentOfCurrentCampaignProperty = _contentOfCurrentCampaignProperty;

#pragma mark -
#pragma mark setup

- (id)init {
    if (self = [super init]) { 
        campaigns = [NSMutableArray arrayWithObjects:
					 [[Campaign alloc] initWithName:@"Detergent Campaigns!" 
											 amount:[[NSDecimalNumber alloc] initWithDouble:.50]
											   dbId:@"0"],
					 [[Campaign alloc] initWithName:@"Rainbows for Turtles Campaign" 
											 amount:[[NSDecimalNumber alloc] initWithDouble:4.50]
											   dbId:@"0"],
					 [[Campaign alloc] initWithName:@"Closet Campaigns (SCANDELOUS!)"
											 amount:[[NSDecimalNumber alloc] initWithDouble:3.75]
											   dbId:@"0"],
					 [[Campaign alloc] initWithName:@"Campaign of the Day" 
											 amount:[[NSDecimalNumber alloc] initWithDouble:2.00]
											   dbId:@"0"],
					 [[Campaign alloc] initWithName:@"Some really really long campaign that goes on and on and on" 
											 amount:[[NSDecimalNumber alloc] initWithDouble:10.00]
											   dbId:@"0"],
					 nil];
        [campaigns retain];
    }
    return self;
}

- (void)dealloc {
    [campaigns release];
    [super dealloc];
}

-(Campaign *)campaignAtIndex:(NSUInteger)index {
    return [campaigns objectAtIndex:index];
}

-(NSUInteger)count {
    return [campaigns count];
}

-(void)refreshCampaignList {
    [self getCampaignsFromWeb];
}

#pragma mark -
#pragma mark xml_parsing

-(void)getCampaignsFromWeb {
    // [TODO] Extract into a global
    // [TODO] Make a switch to pull from a local file if the server doesn't respond for dev purposes 
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://joemetric.local/campaigns.xml"]];
    
    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    
    [parser parse];
    
    NSError *parseError = [parser parserError];
    if (parseError) {
        NSLog(@"Did not parse %@",parseError);
    }
    
    [parser release];
}

-(void)addCampaignToList {
    if (nil == campaigns) {
        NSLog(@"Colors array is nil");
        campaigns = [[NSMutableArray alloc] initWithObjects:nil];
    }
    [campaigns insertObject:[self.currentCampaignObject retain] atIndex:0];
}

-(void)createNewCampaignObject {
    self.currentCampaignObject = [[Campaign alloc] init];
    [self addCampaignToList];  
}

-(void)createStringBufferForProperty {
    self.contentOfCurrentCampaignProperty = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"campaign"]) {
        NSLog(@"Creating a new campaign");
        
        [self createNewCampaignObject];
        
        // Here is where it goes BOOM
        NSLog(@"Campaign count is: %d", [campaigns count]);
        
        return;
    }
    
    if ([elementName isEqualToString:@"name"] || [elementName isEqualToString:@"amount"] || [elementName isEqualToString:@"id"]) {
        [self createStringBufferForProperty];
    } else {
        self.contentOfCurrentCampaignProperty = nil;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {     
    if (qName) {
        elementName = qName;
    }
    if ([elementName isEqualToString:@"name"]) {
        self.currentCampaignObject.name = self.contentOfCurrentCampaignProperty;
    } else if ([elementName isEqualToString:@"amount"]) {
        self.currentCampaignObject.amount = self.contentOfCurrentCampaignProperty;
    } else if ([elementName isEqualToString:@"id"]) {
		self.currentCampaignObject.dbId = self.contentOfCurrentCampaignProperty;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.contentOfCurrentCampaignProperty) {
        [self.contentOfCurrentCampaignProperty appendString:string];
        NSLog(@"appending string: %@", string);
    }
} 



@end
