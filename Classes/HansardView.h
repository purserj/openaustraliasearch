//
//  HansardView.h
//  openaustraliasearch
//
//  Created by James Purser on 1/09/10.
//  Copyright 2010 James Purser. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


#import <UIKit/UIKit.h>
#import "HansardServiceController.h"
#import "HansardObject.h"


@interface HansardView : UIViewController <HansardServiceControllerDelegate, UITableViewDelegate, UITableViewDataSource>{
	
	IBOutlet NSMutableArray *results;
	NSString *person;
	NSString *houseType;
	IBOutlet UITableView *resultTable;
	NSMutableArray *hansObjs;
}

-(IBAction)closeView:(id)sender;

@property (nonatomic, retain) NSString *person;
@property (nonatomic, retain) NSString *houseType;
@property (nonatomic, retain) IBOutlet UITableView *resultTable;
@property (nonatomic, retain) IBOutlet NSMutableArray *results;
@property (nonatomic, retain) NSMutableArray *hansObjs;
@end
