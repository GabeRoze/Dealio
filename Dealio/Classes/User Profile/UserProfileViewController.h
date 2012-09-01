//
//  UserProfileViewController.h
//  TableExampleApp
//
//  Created by Gabe Rozenberg on 12-08-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParser.h"

@interface UserProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *table;
    XMLParser *parser;
}

@end
