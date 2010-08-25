//
//  openaustraliasearchViewController.m
//  openaustraliasearch
//
//  Created by James Purser on 24/08/10.
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


#import "openaustraliasearchViewController.h"
#import "Search_HoR.h"
#import "Search_Senate.h"
#import "Search_Hansard.h"


@implementation openaustraliasearchViewController
@synthesize search_hor;



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (IBAction)switchView:(id)sender
{
	UIButton *pressedButton = (UIButton *)sender;
	NSLog(@" The buttons title is %@.", pressedButton.currentTitle);
	
	if([pressedButton.currentTitle isEqualToString:@"Search House of Representatives"])
	{
		Search_HoR *searchhor = [[Search_HoR alloc] initWithNibName:nil bundle:nil];
		[self presentModalViewController:searchhor animated:YES];
	}
	
	else if ([pressedButton.currentTitle isEqualToString:@"Search Senate"]) {
		Search_Senate *searchsen = [[Search_Senate alloc] initWithNibName:nil bundle:nil];
		[self presentModalViewController:searchsen animated:YES];
	}
	
	else if ([pressedButton.currentTitle isEqualToString:@"Search Hansard"]) {
		Search_Hansard *searchhans = [[Search_Hansard alloc] initWithNibName:nil bundle:nil];
		[self presentModalViewController:searchhans animated:YES];
	}
}


- (void)dealloc {
    [super dealloc];
}

@end
