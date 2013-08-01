//
//  SIAnnotation.h
//  SeeIt
//
//  Created by Atanas on 7/26/13.
//  Copyright (c) 2013 Pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SIAnnotation : NSObject <MKAnnotation>

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString * title;
@property(nonatomic, copy) NSString * subtitle;


@end
