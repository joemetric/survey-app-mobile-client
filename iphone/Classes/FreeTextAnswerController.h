//
//  FreeTextAnswerController.h
//  JoeMetric
//
//  Created by Scott Barron on 3/5/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Question;

@interface FreeTextAnswerController : UIViewController <UITextFieldDelegate> {
    Question *question;
    IBOutlet UITextField *answerField;
}

@property (nonatomic, assign) Question *question;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)aQuestion;

- (IBAction)submitAnswer:(id)sender;
@end
