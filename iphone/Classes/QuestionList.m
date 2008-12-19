//
//  QuestionList.m
//  JoeMetric
//
//  Created by Joseph OBrien on 12/15/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "QuestionList.h"
#import "Question.h"


@implementation QuestionList

@synthesize currentQuestionObject = _currentQuestionObject;
@synthesize contentOfCurrentQuestionProperty = _contentOfCurrentQuestionProperty;

#pragma mark -
#pragma mark setup

- (id)init {
    if (self = [super init]) { 
        questions = [NSMutableArray arrayWithObjects:
                          [[Question alloc] initWithText:@"What kind of detergent do you use" 
                                                  amount:[[NSDecimalNumber alloc] initWithDouble:.50]],
                          [[Question alloc] initWithText:@"What is you favorite color" 
                                                  amount:[[NSDecimalNumber alloc] initWithDouble:4.50]],
                          [[Question alloc] initWithText:@"Take a picture of your closet"
                                                  amount:[[NSDecimalNumber alloc] initWithDouble:3.75]],
                          [[Question alloc] initWithText:@"How do you feel today" 
                                                  amount:[[NSDecimalNumber alloc] initWithDouble:2.00]], 
                          [[Question alloc] initWithText:@"Some really really long question that goes on and on and on" 
                                                  amount:[[NSDecimalNumber alloc] initWithDouble:10.00]], 
                          nil];
        [questions retain];
    }
    return self;
}

- (void)dealloc {
    [questions release];
    [super dealloc];
}

-(Question *)questionAtIndex:(NSUInteger)index {
    return [questions objectAtIndex:index];
}

-(NSUInteger)count {
    return [questions count];
}

-(void)refreshQuestionList {
    [self getQuestionsFromWeb];
}

#pragma mark -
#pragma mark xml_parsing

-(void)getQuestionsFromWeb {
    // [TODO] Extract into a global
    // [TODO] Make a switch to pull from a local file if the server doesn't respond for dev purposes 
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://joemetric.local/questions.xml"]];
    
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

-(void)addQuestionToList {
    if (nil == questions) {
        NSLog(@"Colors array is nil");
        questions = [[NSMutableArray alloc] initWithObjects:nil];
    }
    [questions insertObject:[self.currentQuestionObject retain] atIndex:0];
}

-(void)createNewQuestionObject {
    self.currentQuestionObject = [[Question alloc] init];
    [self addQuestionToList];  
}

-(void)createStringBufferForProperty {
    self.contentOfCurrentQuestionProperty = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI 
		qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"question"]) {
        NSLog(@"Creating a new question");
        
        [self createNewQuestionObject];
        
        // Here is where it goes BOOM
        NSLog(@"Question count is: %d", [questions count]);
        
        return;
    }
    
    if ([elementName isEqualToString:@"text"]) {
        [self createStringBufferForProperty];
    } else if ([elementName isEqualToString:@"amount"]) {
        [self createStringBufferForProperty];
    } else {
        self.contentOfCurrentQuestionProperty = nil;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {     
    if (qName) {
        elementName = qName;
    }
    if ([elementName isEqualToString:@"text"]) {
        self.currentQuestionObject.text = self.contentOfCurrentQuestionProperty;
    } else if ([elementName isEqualToString:@"amount"]) {
        self.currentQuestionObject.amount = self.contentOfCurrentQuestionProperty;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.contentOfCurrentQuestionProperty) {
        [self.contentOfCurrentQuestionProperty appendString:string];
        NSLog(@"appending string: %@", string);
    }
} 



@end
