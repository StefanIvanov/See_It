//
//  mapSIViewController.h
//  SeeIt
//
//  Created by Atanas on 7/26/13.
//  Copyright (c) 2013 Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface mapSIViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>{
    NSArray *rows;
}

//JSON properties
@property (retain, nonatomic) NSArray *rows;
//Map properties
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;

@property (strong, nonatomic) CLLocationManager *myLocation;

@property (strong, nonatomic) CLLocation *currentLocation;

@end
