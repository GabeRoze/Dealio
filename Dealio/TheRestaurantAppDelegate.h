//
//  AppDelegate.h
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-12.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewController;
@class EditProfileViewController;
@class DealListViewController;
@class FiltersViewController;
@class MapViewController;

//@class RegistrationViewController;


@interface TheRestaurantAppDelegate : UIResponder <UIApplicationDelegate>
{
    
//    LoginViewController *loginViewController;

}


-(void)loginSuccess;

@property (weak, nonatomic) IBOutlet MapViewController *mapView;
@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) IBOutlet FiltersViewController *filterView;
@property (weak, nonatomic) IBOutlet DealListViewController *dealListview;
@property (strong, nonatomic) IBOutlet UITabBarController *rootController;
@property (weak, nonatomic) IBOutlet UINavigationController *dealListViewController;

@property (strong, nonatomic) LoginViewController *loginViewController;

@property (strong, nonatomic) EditProfileViewController *editProfileViewController;
//@property (strong, nonatomic) RegistrationViewController *registrationViewController;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *favoritesButton;


- (IBAction)optionsButtonPressed:(id)sender;
- (IBAction)favoritesButtonPressed:(id)sender;


-(void)logoutButtonPressed:(NSNotification*) notification;
-(void)controlBarButtonPressed:(NSNotification*) notification;
-(void) displayLoginPage;

@end
