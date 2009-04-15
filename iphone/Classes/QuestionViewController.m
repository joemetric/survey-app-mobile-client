//
//  QuestionViewController.m
//  JoeMetric
//
//  Created by Scott Barron on 3/5/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import "QuestionViewController.h"
#import "Question.h"
#import "FreetextAnswerViewController.h"
#import "PictureAnswerViewController.h"
#import "QuestionListViewController.h"

@implementation QuestionViewController

@synthesize amountLabel;
@synthesize questionLabel;
@synthesize question;
@synthesize questionList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)aQuestion
{
    if ([self initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.question = aQuestion;
        baseAlert = [[UIAlertView alloc]
                        initWithTitle:@"Unknown Question Type"
                        message:@""
                        delegate:self
                        cancelButtonTitle:nil
                        otherButtonTitles:@"OK", nil];
     }
    return self;
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questionLabel.text = self.question.text;
    self.amountLabel.text = [self.question amountAsDollarString];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)answerFreeTextQuestion {
    FreetextAnswerViewController *ftac = [[FreetextAnswerViewController alloc] initWithNibName:@"FreeTextAnswerView"
                                                                       bundle:nil
                                                                       question:self.question];
    ftac.questionList = questionList;
    [self.navigationController pushViewController:ftac animated:YES];
    [ftac release];
}

- (void)answerPictureQuestion {
    PictureAnswerViewController *pac = [[PictureAnswerViewController alloc] initWithNibName:@"PictureAnswerView"
                                                                    bundle:nil
                                                                    question:self.question];
    pac.questionList = questionList;
    [self.navigationController pushViewController:pac animated:YES];
    [pac release];
}

- (void)alertView:(UIAlertView*)alert clickedButtonAtIndex:(NSInteger)index
{
    [alert release];
}

- (void)unknownQuestionType {
    [baseAlert show];
}

- (void)answerQuestion:(id)sender {
    NSLog(@"Answering question for type: %@", self.question.questionType);

    if (self.question.questionType == nil) {
        [self unknownQuestionType];
        return;
    }
    
    if ([self.question.questionType isEqualToString:@"picture"]) {
        NSLog(@"Answering a picture question");
        [self answerPictureQuestion];
        return;
    }
    
    if ([self.question.questionType isEqualToString:@"freetext"]) {
        NSLog(@"Answering a free text question");
        [self answerFreeTextQuestion];
        return;
    }

    [self unknownQuestionType];
}

- (void)dealloc {
    [questionLabel release];
    [amountLabel release];
    [question release];
    [questionList release];
    [super dealloc];
}


@end
