//
//  ChangePasswordViewController.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-26.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIImageView *backgroundImage;
}
@property (strong, nonatomic) IBOutlet UITableView *changePasswordTable;
@end
