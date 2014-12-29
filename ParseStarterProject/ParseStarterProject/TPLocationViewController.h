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

@interface TPLocationViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
@property (strong,nonatomic) MKMapView* mapView;
@property (strong,nonatomic) CLLocationManager* locationManager;
@end

#endif
