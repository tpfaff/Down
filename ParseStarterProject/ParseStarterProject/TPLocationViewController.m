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
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
  //  [self zoomToUserLocation:[locations objectAtIndex:0]];
    [self zoomToLocation:self.mapView.userLocation.location];
    //self.where=self.mapView.userLocation.description;
}

- (void)zoomToLocation:(CLLocation *)location
    {
        if (!location)
            return;
        
        MKCoordinateRegion region;
        region.center = location.coordinate;
        region.span = MKCoordinateSpanMake(2.0, 2.0); //Zoom distance
        region = [self.mapView regionThatFits:region];
        [self.mapView setRegion:region animated:YES];
       
    }

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
        [self.mapView removeAnnotations:self.mapView.annotations];
        MKLocalSearchRequest *request =
        [[MKLocalSearchRequest alloc] init];
        request.naturalLanguageQuery = searchBar.text;
        request.region = self.mapView.region;
        
        self.searchResults = [[NSMutableArray alloc] init];
        
        MKLocalSearch *search =
        [[MKLocalSearch alloc]initWithRequest:request];
        
        [search startWithCompletionHandler:^(MKLocalSearchResponse
                                             *response, NSError *error) {
            if (response.mapItems.count == 0)
                NSLog(@"No Matches");
            else{
                
                MKMapItem* firstResult;
                for (MKMapItem *item in response.mapItems)
                {
                    if(!firstResult){
                        firstResult=item;
                    }
                    [self.searchResults addObject:item];
                    MKPointAnnotation *annotation =
                    [[MKPointAnnotation alloc]init];
                    annotation.coordinate = item.placemark.coordinate;
                    annotation.title = item.name;
                    [self.mapView addAnnotation:annotation];
                }
            
            [self zoomToLocation:firstResult.placemark.location];
            }
        }];
    
    }

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
//    view.annotation.
//    for(MKMapItem* item in self.mapView.selectedAnnotations){
//        
//    }
    for(MKMapItem* item in self.searchResults){
        if([item.name isEqualToString:[[[mapView selectedAnnotations]objectAtIndex:0] title]]){
            TPLocation* selectedLocation=[[TPLocation alloc]init];
            selectedLocation.name=item.name;
            selectedLocation.phoneNumber=item.phoneNumber;
            selectedLocation.url=item.url;
            selectedLocation.coordinate=item.placemark.coordinate;
            [self.delegate TPLocationViewController:self didSelectLocation:selectedLocation];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

@end