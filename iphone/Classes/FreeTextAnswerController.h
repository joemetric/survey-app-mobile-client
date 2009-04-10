//
//  FreeTextAnswerController.h
//  JoeMetric
//
//  Created by Scott Barron on 3/5/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Question;
@class QuestionListViewController;

@interface FreeTextAnswerController : UIViewController <UITextFieldDelegate> {
    Question *question;
    UIViewController *questionList;
    IBOutlet UITextField *answerField;
}

@property (nonatomic, retain) Question *question;
@property (nonatomic, retain) UIViewController *questionList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)aQuestion;

- (IBAction)submitAnswer:(id)sender;
@end
