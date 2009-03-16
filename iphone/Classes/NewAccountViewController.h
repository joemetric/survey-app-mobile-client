//
//  NewAccountViewController.h
//  JoeMetric
//
//  Created by Alan Francis on 16/03/2009.
//  Copyright 2009 Cardboard Software (Scotland), Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProfileViewController;

@interface NewAccountViewController : UIViewController {
	UITextField* username;
	UITextField* password;
	UITextField* emailAddress;
	UIActivityIndicatorView* activityIndicator;
	UILabel* errorLabel;
	
	ProfileViewController* profileView;
}

- (IBAction) signup;
- (IBAction) cancel;

@property (nonatomic, retain) ProfileViewController* profileView;

@property (nonatomic, retain) IBOutlet UITextField* username;
@property (nonatomic, retain) IBOutlet UITextField* password;
@property (nonatomic, retain) IBOutlet UITextField* emailAddress;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* activityIndicator;
@property (nonatomic, retain) IBOutlet UILabel* errorLabel;

@end
