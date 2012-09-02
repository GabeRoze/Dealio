//
//  TOSCell.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-29.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOSCell : UITableViewCell
{
    IBOutlet UIWebView *tosText;
    IBOutlet UIImageView *backgroundImage;
}

@property (strong, nonatomic) IBOutlet UIImageView *checkBox;

-(void)setCheckboxFromData;

@end
