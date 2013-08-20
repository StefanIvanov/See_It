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

@interface menuSIViewController : UIViewController{
    BOOL checked;
}




//facebook name

@property (weak, nonatomic) IBOutlet UIButton *typebuttonChurch;
- (IBAction)typebuttonChurch:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *typebuttonMonument;
- (IBAction)typebuttonMonument:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *typebuttonMuseum;
- (IBAction)typebuttonMuseum:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *typebuttonPark;
- (IBAction)typebuttonPark:(id)sender;

- (IBAction)showPlacePressed:(id)sender;

//slider
@property (strong, nonatomic) IBOutlet UISlider *radiusSlider;
@property (strong, nonatomic) IBOutlet UILabel *radiusLbl;

- (IBAction) sliderValueChanged:(id)sender;

@end
