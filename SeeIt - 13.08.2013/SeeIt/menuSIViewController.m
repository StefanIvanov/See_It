//
//  menuSIViewController.m
//  SeeIt
//
//  Created by Atanas on 7/23/13.
//  Copyright (c) 2013 Pro. All rights reserved.
//

#import "menuSIViewController.h"
#import "SIAppDelegate.h"
#import "ECSlidingViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Social/Social.h>
#import <Accounts/ACAccountType.h>
#import <Accounts/ACAccountCredential.h>
#import <FacebookSDK/FacebookSDK.h>
#import "mapSIViewController.h"

@interface menuSIViewController () <FBLoginViewDelegate>

@property (strong, nonatomic) NSArray *menu;

//facebook
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePic;

@property (strong, nonatomic) IBOutlet UILabel *labelFirstName;
@property (strong, nonatomic) IBOutlet UILabel *labelSurname;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;



@end

@implementation menuSIViewController
@synthesize menu;

@synthesize labelSurname = _labelSurname;
@synthesize labelFirstName = _labelFirstName;
@synthesize loggedInUser = _loggedInUser;

//checkbox button
@synthesize typebuttonChurch, typebuttonMonument, typebuttonMuseum, typebuttonPark;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

	self.menu = [NSArray arrayWithObjects:@"main", @"result", nil];
    
    
    [self.slidingViewController setAnchorRightRevealAmount:265.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    
    
    [super viewDidLoad];
    
    // Create Login View so that the app will be granted "status_update" permission.
    FBLoginView *loginview = [[FBLoginView alloc] init];
    
    loginview.frame = CGRectOffset(loginview.frame, 105, 5);
    loginview.delegate = self;
    
    [self.view addSubview:loginview];
    
    [loginview sizeToFit];
      }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.menu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.menu objectAtIndex:indexPath.row]];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    NSString *identifier = [NSString stringWithFormat:@"%@", [self.menu objectAtIndex:indexPath.row]];
    
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
    
    
}




#pragma mark Template generated code

- (void)viewDidUnload
{
    self.labelSurname = nil;
    self.labelFirstName = nil;
    self.loggedInUser = nil;
    self.profilePic = nil;
    
    [super viewDidUnload];
}
//F

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - FBLoginViewDelegate

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    self.labelFirstName.text = [NSString stringWithFormat:@"%@", user.first_name];
    self.labelSurname.text = [NSString stringWithFormat:@"%@", user.last_name];
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    [_profilePic setHidden:NO];

    _profilePic.profileID = user.id;
    self.loggedInUser = user;
    [loginView setTransform:CGAffineTransformMakeScale(0.6, 0.6)];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    // test to see if we can use the share dialog built into the Facebook application
    FBShareDialogParams *p = [[FBShareDialogParams alloc] init];
    p.link = [NSURL URLWithString:@"http://developers.facebook.com/ios"];
#ifdef DEBUG
    [FBSettings enableBetaFeatures:FBBetaFeaturesShareDialog];
#endif
    [_profilePic setHidden:YES];
    //self.profilePic.profileID = nil;
    self.labelFirstName.text = nil;
    self.labelSurname.text = nil;
    self.loggedInUser = nil;
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
}

#pragma mark -

// Convenience method to perform some action that requires the "publish_actions" permissions.
- (void) performPublishAction:(void (^)(void)) action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions"]
                                              defaultAudience:FBSessionDefaultAudienceFriends
                                            completionHandler:^(FBSession *session, NSError *error) {
                                                if (!error) {
                                                    action();
                                                }
                                                //For this example, ignore errors (such as if user cancels).
                                            }];
    } else {
        action();
    }
    
}

//Type Buttons
#pragma TypeButtonChurch

-(IBAction)typebuttonChurch:(id)sender{
    typebuttonChurch.selected = !typebuttonChurch.selected;
    UIImage *typebuttonChurchImg = nil;
    if (typebuttonChurch.selected) {
        typebuttonChurchImg = [UIImage imageNamed:@"Church-type_white.png"];
    }   else {
        typebuttonChurchImg = [UIImage imageNamed:@"Church-type_orange.png"];
    }
    [((UIButton*)sender) setImage:typebuttonChurchImg forState:UIControlStateNormal];
    
    
}
#pragma TypeButtonMomument

-(IBAction)typebuttonMonument:(id)sender{
    typebuttonMonument.selected = !typebuttonMonument.selected;
    UIImage *typebuttonMomumentImg = nil;
    if (typebuttonMonument.selected) {
        typebuttonMomumentImg = [UIImage imageNamed:@"Monument-type_white.png"];
    }   else {
        typebuttonMomumentImg = [UIImage imageNamed:@"Monument-type_orange.png"];
    }
    [((UIButton*)sender) setImage:typebuttonMomumentImg forState:UIControlStateNormal];
    
    
}
#pragma TypeButtonChurch

-(IBAction)typebuttonMuseum:(id)sender{
    typebuttonMuseum.selected = !typebuttonMuseum.selected;
    UIImage *typebuttonMuseumImg = nil;
    if (typebuttonMuseum.selected) {
        typebuttonMuseumImg = [UIImage imageNamed:@"Museum-type_white.png"];
    }   else {
        typebuttonMuseumImg = [UIImage imageNamed:@"Museum-type_orange.png"];
    }
    [((UIButton*)sender) setImage:typebuttonMuseumImg forState:UIControlStateNormal];
    
    
}
#pragma TypeButtonChurch

-(IBAction)typebuttonPark:(id)sender{
    typebuttonMuseum.selected = !typebuttonMuseum.selected;
    UIImage *typebuttonParkImg = nil;
    if (typebuttonMuseum.selected) {
        typebuttonParkImg = [UIImage imageNamed:@"Park-type_white.png"];
    }   else {
        typebuttonParkImg = [UIImage imageNamed:@"Park-type_orange.png"];
    }
    [((UIButton*)sender) setImage:typebuttonParkImg forState:UIControlStateNormal];
    
    
}

#pragma Animation
- (IBAction)showPlacePressed:(id)sender
{
    mapSIViewController *mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"map"];
    [self presentViewController:mapVC animated:YES completion:nil];
}
@end
