//
//  SingleQuestionViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 12/12/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "SingleQuestionViewController.h"
#import "SurveyQuestionViewController.h"


@implementation SingleQuestionViewController

@synthesize selectedQuestionLabel = _selectedQuestionLabel;
@synthesize selectedAmountLabel = _selectedAmountLabel;
@synthesize selectedQuestion = _selectedQuestion;

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

-(IBAction)answerQuestion:(id)sender {
    NSLog(@"Answering the question");
    SurveyQuestionViewController *sqvc = [[SurveyQuestionViewController alloc] 
                                          initWithNibName:@"SurveyQuestionView" 
                                                   bundle:nil 
                                                 question:self.selectedQuestion];
    [self.navigationController pushViewController:sqvc animated:YES];    
    [sqvc release];
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {   
    self.selectedQuestionLabel.text = self.selectedQuestion.text;
    self.selectedAmountLabel.text = [self.selectedQuestion amountAsDollarString];
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}


- (void)dealloc {
    [self.selectedQuestionLabel release];
    [self.selectedAmountLabel release];
    [self.selectedQuestion release];
    [super dealloc];
}


@end
