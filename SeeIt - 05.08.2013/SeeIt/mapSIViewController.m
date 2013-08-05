//
//  mapSIViewController.m
//  SeeIt
//
//  Created by Atanas on 7/26/13.
//  Copyright (c) 2013 Pro. All rights reserved.
//

#import "mapSIViewController.h"
#import "CJSONDeserializer.h"

#import "MapKit/MapKit.h"

#import "SIAnnotation.h"
#import "CoreLocation/CoreLocation.h"

@interface mapSIViewController ()

@end

@implementation mapSIViewController



@synthesize rows;
@synthesize myMapView;
@synthesize myLocation;


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

	//DB
    //connection
    NSURL *url = [NSURL URLWithString:@"http://bglive.net/SeeIt/data/getAllPlaces.php"];
    
    NSStringEncoding *encoding = NULL;
    NSError *error2;
    
    
    NSString *connectDB = [[NSString alloc] initWithContentsOfURL:url usedEncoding: encoding error: &error2]; // Pulls the URL
	//NSLog(connectDB); // Look at the console and you can see what the restults are
    
 	NSData *jsonData = [connectDB dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    NSError *error = nil;
    
 	// In "real" code you should surround this with try and catch
 	NSDictionary * dict = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
 	if (dict)
 	{
 		rows = [dict objectForKey:@"places"];
        
    }
    //DB
    
    //Map
    self.myMapView.showsUserLocation=YES;
    self.myMapView.delegate = self;
    [self.myMapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    
    //Annotation
    NSMutableArray * locations = [[NSMutableArray alloc] init];
    
    for (int i = 0;  i < rows.count; i++)
    {
        CLLocationCoordinate2D location;
        SIAnnotation * myAnn = [[SIAnnotation alloc]init];
        location.latitude = [[rows[i] objectForKey:@"latitude"] floatValue];
        location.longitude = [[rows[i] objectForKey:@"longitude"] floatValue];
        myAnn.coordinate = location;
        myAnn.title = [rows[i] objectForKey:@"placeName"];
        myAnn.subtitle = @"Info";
        
        [locations addObject:myAnn];
    }
    
    [self.myMapView addAnnotations:locations];
    
    //Current location positioning
    myLocation = [[CLLocationManager alloc]init];
    myLocation.delegate = self;
    myLocation.desiredAccuracy = kCLLocationAccuracyBest;
    
    //refresh current location
    myLocation.distanceFilter = 5;
    
    
    
    [myLocation startUpdatingLocation];
    
    //Map

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
//Overlay setup


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //Change Annotation pin
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView* pinView = [[MKPinAnnotationView alloc]
                                    initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    pinView.animatesDrop=YES;
    pinView.canShowCallout=YES;
    //pinView.pinColor= MKPinAnnotationColorGreen; // giving the pin color
    pinView.enabled = YES;
    pinView.canShowCallout = YES;
    
    //Pin image
    pinView.image=[UIImage imageNamed:@"pin7.png"]; //giving the image
    
    return pinView;
    
}



@end
