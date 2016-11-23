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

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.picture.pictureTitle;
}



@end
