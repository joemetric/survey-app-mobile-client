//
//  SingleQuestionViewController.h
//  JoeMetric
//
//  Created by Joseph OBrien on 12/12/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"


@interface SingleQuestionViewController : UIViewController {
    IBOutlet UILabel *_selectedQuestion;
    IBOutlet UILabel *_selectedAmount;
    NSString *_textForSelectedQuestion;
    NSString *_textForSelectedAmount;
}

@property (nonatomic, retain) UILabel *selectedQuestion;
@property (nonatomic, retain) UILabel *selectedAmount;
@property (nonatomic, retain) NSString *textForSelectedQuestion;
@property (nonatomic, retain) NSString *textForSelectedAmount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)question;
- (IBAction)answerQuestion:(id)sender;

@end
