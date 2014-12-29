//
//  TPLocationViewController.m
//  Down
//
//  Created by Tyler Pfaff on 12/28/14.
//
//

#import <Foundation/Foundation.h>
#import "TPLocationViewController.h"

@implementation TPLocationViewController

-(id)init{
    if(self=[super init]){
        self.locationManager=[[CLLocationManager alloc]init];
        self.locationManager.delegate=self;
    }
    
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.mapView];
    self.mapView.delegate=self;
 

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self getLocationAuthorizationIfNotAuthorized];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
}

-(void)getLocationAuthorizationIfNotAuthorized{
    CLAuthorizationStatus locationAuthStatus=[CLLocationManager authorizationStatus];
    if(locationAuthStatus == kCLAuthorizationStatusDenied || locationAuthStatus==kCLAuthorizationStatusNotDetermined || locationAuthStatus==kCLAuthorizationStatusRestricted){
        
        [self.locationManager requestWhenInUseAuthorization];
        
    }else{
        
        //if authorized, update location.
        self.mapView.showsUserLocation=YES;
        [self.locationManager startUpdatingLocation];
        
    }

}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse){
        self.mapView.showsUserLocation=YES;
        [self.locationManager startUpdatingLocation];
        
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
  //  [self zoomToUserLocation:[locations objectAtIndex:0]];
    [self zoomToUserLocation:self.mapView.userLocation];
}

- (void)zoomToUserLocation:(MKUserLocation *)userLocation
    {
        if (!userLocation)
            return;
        
        MKCoordinateRegion region;
        region.center = userLocation.location.coordinate;
        region.span = MKCoordinateSpanMake(2.0, 2.0); //Zoom distance
        region = [self.mapView regionThatFits:region];
        [self.mapView setRegion:region animated:YES];
    }


@end