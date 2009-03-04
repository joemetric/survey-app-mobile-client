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
    JoeMetricAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    usernameField.text = [appDelegate.credentials objectForKey:@"username"];
    passwordField.text = [appDelegate.credentials objectForKey:@"password"];
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
    [params setObject:[usernameField text] forKey:@"login"];
    [params setObject:@"foo@bar.com" forKey:@"email"];
    [params setObject:[passwordField text] forKey:@"password"];
    [params setObject:[passwordField text] forKey:@"password_confirmation"];

    Account *account = [Account createWithParams:params];
    if (account) {
        NSLog(@"Account was created!");
        [self saveAccount:sender];
    } else {
        // Pop up an alert or something?
        NSLog(@"Account creation hath FAILED");
    }
    
    NSLog(@"Created account: %@", account);
}

- (IBAction)saveAccount:(id)sender
{
    NSMutableDictionary *credentials = [[NSMutableDictionary alloc] initWithCapacity: 2];
    [credentials setObject:[usernameField text] forKey:@"username"];
    [credentials setObject:[passwordField text] forKey:@"password"];


    JoeMetricAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.credentials = credentials;
    [appDelegate saveCredentials];
}
@end

