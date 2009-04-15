//
//  PictureAnswerController.m
//  JoeMetric
//
//  Created by Scott Barron on 3/5/09.
//  Copyright 2009 EdgeCase, LLC. All rights reserved.
//

#import "PictureAnswerViewController.h"
#import "QuestionListViewController.h"
#import "Question.h"
#import "Answer.h"
#import "AnswerManager.h"

@implementation PictureAnswerViewController

@synthesize question;
@synthesize questionList;
@synthesize questionLabel, questionDetails;
@synthesize imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil question:(Question *)aQuestion
{
    if ([self initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.question = aQuestion;

        snapshotButtonIndex = libraryButtonIndex = cancelButtonIndex = -1;
        
        menu = [[UIActionSheet alloc] init];
        menu.delegate = self;
        menu.title = @"Choose an image to send";

        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            snapshotButtonIndex = menu.numberOfButtons;
            [menu addButtonWithTitle:@"Take Photo"];
        }

        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            libraryButtonIndex = menu.numberOfButtons;
            [menu addButtonWithTitle:@"Choose Existing Photo"];
        }

        cancelButtonIndex = menu.numberOfButtons;
        [menu addButtonWithTitle:@"Cancel"];
        
        menu.cancelButtonIndex = cancelButtonIndex;
    }
    return self;
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == cancelButtonIndex) {
        return;
    }
    
    UIImagePickerController *p = [[UIImagePickerController alloc] init];
    p.delegate = self;

    if (buttonIndex == snapshotButtonIndex) {
        p.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        p.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
        
    [self presentModalViewController:p animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [menu showInView:[self view]];
}

- (void) viewWillAppear:(BOOL)animated {
	self.questionLabel.text = self.question.name;
	self.questionDetails.text = self.question.text;

	if( [Answer answerExistsForQuestion:self.question] == YES ) {
		Answer* answer = [Answer answerForQuestion:self.question];
		self.imageView.image = [UIImage imageWithContentsOfFile:[answer localImageFile]];
	}
	[super viewWillAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
	NSLog(@"About to disappear");
	if( self.modalViewController == nil && self.imageView.image != nil ) 
		[self storeAnswer];
	[super viewWillDisappear:animated];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    imageView.image = image;
    // STODO do picture storage here
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (NSString *)storeImage {
	NSString* filename = [NSString stringWithFormat:@"%d_image.png", question.itemId];
    NSString *uniquePath = [[Answer answerDirectory] stringByAppendingPathComponent:filename];
    
    NSLog(@"Writing image to %@", uniquePath);
    [UIImagePNGRepresentation(imageView.image) writeToFile:uniquePath atomically:YES];
    return uniquePath;
}

- (void)storeAnswer
{
    NSLog(@"Submitting picture");
    NSString *imagePath = [self storeImage];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInteger:question.itemId] forKey:@"question_id"];
    [params setObject:question.questionType forKey:@"question_type"];
    
    Answer *answer = [Answer newFromDictionary:params];
    answer.localImageFile = imagePath;
    [answer store];
//    [AnswerManager pushAnswer:answer];
//    
//    NSLog(@"Answer: %@", answer);
//    
//    [self.navigationController popToViewController:self.questionList animated:YES];

    [params release];
    [answer release];
}

- (IBAction)changePicture:(id)sender
{
    [menu showInView:[self view]];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [question release];
    [questionList release];
    [menu release];
    [super dealloc];
}


@end
