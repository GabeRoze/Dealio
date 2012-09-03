//
//  UserProfileViewController.m
//  TableExampleApp
//
//  Created by Gabe Rozenberg on 12-08-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "UserProfileViewController.h"
#import "UserProfileNameCell.h"
#import "TableFooterCell.h"
#import "ProfileDataCell.h"
#import "ThreeButtonTableCell.h"
#import "ChangePasswordViewController.h"
#import "GRCustomSpinnerView.h"
#import "XMLElement.h"
#import "TheRestaurantAppDelegate.h"
#import "LoginViewController.h"
#import "DealioService.h"
#import "Models.h"
#import "CalculationHelper.h"

@implementation UserProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:YES];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(presentChangePasswordView) name:@"presentChangePasswordView" object:nil];
    
    topBackgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_teal_light.png"]];
    
    bottomBackgroundImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_tan_light.png"]];



    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [GRCustomSpinnerView.instance addSpinnerToView:self.view];

    self.navigationController.navigationBarHidden = YES;
    [DealioService getUserProfileWithSuccess:^(NSData *data){

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            parser = [[XMLParser alloc] initXMLParser:data];
            NSLog(@"parser data %@",parser.userFunction);
            dispatch_async( dispatch_get_main_queue(), ^{
                [GRCustomSpinnerView.instance stopSpinner];
                [table reloadData];
            });
        });
    }
            andFailure:^{
                [GRCustomSpinnerView.instance stopSpinner];
                //
            }];
}

