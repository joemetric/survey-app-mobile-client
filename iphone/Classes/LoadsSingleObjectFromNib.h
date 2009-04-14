//
//  LoadsSingleObjectFromNib.h
//  JoeMetric
//
//  Created by Paul Wilson on 13/04/2009.
//  Copyright 2009 Mere Complexities Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LabelledTableViewCell.h"
@interface LoadsSingleObjectFromNib : NSObject {
    IBOutlet id loadMe;

}

+(id)loadFromNib:(NSString*)nibName;

@end
