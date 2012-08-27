//
//  UserProfileNameCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-23.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileNameCell : UITableViewCell
{
    IBOutlet UIImageView *backgroundImage;
}
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;

@end
