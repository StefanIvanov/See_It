//
//  mainSIViewController.m
//  SeeIt
//
//  Created by Atanas on 7/23/13.
//  Copyright (c) 2013 Pro. All rights reserved.
//

#import "mainSIViewController.h"
#import "ECSlidingViewController.h"
#import "menuSIViewController.h"
#import "CJSONDeserializer.h"

@interface mainSIViewController ()

@end

@implementation mainSIViewController 

@synthesize menuBtn;
@synthesize updateTimer;
@synthesize currentTime;
@synthesize clocklbl;
//location
@synthesize city;
@synthesize country;
@synthesize locationManager;
@synthesize geoCoder;

//weather
@synthesize weatherLbl;

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
    
    
        //chech for internet connectivity
    [self checkForWIFIConnection];
        
    
    [self updateTime];
	self.view.layer.shadowOpacity = 0.05f;
    self.view.layer.shadowRadius = 0.5f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[menuSIViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"menu"];
    }
    
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    
    self.menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(8, 10, 34, 24);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.menuBtn];
    
    //location
    //locationManager.delegate=self;
    
    //Get user location
    [locationManager startUpdatingLocation];
    
    //Geocoding Block
    [self.geoCoder reverseGeocodeLocation: locationManager.location completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         
         //Get nearby address
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         //String to hold address
         //NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@" "];
         NSLog(@"Country: %@", placemark.locality);
         NSLog(@"Country: %@", placemark.country);
         
         
         
         //Set the label text to current location
         //[locationLabel setText:locatedAt];
         city.text = [NSString stringWithFormat: @"%@", placemark.locality];
         country.text = [NSString stringWithFormat: @"%@", placemark.country];

    
    //weather DataBase JSON
    
    //connection
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@,fr&units=metric", placemark.locality]];
    //NSURL *url = [NSURL URLWithString:@"http://bglive.net/SeeIt/getAllPlaces.php"];
    
    NSStringEncoding *encoding = NULL;
    NSError *error2;
    
    
    NSString *connectDB = [[NSString alloc] initWithContentsOfURL:url usedEncoding: encoding error: &error2]; // Pulls the URL
	//NSLog(connectDB); // Look at the console and you can see what the restults are
    
 	NSData *jsonData = [connectDB dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    NSError *error3 = nil;
    
 	// In "real" code you should surround this with try and catch
 	NSDictionary * dict = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error3];
 	if (dict)
 	{
 		rows = [dict objectForKey:@"main"];
        
        
 	}
    
                 
    weatherLbl.text = [NSString stringWithFormat:@"%d°", (int)[[rows objectForKey:@"temp"]floatValue]];
    //weather DataBase JSON
    
     }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}
//clock
- (void)updateTime {
    
    // Without this, the timer would never be erased from the code.
    // This would cause a memory overload.
    [updateTimer invalidate];
    updateTimer = nil;
    
    currentTime = [NSDate date];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setTimeStyle:NSDateFormatterShortStyle];
    clocklbl.text = [timeFormatter stringFromDate:currentTime];
    
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}
//checking for internet connection and if it doesnt shows a alert
- (void)checkForWIFIConnection {
    Reachability* wifiReach = [Reachability reachabilityForLocalWiFi];
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    if (netStatus!=ReachableViaWiFi)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Require Wifi connection!", @"AlertView")
                                                            message:NSLocalizedString(@"You have no wifi connection available.", @"AlertView")
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Cancel", @"AlertView")
                                                  otherButtonTitles:NSLocalizedString(@"Open settings", @"AlertView"), nil];
        [alertView show];
    }
}

@end
