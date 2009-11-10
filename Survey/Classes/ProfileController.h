//
//  ProfileViewController.h
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditBirthdayController, EditGenderController, EditIncomingController, EditZipcodeController;

@interface ProfileController : UIViewController {
	UITableView *profileTable;
	UITableViewCell *emailCell;
	UITableViewCell *birthdayCell;
	UITableViewCell *genderCell;
	UITableViewCell *zipcodeCell;
	UITableViewCell *incomeCell;
	UILabel *emailLabel;
	UILabel *birthdayLabel;
	UILabel *genderLabel;
	UILabel *zipcodeLabel;
	UILabel *incomeLabel;
	
	EditBirthdayController *editBirthdayController;
	EditGenderController *editGenderController;
	EditZipcodeController *editZipcodeController;
	EditIncomingController *editIncomingController;
}

@property (nonatomic, retain) IBOutlet UITableView *profileTable;
@property (nonatomic, retain) IBOutlet UITableViewCell *emailCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *birthdayCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *genderCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *zipcodeCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *incomeCell;
@property (nonatomic, retain) IBOutlet UILabel *emailLabel;
@property (nonatomic, retain) IBOutlet UILabel *birthdayLabel;
@property (nonatomic, retain) IBOutlet UILabel *genderLabel;
@property (nonatomic, retain) IBOutlet UILabel *zipcodeLabel;
@property (nonatomic, retain) IBOutlet UILabel *incomeLabel;

@property (nonatomic, retain) EditBirthdayController *editBirthdayController;
@property (nonatomic, retain) EditGenderController *editGenderController;
@property (nonatomic, retain) EditIncomingController *editIncomingController;
@property (nonatomic, retain) EditZipcodeController *editZipcodeController;

@end
