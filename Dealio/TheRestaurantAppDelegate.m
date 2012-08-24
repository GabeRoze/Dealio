//
//  AppDelegate.m
//  The Restaurant
//
//  Created by Gabe Rozenberg on 11-12-12.
//  Copyright (c) 2011 University of Waterloo. All rights reserved.
//

#import "TheRestaurantAppDelegate.h"
#import "LoginViewController.h"
#import "DealListViewController.h"
#import "FiltersViewController.h"
#import "EditProfileViewController.h"
#import "UserManager.h"
#import "ImageCache.h"
#import "CalculationHelper.h"
#import "MapViewController.h"
//#import "RegistrationViewController.h"


@implementation TheRestaurantAppDelegate
@synthesize favoritesButton;

@synthesize window = _window;
@synthesize mapView;
@synthesize filterView;
@synthesize dealListview;
@synthesize rootController;
@synthesize dealListViewController;
@synthesize loginViewController;
@synthesize editProfileViewController;
//@synthesize registrationViewController;
//@synthesize tabBarController;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //Use this NIB file for the tab bar controller as the main window


    // User Manager
    UserManager* userManager = [[UserManager alloc] init];
    ImageCache* imageCache = [[ImageCache alloc] init];


//    [[UINavigationBar appearance] setBackground:[UIImage imageNamed:@"topnav.png"
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topnav.png"] forBarMetrics:UIBarMetricsDefault];
//    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    [image setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_teal_light.png"]]];
//    [[UINavigationBar appearance] setBackgroundImage:image.image forBarMetrics:UIBarMetricsDefault];


    // Notifications

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logoutButtonPressed:)
                                                 name:@"logoutButtonPressed"
                                               object:nil];



    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(controlBarButtonPressed:)
                                                 name:@"controlBarButtonPressed"
                                               object:nil];

    // end notifications
    [[NSBundle mainBundle] loadNibNamed:@"TabBarController" owner:self options:nil];
    [self.window addSubview:rootController.view];

    //create the login view controller and instantiate as a modal view controller
    //loginViewController = [[LoginViewController alloc] init];
    editProfileViewController = [[EditProfileViewController alloc] init];
    // registrationViewController = [[RegistrationViewController alloc] init];
    //[self.rootController presentModalViewController:loginViewController animated:NO];

    [self displayLoginPage];

    //self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];

    UILabel* dealListLabel = [CalculationHelper createNavBarLabelWithTitle:@"Dealio"];
    [dealListview.view addSubview:dealListLabel];
    UILabel* filterLabel = [CalculationHelper createNavBarLabelWithTitle:@"Filters"];
    [filterView.view addSubview:filterLabel];
    UILabel* mapLabel = [CalculationHelper createNavBarLabelWithTitle:@"Map"];
    [mapView.view addSubview:mapLabel];

    return YES;
}

-(void)loginSuccess
{
    [self.rootController setSelectedIndex:2];
    [self.rootController dismissModalViewControllerAnimated:YES];
}

-(void)logoutButtonPressed:(NSNotification*) notification
{
    [self displayLoginPage];
}

-(void) displayLoginPage
{
    loginViewController = nil;
    loginViewController = [[LoginViewController alloc] init];
    [self.rootController presentModalViewController:loginViewController animated:NO];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    [[UserManager sharedManager] saveData];

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    [[UserManager sharedManager] saveData];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */

    [[UserManager sharedManager] saveData];

}

- (IBAction)optionsButtonPressed:(id)sender
{
    //create options menu
    //use modal controller
    //allow user to logout with bottom prompt
    //if user logs out, create
    [self.rootController presentModalViewController:editProfileViewController animated:YES];
}

- (IBAction)favoritesButtonPressed:(id)sender
{
    // DealListViewController* controller = (DealListViewController*)[rootController.viewControllers objectAtIndex:1];
    // [controller temp];
    NSLog(@"faves");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"favoritesButtonPressed" object:self];
    favoritesButton.style = UIBarButtonItemStyleDone;
}

-(void)controlBarButtonPressed:(NSNotification*) notification
{
    favoritesButton.style = UIBarButtonItemStyleBordered;
}

@end
