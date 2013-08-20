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

@property (strong, nonatomic) IBOutlet UIButton *typebuttonChurch;
@property (strong, nonatomic) IBOutlet UIButton *typebuttonMonument;
@property (strong, nonatomic) IBOutlet UIButton *typebuttonMuseum;
@property (strong, nonatomic) IBOutlet UIButton *typebuttonPark;
- (IBAction)showPlacePressed:(id)sender;

//slider
@property (strong, nonatomic) IBOutlet UISlider *radiusSlider;
@property (strong, nonatomic) IBOutlet UILabel *radiusLbl;

- (IBAction) sliderValueChanged:(id)sender;

@end
