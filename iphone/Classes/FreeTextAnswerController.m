//
//  FreeTextAnswerController.m
//  JoeMetric
//
//  Created by Scott Barron on 3/5/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import "FreeTextAnswerController.h"
#import "Question.h"
#import "Answer.h"
#import "QuestionListViewController.h"

@implementation FreeTextAnswerController

@synthesize question;
@synthesize questionList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)aQuestion
{
    if ([self initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.question = aQuestion;
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)submitAnswer:(id)sender {
    NSLog(@"Submitting answer");
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInteger:question.itemId] forKey:@"question_id"];
    [params setObject:question.questionType forKey:@"question_type"];
    [params setObject:answerField.text forKey:@"answer_string"];

    Answer *answer = [Answer newFromDictionary:params];
    [answer store];
    NSLog(@"Answer: %@", answer);
    
    [self.navigationController popToViewController:self.questionList animated:YES];

    [params release];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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


- (void)dealloc {
    [question release];
    [questionList release];
    [super dealloc];
}


@end
