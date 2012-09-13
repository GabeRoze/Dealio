//
//  SelectDayCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-27.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDayCell : UITableViewCell
{
    IBOutlet UIImageView *backgroundImage;
    IBOutlet UIImageView *button1;
    IBOutlet UIImageView *button2;
    IBOutlet UIImageView *button3;
    IBOutlet UIImageView *button4;
    IBOutlet UIImageView *button5;
    IBOutlet UIImageView *button6;
    IBOutlet UIImageView *button7;
    NSArray *buttonArray;

}

-(void)setSelectedDaysFromMemory;

@end
