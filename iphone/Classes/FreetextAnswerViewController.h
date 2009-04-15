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

@interface FreetextAnswerViewController : UIViewController <UITextFieldDelegate> {
    Question *question;
	UILabel *questionLabel;
	UITextView *questionDetails;
    UIViewController *questionList;
    UITextView *answerField;
	UIView *answerFieldBorder;
	BOOL keyboardIsShowing;
}

@property (nonatomic, retain) Question *question;
@property (nonatomic, retain) UIViewController *questionList;
@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UITextView *questionDetails;
@property (nonatomic, retain) IBOutlet UITextView *answerField;
@property (nonatomic, retain) IBOutlet UIView *answerFieldBorder;
@property (nonatomic) BOOL keyboardIsShowing;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)aQuestion;
- (void)doneEditing:(id)sender;

- (IBAction)submitAnswer:(id)sender;
@end
