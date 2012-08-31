//
//  ButtonCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-31.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonCell : UITableViewCell
{
    IBOutlet UIImageView *backgroundImage;
}
@property (strong, nonatomic) IBOutlet UILabel *buttonLabel;
@end
