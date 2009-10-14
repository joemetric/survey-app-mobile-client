//
//  QuestionCell.m
//  Survey
//
//  Created by Allerin on 09-10-14.
//  Copyright 2009 Allerin. All rights reserved.
//

#import "QuestionCell.h"


@implementation QuestionCell
@synthesize questionImage, nameLabel, question;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)awakeFromNib {
	nameLabel.numberOfLines = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
	[questionImage release];
	[nameLabel release];
	[question release];
	
    [super dealloc];
}

- (void)setNameLabelFrame:(CGFloat)height {
	CGRect frame = nameLabel.frame;
	frame.size.height = height;
	[nameLabel setFrame:frame];
}

- (void)updateQuestion:(Question *)q {
	self.question = q;
	nameLabel.text = q.name;
}

@end
