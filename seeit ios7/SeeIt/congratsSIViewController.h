//
//  congratsSIViewController.h
//  SeeIt
//
//  Created by Atanas on 7/30/13.
//  Copyright (c) 2013 Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface congratsSIViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate,UITableViewDataSource>{
    //UItable
    NSArray *rows;
    NSDictionary *_dict;
}
//JSON Properties
@property (retain, nonatomic) NSArray *rows;



@end
