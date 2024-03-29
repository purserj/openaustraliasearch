//
//  openaustraliasearchViewController.h
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
#import "Search_HoR.h"
#import "Search_Senate.h"
#import "Search_Hansard.h"

@interface openaustraliasearchViewController : UIViewController {
	IBOutlet Search_HoR *search_hor;
	IBOutlet UIImageView *image;
}

@property (nonatomic, retain) Search_HoR *search_hor;


-(IBAction)switchView:(id)sender;

@property (nonatomic, retain) IBOutlet UIImageView *image;

@end

