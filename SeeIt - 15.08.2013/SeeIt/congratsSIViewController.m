//
//  congratsSIViewController.m
//  SeeIt
//
//  Created by Atanas on 7/30/13.
//  Copyright (c) 2013 Pro. All rights reserved.
//

#import "congratsSIViewController.h"

#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>
#import <Foundation/Foundation.h>

@interface congratsSIViewController ()

@end

@implementation congratsSIViewController
@synthesize rows;
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
 	// In "real" code you should surround this with try and catch
 	//connection to JSON database
    NSURL *url = [NSURL URLWithString:@"http://bglive.net/SeeIt/data/getAllPlaces.php"];
    
    NSStringEncoding *encoding = NULL;
    NSError *error2;
    
    
    NSString *connectDB = [[NSString alloc] initWithContentsOfURL:url usedEncoding: encoding error: &error2]; // Pulls the URL
    
 	NSData *jsonData = [connectDB dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    NSError *error = nil;
    
    _dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
 	if (_dict)
 	{
 		rows = [_dict objectForKey:@"places"];
        
    }
    //DB
    
        
  


    ////////
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)postToFacebook:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [facebook setInitialText:[NSString stringWithFormat:@"post to facebook from seeit"]];
        [self presentViewController:facebook animated:YES completion:nil];
        
        [facebook setCompletionHandler:^(SLComposeViewControllerResult result) {
            NSString *output;
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    //output = @"Action Cancelled";
                    break;
                case SLComposeViewControllerResultDone:
                    output = @"Post successful";
                default:
                    break;
            }
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
//            [alert show];
        }];
    }
}

//////////
// Return the number of entries in the array this is the number of rows in our table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [rows count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    NSDictionary *dict = [rows objectAtIndex: indexPath.row];
    
    for (int i=3; i<sizeof(dict); i++) {
        NSLog(@"%@", dict);
    }
    
    
    
    cell.textLabel.text = [dict objectForKey:@"placeName"];
    cell.detailTextLabel.text = [dict objectForKey:@"latitude"];
    
    
    ///for (int i = 0; i <= sizeof(dict) ; i++) {
    //  NSLog(@"%d", i);
    //}
    
    
    
    return cell;
}


@end
