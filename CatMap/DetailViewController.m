//
//  DetailViewController.m
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "DetailViewController.h"
#import "LocationManager.h"
#import "CatPicture.h"


@interface DetailViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) LocationManager *locationManager;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.picture.pictureTitle;
    [self retrieveCoordinates];
    
    
}

-(void)retrieveCoordinates {
    self.locationManager = [[LocationManager alloc] init];
    [self.locationManager getPictureLocationData:self.picture completion:^(CLLocationCoordinate2D coordinates){
        self.picture.coordinate = coordinates;
        [self drawMap];
    }];
}

- (void)drawMap {
    MKCoordinateSpan span = MKCoordinateSpanMake(0.5f, 0.5f);
    self.mapView.region = MKCoordinateRegionMake(self.picture.coordinate, span);
    [self.mapView addAnnotation:self.picture];
}



@end
