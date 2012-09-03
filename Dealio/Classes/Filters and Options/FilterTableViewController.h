//
//  FilterTableViewController.h
//  Dealio
//
//  Created by Gabe Rozenberg on 12-08-18.
//  Copyright (c) 2012 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealListViewController.h"

@interface FilterTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView* table;
    IBOutlet UIImageView *backgroundImage;
}

@end
