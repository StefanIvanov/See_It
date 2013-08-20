//
//  mainSIViewController.h
//  SeeIt
//
//  Created by Atanas on 7/23/13.
//  Copyright (c) 2013 Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


#import "Reachability.h"
@interface mainSIViewController : UIViewController  <CLLocationManagerDelegate, UIAlertViewDelegate>
{
   
    //weather
    NSMutableDictionary *rows;
}
//weather
@property (retain, nonatomic) NSMutableDictionary *rows;
@property (strong, nonatomic) IBOutlet UILabel *weatherLbl;



@property (strong, nonatomic) IBOutlet UIButton *menuBtn;

//clock
@property (weak, nonatomic) IBOutlet UILabel *clocklbl;
@property    NSDate *currentTime;
@property   NSTimer *updateTimer;

//location
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *country;

@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;


//@property (strong, nonatomic) IBOutlet NSObject *geoCoder2;
@property (strong, nonatomic) IBOutlet CLGeocoder *geoCoder;


- (void)checkForWIFIConnection;

@end
