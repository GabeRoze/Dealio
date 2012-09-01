//
//  TextFieldCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-26.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldCell : UITableViewCell
{
    IBOutlet UIImageView *backgroundImage;
}

@property (strong, nonatomic) IBOutlet UITextField *cellTextField;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
- (IBAction)textFieldDidEndOnExit:(id)sender;

@end
