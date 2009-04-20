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
	id currentDataSource;
}

- (void) displayModalCredentialsController;
- (void) displayModalNewAccountController;

@property(nonatomic, retain) id currentDataSource;
@end
