//
//  TextFieldCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-26.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

typedef enum
{
    EmailCell,
    PasswordCell,
    FoodDescriptionCell,
    RestaurantNameCell,
    DealNameCell,
    DealDetailCell,
}CellType;

#import <UIKit/UIKit.h>

@interface TextFieldCell : UITableViewCell
{
    IBOutlet UIImageView *backgroundImage;
}

@property (strong, nonatomic) IBOutlet UITextField *cellTextField;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (assign, nonatomic) CellType cellType;

- (IBAction)textFieldDidEndOnExit:(id)sender;
- (IBAction)textFieldEditingChanged:(id)sender;

@end
