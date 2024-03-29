//
//  RepView.h
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
#import <MapKit/MapKit.h>
#import "RepObject.h"

@interface RepView : UIViewController {
	RepObject *rep;
	IBOutlet UILabel *nameLabel;
	IBOutlet UILabel *division;
	IBOutlet UILabel *house;
	IBOutlet UILabel *party;
	IBOutlet UILabel *date_elected;
	IBOutlet MKMapView *map;
	IBOutlet UIImageView *iview;
}

-(IBAction)closeView:(id)sender;

-(IBAction)repHansard:(id)sender;

@property (nonatomic, retain) RepObject *rep;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *division;
@property (nonatomic, retain) IBOutlet UILabel *house;
@property (nonatomic, retain) IBOutlet UILabel *party;
@property (nonatomic, retain) IBOutlet UILabel *date_elected;
@property (nonatomic, retain) IBOutlet MKMapView *map;
@property (nonatomic, retain) IBOutlet UIImageView *iview;
@end
