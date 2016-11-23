//
//  ShowAllViewController.m
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-23.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import "ShowAllViewController.h"
#import "LocationManager.h"
#import "CatPicture.h"

@interface ShowAllViewController () <MKMapViewDelegate>

@property (nonatomic) LocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ShowAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[LocationManager alloc] init];
    [self retrieveCoordinates:self.listOfPictures];
    
}

- (void)retrieveCoordinates:(NSArray *)arrayOfPics {
    for (CatPicture *picture in arrayOfPics) {
        [self.locationManager getPictureLocationData:picture completion:^(CLLocationCoordinate2D coordinates) {
            picture.coordinate = coordinates;
            [self drawMap];
        }];
    }
}

- (void)drawMap {
    [self.mapView addAnnotations:self.listOfPictures];
}


@end



//-(void)getPictureLocationData:(CatPicture *)picture completion:(void (^)(CLLocationCoordinate2D))completion;
