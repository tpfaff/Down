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
#import "TPMapView.h"
#import "TPLocation.h"

@protocol TPLocationViewControllerDelegate;

@interface TPLocationViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate,UISearchBarDelegate>
@property (strong,nonatomic) MKMapView* mapView;
@property (strong,nonatomic) CLLocationManager* locationManager;
@property (strong,nonatomic) NSString* where;
@property (strong,nonatomic) UISearchBar* searchBar;
@property (strong,nonatomic) NSMutableArray* searchResults;
@property (nonatomic, weak) id <TPLocationViewControllerDelegate> delegate;

@end

@protocol TPLocationViewControllerDelegate <NSObject>
-(void)TPLocationViewController:(TPLocationViewController*)viewController didSelectLocation:(TPLocation*)location;
@end

#endif
