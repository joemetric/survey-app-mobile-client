//
//  ProfileViewController.h
//  JoeMetric
//
//  Created by Joseph OBrien on 11/25/08.
//  Copyright 2008 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProfileViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
    IBOutlet UITextField *emailField;
}

- (IBAction)createAccount:(id)sender;
- (IBAction)saveAccount:(id)sender;
@end
