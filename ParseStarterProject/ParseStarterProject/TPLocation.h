//
//  TPLocation.h
//  Down
//
//  Created by Tyler Pfaff on 1/9/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface TPLocation : NSObject
@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSString* phoneNumber;
@property (strong,nonatomic) NSString* address;
@property (strong,nonatomic) NSURL* url;
@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;
@end