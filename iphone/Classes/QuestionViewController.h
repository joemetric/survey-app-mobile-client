//
//  QuestionViewController.h
//  JoeMetric
//
//  Created by Joseph OBrien on 12/14/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"


@interface QuestionViewController : UIViewController {
    IBOutlet UILabel *_selectedQuestionLabel;
    IBOutlet UILabel *_selectedAmountLabel;
    Question *_selectedQuestion;
}

@property (nonatomic, retain) UILabel *selectedQuestionLabel;
@property (nonatomic, retain) UILabel *selectedAmountLabel;
@property (nonatomic, retain) Question *selectedQuestion;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)question;

@end
