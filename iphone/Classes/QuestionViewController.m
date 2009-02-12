//
//  QuestionViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 12/14/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "QuestionViewController.h"
#import "Question.h"


@implementation QuestionViewController

@synthesize selectedQuestion;
@synthesize selectedQuestionLabel;
@synthesize selectedAmountLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)question {    
    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.selectedQuestion = question;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    self.selectedQuestionLabel.text = self.selectedQuestion.text;
    self.selectedAmountLabel.text = [self.selectedQuestion amountAsDollarString];    
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [selectedQuestion release];
    [selectedQuestionLabel release];
    [selectedAmountLabel release];
    [super dealloc];
}

@end
