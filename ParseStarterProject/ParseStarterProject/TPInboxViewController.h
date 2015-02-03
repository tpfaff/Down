//
//  TPInboxViewController.h
//  Down
//
//  Created by Tyler Pfaff on 1/31/15.
//
//

#import <UIKit/UIKit.h>

@interface TPInboxViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UITableView* tableView;
@end
