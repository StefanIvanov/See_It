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
@interface congratsSIViewController ()

@end

@implementation congratsSIViewController

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
	// Do any additional setup after loading the view.
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
                    output = @"Action Cancelled";
                    break;
                case SLComposeViewControllerResultDone:
                    output = @"Post successful";
                default:
                    break;
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}



@end
