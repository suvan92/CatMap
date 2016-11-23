//
//  LocationManager.m
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

-(void)getPictureLocationData:(NSNumber *)pictureId completion:(void (^)(CLLocationCoordinate2D))completion {
    NSString *picIDstring = [pictureId stringValue];
    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=a7e8eeb660518f4cb05325751027181d&photo_id=%@&format=json&nojsoncallback=1", picIDstring];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSDictionary *photoDict = jsonDict[@"photo"];
        NSDictionary *locationDict = photoDict[@"location"];
        NSNumber *latitude = locationDict[@"latitude"];
        NSNumber *longitude = locationDict[@"longitude"];
        
        double latDouble = [latitude doubleValue];
        double lonDouble = [longitude doubleValue];
        
        CLLocationCoordinate2D coordinates =  CLLocationCoordinate2DMake(latDouble, lonDouble);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(coordinates);
        }];
        
        
    }];
    [dataTask resume];
}

@end
