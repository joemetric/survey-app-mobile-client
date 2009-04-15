//
//  PictureAnswerController.h
//  JoeMetric
//
//  Created by Scott Barron on 3/5/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Question;
@class QuestionListViewController;

@interface PictureAnswerViewController : UIViewController <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate> {
    UIImageView *imageView;
    Question *question;
    UIViewController *questionList;
	UILabel *questionLabel;
	UITextView *questionDetails;
    UIActionSheet *menu;
    int snapshotButtonIndex;
    int libraryButtonIndex;
    int cancelButtonIndex;
}

@property (nonatomic, retain) Question *question;
@property (nonatomic, retain) UIViewController *questionList;
@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UITextView *questionDetails;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)aQuestion;

- (void)storeAnswer;
- (IBAction)changePicture:(id)sender;

@end
