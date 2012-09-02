//
//  SideBySideTextFieldCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-29.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideBySideTextFieldCell : UITableViewCell
{
    IBOutlet UIImageView *backgroundImage;
}
@property (strong, nonatomic) IBOutlet UITextField *leftTextField;
@property (strong, nonatomic) IBOutlet UITextField *rightTextField;
- (IBAction)firstNameDidEndOnExit:(id)sender;
- (IBAction)lastNameDidEndOnExit:(id)sender;
- (IBAction)firstNameEditingChanged:(id)sender;
- (IBAction)lastNameEditingChanged:(id)sender;
@end
