//
//  SurveyList.m
//  JoeMetric
//
//  Created by Jon Distad on 1/6/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import "SurveyList.h"
#import "Survey.h"


@implementation SurveyList

@synthesize currentSurveyObject = _currentSurveyObject;
@synthesize contentOfCurrentSurveyProperty = _contentOfCurrentSurveyProperty;

#pragma mark -
#pragma mark setup

- (id)init {
    if (self = [super init]) { 
        surveys = [NSMutableArray arrayWithObjects:
					 [[Survey alloc] initWithName:@"Detergent Surveys!" 
											 amount:[[NSDecimalNumber alloc] initWithDouble:.50]
											   dbId:@"0"],
					 [[Survey alloc] initWithName:@"Rainbows for Turtles Survey" 
											 amount:[[NSDecimalNumber alloc] initWithDouble:4.50]
											   dbId:@"0"],
					 [[Survey alloc] initWithName:@"Closet Surveys (SCANDELOUS!)"
											 amount:[[NSDecimalNumber alloc] initWithDouble:3.75]
											   dbId:@"0"],
					 [[Survey alloc] initWithName:@"Survey of the Day" 
											 amount:[[NSDecimalNumber alloc] initWithDouble:2.00]
											   dbId:@"0"],
					 [[Survey alloc] initWithName:@"Some really really long survey that goes on and on and on" 
											 amount:[[NSDecimalNumber alloc] initWithDouble:10.00]
											   dbId:@"0"],
					 nil];
        [surveys retain];
    }
    return self;
}

- (void)dealloc {
    [surveys release];
    [super dealloc];
}

-(Survey *)surveyAtIndex:(NSUInteger)index {
    return [surveys objectAtIndex:index];
}

-(NSUInteger)count {
    return [surveys count];
}

-(void)refreshSurveyList {
    [self getSurveysFromWeb];
}

#pragma mark -
#pragma mark xml_parsing

-(void)getSurveysFromWeb {
    // [TODO] Extract into a global
    // [TODO] Make a switch to pull from a local file if the server doesn't respond for dev purposes 
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://joemetric.local/surveys.xml"]];
    
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

-(void)addSurveyToList {
    if (nil == surveys) {
        NSLog(@"Colors array is nil");
        surveys = [[NSMutableArray alloc] initWithObjects:nil];
    }
    [surveys insertObject:[self.currentSurveyObject retain] atIndex:0];
}

-(void)createNewSurveyObject {
    self.currentSurveyObject = [[Survey alloc] init];
    [self addSurveyToList];  
}

-(void)createStringBufferForProperty {
    self.contentOfCurrentSurveyProperty = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"survey"]) {
        NSLog(@"Creating a new survey");
        
        [self createNewSurveyObject];
        
        // Here is where it goes BOOM
        NSLog(@"Survey count is: %d", [surveys count]);
        
        return;
    }
    
    if ([elementName isEqualToString:@"name"] || [elementName isEqualToString:@"amount"] || [elementName isEqualToString:@"id"]) {
        [self createStringBufferForProperty];
    } else {
        self.contentOfCurrentSurveyProperty = nil;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {     
    if (qName) {
        elementName = qName;
    }
    if ([elementName isEqualToString:@"name"]) {
        self.currentSurveyObject.name = self.contentOfCurrentSurveyProperty;
    } else if ([elementName isEqualToString:@"amount"]) {
        self.currentSurveyObject.amount = self.contentOfCurrentSurveyProperty;
    } else if ([elementName isEqualToString:@"id"]) {
		self.currentSurveyObject.dbId = self.contentOfCurrentSurveyProperty;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.contentOfCurrentSurveyProperty) {
        [self.contentOfCurrentSurveyProperty appendString:string];
        NSLog(@"appending string: %@", string);
    }
} 



@end
