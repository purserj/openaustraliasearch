//
//  Search_Senate.h
//  openaustraliasearch
//
//    Created by James Purser on 24/08/10.
//  Copyright 2010 James Purser
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
#import "SenateServiceController.h"


@interface Search_Senate : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate, SenateServiceControllerDelegate, UITableViewDelegate, UITableViewDataSource> {
	NSArray *states;
	IBOutlet UILabel *stateLabel;
	IBOutlet UIPickerView *statePicker;
	IBOutlet UITableView *repsTable;
	NSMutableArray *results;
	NSMutableArray *reps;
}

-(IBAction)selectState:(id)sender;
-(IBAction)goHome:(id)sender;

@property(nonatomic, retain) NSArray *states;
@property(nonatomic, retain) IBOutlet UIPickerView *statePicker;
@property(nonatomic, retain) UILabel *stateLabel;
@property(nonatomic, retain) IBOutlet UITableView *repsTable;
@property(nonatomic, retain) NSMutableArray *results;
@property(nonatomic, retain) NSMutableArray *reps;

@end
