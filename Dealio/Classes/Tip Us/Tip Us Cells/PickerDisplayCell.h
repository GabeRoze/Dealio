//
//  PickerDisplayCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-27.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerDisplayCell : UITableViewCell
{
    IBOutlet UIImageView *backgroundImage;
    IBOutlet UILabel *selectionLabel;
}

@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end
