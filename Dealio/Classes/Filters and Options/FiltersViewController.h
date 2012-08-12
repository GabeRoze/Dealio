//
//  FiltersViewController.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-13.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//


@class EditProfileViewController;

#import <UIKit/UIKit.h>



@interface FiltersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

//array of 2nd level contorllers
@property (strong, nonatomic) NSArray* controllers;
@property (strong, nonatomic) EditProfileViewController *editProfileViewController;

- (IBAction)userProfileButtonPressed:(id)sender;


@end
