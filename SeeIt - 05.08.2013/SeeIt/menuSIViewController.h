//
//  menuSIViewController.h
//  SeeIt
//
//  Created by Atanas on 7/23/13.
//  Copyright (c) 2013 Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/ACAccountStore.h>
#import <Accounts/ACAccount.h>

#import <FacebookSDK/FacebookSDK.h>

@interface menuSIViewController : UIViewController



//facebook name

@property (strong, nonatomic) IBOutlet UIButton *typebutton;
- (IBAction)showPlacePressed:(id)sender;


@end
