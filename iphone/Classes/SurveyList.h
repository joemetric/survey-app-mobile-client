//
//  SurveyList.h
//  JoeMetric
//
//  Created by Jon Distad on 1/6/09.
//  Copyright 2009 EdgeCase LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Survey.h"


@interface SurveyList : NSObject {
	NSMutableArray *surveys;
	Survey *_currentSurveyObject;
	NSMutableString *_contentOfCurrentSurveyProperty;
}
	
@property (nonatomic, retain) Survey *currentSurveyObject;
@property (nonatomic, retain) NSMutableString *contentOfCurrentSurveyProperty;
	
-(Survey *)surveyAtIndex:(NSUInteger)index;
-(NSUInteger)count;
-(void)refreshSurveyList;
-(void)getSurveysFromWeb;

@end
