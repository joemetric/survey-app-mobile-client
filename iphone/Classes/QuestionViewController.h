//
//  QuestionViewController.h
//  JoeMetric
//
//  Created by Scott Barron on 3/5/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Question;
@class QuestionListViewController;

@interface QuestionViewController : UIViewController <UIAlertViewDelegate> {
    UILabel *questionLabel;
    UILabel *amountLabel;
    Question *question;
    UIAlertView *baseAlert;
    QuestionListViewController *questionList;
}

@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UILabel *amountLabel;
@property (nonatomic, retain) Question *question;
@property (nonatomic, retain) QuestionListViewController *questionList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)aQuestion;

- (IBAction)answerQuestion:(id)sender;

@end
