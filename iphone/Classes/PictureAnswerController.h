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

@interface PictureAnswerController : UIViewController <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate> {
    IBOutlet UIImageView *imageView;
    Question *question;
    UIViewController *questionList;
    UIActionSheet *menu;
    int snapshotButtonIndex;
    int libraryButtonIndex;
    int cancelButtonIndex;
}

@property (nonatomic, retain) Question *question;
@property (nonatomic, retain) UIViewController *questionList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)aQuestion;

- (IBAction)sendAnswer:(id)sender;
- (IBAction)changePicture:(id)sender;

@end
