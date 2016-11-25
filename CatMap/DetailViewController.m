//
//  DetailViewController.m
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "DetailViewController.h"
#import "DownloadManager.h"
#import "LocationManager.h"
#import "CatPicture.h"


@interface DetailViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) LocationManager *locationManager;
@property (nonatomic, strong) DownloadManager *downloadManager;
@end

@implementation DetailViewController

static NSString * const kAnnotationViewReuseIdentifier = @"annotationViewRI";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.picture.pictureTitle;
    [self retrieveCoordinates];
    self.downloadManager = [[DownloadManager alloc] init];
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

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:kAnnotationViewReuseIdentifier];
    if (annoView == nil) {
        annoView = [[MKAnnotationView alloc] initWithAnnotation:self.picture reuseIdentifier:kAnnotationViewReuseIdentifier];
        annoView.enabled = YES;
        [self.downloadManager getImage:self.picture.sqUrl completion:^(UIImage *image) {
            annoView.image = image;
        }];
    }
    return annoView;
}


@end
