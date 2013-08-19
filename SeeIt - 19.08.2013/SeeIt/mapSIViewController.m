//
//  mapSIViewController.m
//  SeeIt
//
//  Created by Atanas on 7/26/13.
//  Copyright (c) 2013 Pro. All rights reserved.
//

#import "mapSIViewController.h"

#import "MapKit/MapKit.h"
#import <AudioToolbox/AudioToolbox.h>

#import "SIAnnotation.h"
#import "CoreLocation/CoreLocation.h"
#import "infoSIViewController.h"
#import "menuSIViewController.h"


@interface mapSIViewController (){
    NSDictionary *_dict;
}

//info button annotation
@property (nonatomic, retain) UIButton *info;

@end

@implementation mapSIViewController


@synthesize rows;
@synthesize myMapView;
@synthesize myLocation;
@synthesize info = _info;
@synthesize currentLocation;



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
    
    [self myLocation];
    [self initializeLocationUpdates];
    
   
    
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
    
    
    //Map show user location
    self.myMapView.showsUserLocation=YES;
    self.myMapView.delegate = self;
    [self.myMapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    //Current location positioning
    myLocation = [[CLLocationManager alloc]init];
    myLocation.delegate = self;
    myLocation.desiredAccuracy = kCLLocationAccuracyBest;
    
    //refresh current location
    myLocation.distanceFilter = 2;
    
    
    //Annotation and region
    //Array which create location annotation and gets coordinates
    NSMutableArray * locations = [[NSMutableArray alloc] init];
    NSMutableArray *regionLocations = [[NSMutableArray alloc] init];
    
    for (int i = 0;  i < rows.count; i++)
    {
        CLLocationCoordinate2D location;
        SIAnnotation * myAnn = [[SIAnnotation alloc]init];
        location.latitude = [[rows[i] objectForKey:@"latitude"] floatValue];
        location.longitude = [[rows[i] objectForKey:@"longitude"] floatValue];
        myAnn.coordinate = location;
        myAnn.title = [rows[i] objectForKey:@"placeName"];
        myAnn.subtitle = @"Info";
        
        //region Value
        //        CLLocationDistance regionRadius = [[rows[i] valueForKey:@"radius"] doubleValue];

        [locations addObject:myAnn];
        
        //create and add regions
        CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:location radius:20 identifier:[rows[i] objectForKey:@"placeName"]]; //regionRadius instead of fixed value
        [regionLocations addObject:region];
        
           }

    [self.myMapView addAnnotations:locations];
    [self initializeRegionMonitoring:regionLocations];
    

    
    //Current location positioning
    myLocation = [[CLLocationManager alloc]init];
    myLocation.delegate = self;
    myLocation.desiredAccuracy = kCLLocationAccuracyBest;
    
    //refresh current location(GPS)
    myLocation.distanceFilter = 5;
    
    [myLocation startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Creating custom annotations
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView* pinView = [[MKPinAnnotationView alloc]
                                    initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    pinView.animatesDrop=YES;
    pinView.canShowCallout=YES;
    pinView.enabled = YES;
    pinView.canShowCallout = YES;
    
    //Annotation Button + AlertView
    pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    self.info = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    self.info.exclusiveTouch = YES;
    self.info.enabled = YES;
    [self.info addTarget: self
                       action: @selector(calloutAccessoryTapped)
                    forControlEvents: UIControlEventTouchUpInside | UIControlEventTouchCancel];
    //[self addSubview:self.info];

    //Pin image
    pinView.image =[UIImage imageNamed:@"seeit-pin.png"];
    pinView.frame = CGRectMake(0, 0, 24, 35);
    //callout positioning
    pinView.calloutOffset = CGPointMake(2, -1);
    
    return pinView;
    
}
//Annotation button Actions
- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control {
    
    infoSIViewController *infoCon = [self.storyboard instantiateViewControllerWithIdentifier:@"info"];
    for (NSDictionary *entry in rows) {
        if ([[entry objectForKey:@"placeName"] isEqual:((SIAnnotation *)view.annotation).title]) {
            [infoCon loadInfoForKey:[entry objectForKey:@"id"]];
            break;
        }
    }
    
    [self presentViewController:infoCon animated:YES completion:nil];
}


////GeoFence
- (void)initializeLocationUpdates {
    [myLocation startUpdatingLocation];
}
- (void)initializeLocationManager {
    // Check to ensure location services are enabled
    //    if(![CLLocationManager locationServicesEnabled]) {
    //        [self showAlertWithMessage:@"You need to enable location services to use this app."];
    //        return;
    //    }
    
    myLocation = [[CLLocationManager alloc] init];
    myLocation.delegate = self;
}
- (void) initializeRegionMonitoring:(NSMutableArray*)locations {
    
    if (myLocation == nil) {
        [NSException raise:@"Location Manager Not Initialized" format:@"You must initialize location manager first."];
    }
    
    if(![CLLocationManager regionMonitoringAvailable]) {
        //    [NSLog(@"This app requires region monitoring features which are unavailable on this device.")];
        return;
    }
    
    for(CLRegion *location in locations) {
        [myLocation startMonitoringForRegion:location];
    }
    
}
- (void)locationManager:(CLLocationManager *)myLocation didEnterRegion:(CLRegion *)region {
    NSLog(@"Entered Region - %@", region.identifier);
    [self showRegionAlert:@"Entering Region" forRegion:region.identifier];
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
   // NSLog(@"Exited Region - %@", region.identifier);
}
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    NSLog(@"Started monitoring %@ region", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
}
- (void) showRegionAlert:(NSString *)alertText forRegion:(NSString *)regionIdentifier {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:alertText
                                                      message:regionIdentifier
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}



@end
