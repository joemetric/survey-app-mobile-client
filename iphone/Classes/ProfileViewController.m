//
//  ProfileViewController.m
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import "JoeMetricAppDelegate.h"
#import "ProfileViewController.h"
#import "Account.h"

@implementation ProfileViewController

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
    usernameField.delegate = self;
    passwordField.delegate = self;
    emailField.delegate = self;
    
    JoeMetricAppDelegate *appDelegate = (JoeMetricAppDelegate*)[[UIApplication sharedApplication] delegate];
    usernameField.text = [appDelegate.credentials objectForKey:@"username"];
    passwordField.text = [appDelegate.credentials objectForKey:@"password"];
    emailField.text = [appDelegate.credentials objectForKey:@"email"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    // Configure the cell
    return cell;
}
*/

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
*/

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
    [super dealloc];
}

- (IBAction)createAccount:(id)sender
{
    NSLog(@"Creating with: %@ : %@", [usernameField text], [passwordField text]);

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (usernameField.text) {
        [params setObject:[usernameField text] forKey:@"login"];
    } else {
        [params setObject:@"" forKey:@"login"];
    }

    if (emailField.text) {
        [params setObject:emailField.text forKey:@"email"];
    } else {
        [params setObject:@"" forKey:@"email"];
    }

    if (passwordField.text) {
        [params setObject:[passwordField text] forKey:@"password"];
        [params setObject:[passwordField text] forKey:@"password_confirmation"];
    } else {
        [params setObject:@"" forKey:@"password"];
        [params setObject:@"" forKey:@"password_confirmation"];
    }

    Account *account = [Account createWithParams:params];
    if (account) {
        [self saveAccount:sender];
    } else {
        // Pop up an alert or something?
        NSLog(@"Account creation hath FAILED");
    }
    
    [params release];
}

- (IBAction)saveAccount:(id)sender
{
    NSMutableDictionary *credentials = [[NSMutableDictionary alloc] initWithCapacity: 2];
    [credentials setObject:[usernameField text] forKey:@"username"];
    [credentials setObject:[passwordField text] forKey:@"password"];


    JoeMetricAppDelegate *appDelegate = (JoeMetricAppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.credentials = credentials;
    [appDelegate saveCredentials];
}
@end

