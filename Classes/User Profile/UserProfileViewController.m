//
//  UserProfileViewController.m
//  TableExampleApp
//
//  Created by Gabe Rozenberg on 12-08-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserProfileNameCell.h"
#import "TableFooterCell.h"
#import "ProfileDataCell.h"
#import "ThreeButtonTableCell.h"
#import "GRCustomSpinnerView.h"


@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:YES];

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
        userProfileNameCell.nameLabel.text = @"hi Gabe Rozenberg!";
        [userProfileNameCell.nameLabel setFont:[UIFont fontWithName:@"Eurofurenceregular" size:26]];

        userProfileNameCell.emailLabel.text = @"(gebe1987@gmail.com)";

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

        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_favorite.png"];
        profileDataCell.textLabel.text = @"Favorited 4 deals";

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

        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_comment.png"];
        profileDataCell.textLabel.text = @"Commented 3 times";

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

        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_love.png"];
        profileDataCell.textLabel.text = @"Loved 9 deals";

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

        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_checkin.png"];
        profileDataCell.textLabel.text = @"Checked in at 0 restaurants";

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

        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_share.png"];
        profileDataCell.textLabel.text = @"Shared 0 times";

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

        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_tipus.png"];
        profileDataCell.textLabel.text = @"Tipped us 5 deals";

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

        profileDataCell.leftImage.image = [UIImage imageNamed:@"button_points.png"];
        profileDataCell.textLabel.text = @"You have a total of 530 points";

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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 12)
    {
//        [GRCustomSpinnerView.instance addSpinnerToView:self.view];
        //call logout
        //upon success load the login view
    }
}

@end
