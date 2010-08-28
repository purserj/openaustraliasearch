//
//  Search_HoR.m
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


#import "Search_HoR.h"
#import "RepObject.h"


@implementation Search_HoR
@synthesize textField;
@synthesize tableView;
@synthesize results;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[[self tableView] insertRowsAtIndexPaths:(NSArray *)results withRowAnimation:UITableViewRowAnimationNone];
	[tableView reloadData];
	[tableView setNeedsDisplay];
    [super viewDidLoad];
}


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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)goHome:(id)sender
{
		
}

-(IBAction)getResults:(id)sender
{
	NSInteger postcode = [textField.text intValue];
	OAServiceController *controller = [[OAServiceController alloc] init];
	[controller setDelegate:self];
	[controller searchForRepresentativesWithPostcode:postcode date:nil party:nil search:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	if (theTextField == textField) {
		[textField resignFirstResponder];
	}
	return YES;
}

#pragma mark -
#pragma mark OAServiceController Delegate Methods

- (void)serviceController:(id)controller foundRepresentatives:(NSArray *)representatives {
	
	results = [NSMutableArray new];
	for (RepObject *representative in representatives) {
		NSLog(@"%@, representative for %@", representative.fullName, representative.constituency);
		NSString *res = [NSString stringWithFormat:@"%@ - %@", representative.fullName, representative.constituency];
		NSLog(@"String - %@",res);
		[results addObject:res];
	}
	NSLog(@"Results Count - %d", [results count]);
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"Table View Results - %@", [results count]);
	return [results count] ; // every section has 5 rows
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"cellForRowAtIndexPath called");
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) { NSLog(@"new cell");
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	NSString *cellValue = [results objectAtIndex:indexPath.row];
	NSLog(@"hrmm %@", cellValue);
	cell.text = cellValue;
	return cell;
}

- (void)dealloc {
    [super dealloc];
}


@end
