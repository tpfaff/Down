//
//  TPLocationViewController.m
//  Down
//
//  Created by Tyler Pfaff on 12/28/14.
//
//

#import <Foundation/Foundation.h>
#import "TPLocationViewController.h"
#import "Masonry/Masonry.h"
#import "TPUniverse.h"
#import "TPConstants.h"

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
    self.searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, kTPNavigationAndStatusBarHeight, self.view.frame.size.width, 25)];
    self.mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.searchBar setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.mapView];
    self.mapView.delegate=self;
    self.searchBar.delegate=self;
    [self.view addSubview:self.searchBar];
    
//    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.navigationController.view).bottom;
//    }];
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
        self.where=@"San Diego,CA";//this doesn't belong here, just for testing.
        
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
  //  [self zoomToUserLocation:[locations objectAtIndex:0]];
    [self zoomToUserLocation:self.mapView.userLocation];
    //self.where=self.mapView.userLocation.description;
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

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
        [self.mapView removeAnnotations:self.mapView.annotations];
        MKLocalSearchRequest *request =
        [[MKLocalSearchRequest alloc] init];
        request.naturalLanguageQuery = searchBar.text;
        request.region = self.mapView.region;
        
        self.matchingItems = [[NSMutableArray alloc] init];
        
        MKLocalSearch *search =
        [[MKLocalSearch alloc]initWithRequest:request];
        
        [search startWithCompletionHandler:^(MKLocalSearchResponse
                                             *response, NSError *error) {
            if (response.mapItems.count == 0)
                NSLog(@"No Matches");
            else
                for (MKMapItem *item in response.mapItems)
                {
                    [self.matchingItems addObject:item];
                    MKPointAnnotation *annotation =
                    [[MKPointAnnotation alloc]init];
                    annotation.coordinate = item.placemark.coordinate;
                    annotation.title = item.name;
                    [self.mapView addAnnotation:annotation];
                }
        }];
    }
//        [searchBar resignFirstResponder];
//        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//        [geocoder geocodeAddressString:searchBar.text completionHandler:^(NSArray *placemarks, NSError *error) {
//            //Error checking
//            
//            CLPlacemark *placemark = [placemarks objectAtIndex:0];
//            MKCoordinateRegion region;
//            region.center.latitude = placemark.region.center.latitude;
//            region.center.longitude = placemark.region.center.longitude;
//            MKCoordinateSpan span;
//            double radius = placemark.region.radius / 1000; // convert to km
//            
//            NSLog(@"[searchBarSearchButtonClicked] Radius is %f", radius);
//            span.latitudeDelta = radius / 112.0;
//            
//            region.span = span;
//            
//            [self.mapView setRegion:region animated:YES];
//        }];


@end