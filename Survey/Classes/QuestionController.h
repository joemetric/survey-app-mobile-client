//
//  QuestionController.h
//  Survey
//
//  Created by Allerin on 09-10-16.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Survey, Question;

@interface QuestionController : UIViewController <UITextFieldDelegate> {
	UILabel *nameLabel;
	UILabel *descLabel;
	UITextField *answerField;
	Survey *survey;
	Question *question;
	NSInteger questionIdx;
	
	QuestionController *nextQuestionController;
}

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *descLabel;
@property (nonatomic, retain) IBOutlet UITextField *answerField;
@property (nonatomic, retain) Survey *survey;
@property (nonatomic, assign) NSInteger questionIdx;
@property (nonatomic, retain, readonly) Question *question;
@property (nonatomic, retain) QuestionController *nextQuestionController;

@end
