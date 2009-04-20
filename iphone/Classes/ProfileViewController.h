#import <UIKit/UIKit.h>
#import "Account.h"
#import "TableShrinksWhenKeyboardIsShownViewController.h"


@class CredentialsViewController;
@class NewAccountViewController;
@class NoCredentialsProfileDataSource;
@class ValidCredentialsProfileDataSource;
@class NoAccountDataProfileDataSource;
@class EditProfileDataSource;
@class Account;


@interface ProfileViewController : TableShrinksWhenKeyboardIsShownViewController <AccountObserver> {
	CredentialsViewController* credentialsController;
	NewAccountViewController* newAccountController;
	NoCredentialsProfileDataSource* noCredentials;
	ValidCredentialsProfileDataSource* validCredentials;
	NoAccountDataProfileDataSource* noAccountData;
	NoAccountDataProfileDataSource* loadingAccountData;
	EditProfileDataSource* editProfileDataSource;
	id currentDataSource;
}

- (void) displayModalCredentialsController;
- (void) displayModalNewAccountController;

@property (nonatomic, retain) CredentialsViewController* credentialsController;
@property (nonatomic, retain) NewAccountViewController* newAccountController;
@property (nonatomic, retain) NoCredentialsProfileDataSource* noCredentials;
@property (nonatomic, retain) ValidCredentialsProfileDataSource* validCredentials;
@property (nonatomic, retain) NoAccountDataProfileDataSource* noAccountData;
@property (nonatomic, retain) NoAccountDataProfileDataSource* loadingAccountData;
@property (nonatomic, retain) 	EditProfileDataSource* editProfileDataSource;
@property(nonatomic, retain) id currentDataSource;
@end
