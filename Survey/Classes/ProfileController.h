//
//  ProfileViewController.h
//  Survey
//
//  Created by Allerin on 09-10-1.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditBirthdayController, EditGenderController, EditIncomingController;
@class EditRaceController, EditMartialController, EditZipcodeController;
@class EditEducationController, EditOccupationController,User;

@interface ProfileController : UIViewController {
	UITableView *profileTable;
	UITableViewCell *emailCell;
	UITableViewCell *birthdayCell;
	UITableViewCell *genderCell;
	UITableViewCell *zipcodeCell;
	UITableViewCell *incomeCell;
	UITableViewCell *raceCell;
	UITableViewCell *martialCell;
	UITableViewCell *educationCell;
	UITableViewCell *occupationCell;
	UILabel *emailLabel;
	UILabel *birthdayLabel;
	UILabel *genderLabel;
	UILabel *zipcodeLabel;
	UILabel *incomeLabel;
	UILabel *raceLabel;
	UILabel *martialLabel;
	UILabel *educationLabel;
	UILabel *occupationLabel;
	
	User* userPk;
	EditBirthdayController *editBirthdayController;
	EditGenderController *editGenderController;
	EditZipcodeController *editZipcodeController;
	EditIncomingController *editIncomingController;
	EditRaceController *editRaceController;
	EditMartialController *editMartialController;
	EditEducationController *editEducationController;
	EditOccupationController *editOccupationController;
}

@property (nonatomic, retain) IBOutlet UITableView *profileTable;
@property (nonatomic, retain) IBOutlet UITableViewCell *emailCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *birthdayCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *genderCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *zipcodeCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *incomeCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *raceCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *martialCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *educationCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *occupationCell;
@property (nonatomic, retain) IBOutlet UILabel *emailLabel;
@property (nonatomic, retain) IBOutlet UILabel *birthdayLabel;
@property (nonatomic, retain) IBOutlet UILabel *genderLabel;
@property (nonatomic, retain) IBOutlet UILabel *zipcodeLabel;
@property (nonatomic, retain) IBOutlet UILabel *incomeLabel;
@property (nonatomic, retain) IBOutlet UILabel *raceLabel;
@property (nonatomic, retain) IBOutlet UILabel *martialLabel;
@property (nonatomic, retain) IBOutlet UILabel *educationLabel;
@property (nonatomic, retain) IBOutlet UILabel *occupationLabel;

@property (nonatomic, retain) EditBirthdayController *editBirthdayController;
@property (nonatomic, retain) EditGenderController *editGenderController;
@property (nonatomic, retain) EditIncomingController *editIncomingController;
@property (nonatomic, retain) EditZipcodeController *editZipcodeController;
@property (nonatomic, retain) EditRaceController *editRaceController;
@property (nonatomic, retain) EditMartialController *editMartialController;
@property (nonatomic, retain) EditEducationController *editEducationController;
@property (nonatomic, retain) EditOccupationController *editOccupationController;
@property (nonatomic, retain) User* userPk;


@end
