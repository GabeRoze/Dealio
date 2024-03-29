//
//  UserProfileViewController.h
//  TableExampleApp
//
//  Created by Gabe Rozenberg on 12-08-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParser.h"
#import "ChangePasswordViewController.h"

@interface UserProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *table;
    XMLParser *parser;
    ChangePasswordViewController *changePasswordViewController;
    IBOutlet UIImageView *topBackgroundImage;
    IBOutlet UIImageView *bottomBackgroundImage;
}

@end
