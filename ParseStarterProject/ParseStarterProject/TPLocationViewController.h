//
//  TPLocationViewController.h
//  Down
//
//  Created by Tyler Pfaff on 12/28/14.
//
//

#ifndef Down_TPLocationViewController_h
#define Down_TPLocationViewController_h

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TPLocationViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate,UISearchBarDelegate>
@property (strong,nonatomic) MKMapView* mapView;
@property (strong,nonatomic) CLLocationManager* locationManager;
@property (strong,nonatomic) NSString* where;
@property (strong,nonatomic) UISearchBar* searchBar;
@property (strong,nonatomic) NSMutableArray* matchingItems;
@end

#endif