-(void)presentChangePasswordView
{
    changePasswordViewController = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
    CGRect frame = changePasswordViewController.view.frame;
    frame.origin.y = -self.view.frame.size.height;
    changePasswordViewController.view.frame = frame;
    changePasswordViewController.view.alpha = 0;
    [self.view addSubview:changePasswordViewController.view];

    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        CGRect rect = changePasswordViewController.view.frame;
        rect.origin.y = 0;
        changePasswordViewController.view.frame = rect;
        changePasswordViewController.view.alpha = 1.0;
    } completion:^(BOOL finished){
        [changePasswordViewController.currentPasswordTextField becomeFirstResponder];
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 13;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";

    if (indexPath.row == 0)
    {
        CellIdentifier = @"UserProfileNameCellIdentifier";

        UserProfileNameCell *userProfileNameCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!userProfileNameCell)
        {
            userProfileNameCell = [UserProfileNameCell new];
        }
        NSString *firstName = [parser.userFunction objectForKey:@"userfirstname"];
        NSString *lastName = [parser.userFunction objectForKey:@"userlastname"];
        [userProfileNameCell.nameLabel setFont:[UIFont fontWithName:@"Eurofurenceregular" size:26]];

        if (firstName.length < 1)
        {
            firstName = @"";
            lastName = @"";
        }

        userProfileNameCell.nameLabel.text = [NSString stringWithFormat:@"hi %@ %@!", firstName, lastName];
        userProfileNameCell.emailLabel.text = [NSString stringWithFormat:@"(%@)", UserData.instance.email];

        return userProfileNameCell;
    }
    else if (indexPath.row == 1)
    {
        CellIdentifier = @"TableFooterCell";

        TableFooterCell *tableFooterCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!tableFooterCell)
        {
            tableFooterCell = [TableFooterCell new];
        }

        tableFooterCell.backgroundImageView.image = [UIImage imageNamed:@"divider_teal_tan.png"];

        return tableFooterCell;
    }
    else if (indexPath.row == 2)
    {
        CellIdentifier = @"ProfileDataCell";

        ProfileDataCell *profileDataCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!profileDataCell)
        {
            profileDataCell = [ProfileDataCell new];
        }

        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_statistics.png"];
        profileDataCell.textLabel.text = @"Statistics";

        return profileDataCell;
    }
    else if (indexPath.row == 3)
    {
        CellIdentifier = @"ProfileDataCell";

        ProfileDataCell *profileDataCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!profileDataCell)
        {
            profileDataCell = [ProfileDataCell new];
        }

        NSString *numFavorited = [parser.userFunction objectForKey:@"userfavoritedcount"];

        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_favorite.png"];
        numFavorited = [CalculationHelper checkStringNull:numFavorited];
        profileDataCell.textLabel.text = [NSString stringWithFormat:@"Favorited %@ deals", numFavorited];

        return profileDataCell;
    }
    else if (indexPath.row == 4)
    {
        CellIdentifier = @"ProfileDataCell";

        ProfileDataCell *profileDataCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!profileDataCell)
        {
            profileDataCell = [ProfileDataCell new];
        }
        NSString *numCommented = [parser.userFunction objectForKey:@"usercommentcount"];
        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_comment.png"];
        numCommented = [CalculationHelper checkStringNull:numCommented];
        profileDataCell.textLabel.text = [NSString stringWithFormat:@"Commented %@ times", numCommented];

        return profileDataCell;

    }
    else if (indexPath.row == 5)
    {
        CellIdentifier = @"ProfileDataCell";

        ProfileDataCell *profileDataCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!profileDataCell)
        {
            profileDataCell = [ProfileDataCell new];
        }
        NSString *numLiked = [parser.userFunction objectForKey:@"userlikecount"];
        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_love.png"];
        numLiked = [CalculationHelper checkStringNull:numLiked];
        profileDataCell.textLabel.text = [NSString stringWithFormat:@"Loved %@ deals", numLiked];

        return profileDataCell;
    }
    else if (indexPath.row == 6)
    {
        CellIdentifier = @"ProfileDataCell";

        ProfileDataCell *profileDataCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!profileDataCell)
        {
            profileDataCell = [ProfileDataCell new];
        }

        NSString *numChecked = [parser.userFunction objectForKey:@"usercheckedincount"];
        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_checkin.png"];
        numChecked = [CalculationHelper checkStringNull:numChecked];
        profileDataCell.textLabel.text = [NSString stringWithFormat:@"Checked in at %@ restaurants", numChecked];

        return profileDataCell;
    }
    else if (indexPath.row == 7)
    {
        CellIdentifier = @"ProfileDataCell";

        ProfileDataCell *profileDataCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!profileDataCell)
        {
            profileDataCell = [ProfileDataCell new];
        }

        NSString *numShared = [parser.userFunction objectForKey:@"usersharecount"];
        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_share.png"];
        numShared = [CalculationHelper checkStringNull:numShared];
        profileDataCell.textLabel.text = [NSString stringWithFormat:@"Shared %@ times", numShared];

        return profileDataCell;
    }
    else if (indexPath.row == 8)
    {
        CellIdentifier = @"ProfileDataCell";

        ProfileDataCell *profileDataCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!profileDataCell)
        {
            profileDataCell = [ProfileDataCell new];
        }

        NSString *numTipped = [parser.userFunction objectForKey:@"usertipcount"];
        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_tipus.png"];
        numTipped = [CalculationHelper checkStringNull:numTipped];
        profileDataCell.textLabel.text = [NSString stringWithFormat:@"Tipped us %@ deals", numTipped];

        return profileDataCell;
    }
    else if (indexPath.row == 9)
    {
        CellIdentifier = @"ProfileDataCell";

        ProfileDataCell *profileDataCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!profileDataCell)
        {
            profileDataCell = [ProfileDataCell new];
        }

        NSString *numPoints = [parser.userFunction objectForKey:@"userpoint"];
        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_points.png"];
        numPoints = [CalculationHelper checkStringNull:numPoints];
        profileDataCell.textLabel.text = [NSString stringWithFormat:@"You have a total of %@ points", numPoints];

        return profileDataCell;
    }
    else if (indexPath.row == 10)
    {
        CellIdentifier = @"TableFooterCell";

        TableFooterCell *tableFooterCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!tableFooterCell)
        {
            tableFooterCell = [TableFooterCell new];
        }

        tableFooterCell.backgroundImageView.image = [UIImage imageNamed:@"divider_tan_tan.png"];

        return tableFooterCell;
    }
    else if (indexPath.row == 11)
    {
        CellIdentifier = @"ThreeButtonTableCellIdentifier";

        ThreeButtonTableCell *threeButtonTableCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!threeButtonTableCell)
        {
            threeButtonTableCell = [ThreeButtonTableCell new];
        }

        [threeButtonTableCell setUserInteractionEnabled:YES];
        return threeButtonTableCell;
    }
    else if (indexPath.row == 12)
    {
        CellIdentifier = @"ProfileDataCell";

        ProfileDataCell *profileDataCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!profileDataCell)
        {
            profileDataCell = [ProfileDataCell new];
        }

        [profileDataCell setUserInteractionEnabled:YES];
        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_logout.png"];
        profileDataCell.textLabel.text = @"Logout";

        return profileDataCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 100;
    }
    else if (indexPath.row == 1 || indexPath.row == 10)
    {
        return 20;
    }
    else if (indexPath.row >= 2 && indexPath.row <= 9 || indexPath.row >= 12)
    {
        return 44;
    }
    else if (indexPath.row == 11)
    {
        return 120;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (indexPath.row == 12)
    {
//        [GRCustomSpinnerView.instance addSpinnerToView:self.view];
        //call logout
        //upon success load the login view
        LoginViewController *loginViewController = [LoginViewController new];
        [self presentModalViewController:loginViewController animated:YES];

    }
}

@end
