//
//  QuestionsViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "QuestionsViewController.h"
#import "SingleQuestionViewController.h"
#import "Question.h"

@implementation QuestionsViewController

@synthesize questions;


- (void)viewDidLoad {
    self.questions = [NSArray arrayWithObjects:
                      [[Question alloc] initWithText:@"What kind of detergent do you use" 
                                              amount:[[NSDecimalNumber alloc] initWithDouble:.50]],
                      [[Question alloc] initWithText:@"What is you favorite color" 
                                              amount:[[NSDecimalNumber alloc] initWithDouble:4.50]],
                      [[Question alloc] initWithText:@"Take a picture of your closet"
                                              amount:[[NSDecimalNumber alloc] initWithDouble:3.75]],
                      [[Question alloc] initWithText:@"How do you feel today" 
                                              amount:[[NSDecimalNumber alloc] initWithDouble:2.00]], 
                      [[Question alloc] initWithText:@"Some really really long question that goes on and on and on" 
                                              amount:[[NSDecimalNumber alloc] initWithDouble:10.00]], 
                    nil];
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.questions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Question *q = [self.questions objectAtIndex:indexPath.row];
    cell.text = [q questionAndAmountAsString];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row %d", indexPath.row);
    SingleQuestionViewController *sqvc = [[SingleQuestionViewController alloc] initWithNibName:@"Question" bundle:nil question:[self.questions objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:sqvc animated:YES];    
    [sqvc release];    
}


/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    }
    if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}
*/

/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
}
*/
/*
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
*/

- (void)dealloc {
    [questions release];
    [super dealloc];
}


@end

