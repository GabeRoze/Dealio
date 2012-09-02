//
//  MaleFemaleSelectionCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-29.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaleFemaleSelectionCell : UITableViewCell
{
    IBOutlet UIImageView *backgroundImage;
    IBOutlet UIImageView *maleImage;
    IBOutlet UIImageView *femaleImage;

    NSString *sex;

}
@end
