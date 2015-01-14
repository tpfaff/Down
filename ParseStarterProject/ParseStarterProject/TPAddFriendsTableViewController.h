//
//  TPAddFriendsTableViewController.h
//  Down
//
//  Created by Tyler Pfaff on 1/12/15.
//
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
@interface TPAddFriendsTableViewController : PFQueryTableViewController <UISearchBarDelegate>
@property (strong,nonatomic) UISearchBar* searchBar;
@end
