//
//  ProfileDataCell.h
//  TableExampleApp
//
//  Created by Gabe Rozenberg on 12-08-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileDataCell : UITableViewCell
{
    IBOutlet UIImageView *backgroundImage;
    IBOutlet UIImageView *bottomImage;
    IBOutlet UIImageView *leftImage;
}

@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;

@end
