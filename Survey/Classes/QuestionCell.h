//
//  QuestionCell.h
//  Survey
//
//  Created by Allerin on 09-10-14.
//  Copyright 2009 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"


@interface QuestionCell : UITableViewCell {
	UIImageView *questionImage;
	UILabel *nameLabel;
	
	Question *question;
}

@property (nonatomic, retain) IBOutlet UIImageView *questionImage;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) Question *question;

- (void)updateQuestion:(Question *)q;
- (void)setNameLabelFrame:(CGFloat)height;

@end
