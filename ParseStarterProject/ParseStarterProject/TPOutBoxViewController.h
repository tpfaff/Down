//
//  TPOutBoxViewController.h
//  ParseStarterProject
//
//  Created by Tyler Pfaff on 12/7/14.
//
//
#import <UIKit/UIKit.h>
#ifndef ParseStarterProject_TPOutBoxViewController_h
#define ParseStarterProject_TPOutBoxViewController_h

@interface TPOutBoxViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>

@end

#endif
//
//Step 1: Subclass UIViewController instead of UITableViewController
//
//MyTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
//Step 2: Use interface builder to drop a tableView and custom View
//
//Step 3: Declare the tableView property as IBOutlet in your MyTableViewController header file and bind it to the tableView in the interface builder
//
//IMHO, This process would give you more flexibility.