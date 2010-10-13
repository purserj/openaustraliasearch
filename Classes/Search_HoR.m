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
#import "RepView.h"


@implementation Search_HoR
@synthesize textField;
@synthesize resultTable;
@synthesize results;
@synthesize searchTypePicker;
@synthesize stypes;
@synthesize stype;
@synthesize searchTypeLabel;

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
	stypes = [[NSArray arrayWithObjects:
			   @"Select Search Type",
			   @"PostCode",
			   @"Date",
			   @"Party",
			   @"Name", nil] retain];
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
	[self dismissModalViewControllerAnimated:YES];	
}

-(IBAction)getResults:(id)sender
{
	
	OAServiceController *controller = [[OAServiceController alloc] init];
	[searchTypePicker setHidden:YES];
	[textField resignFirstResponder];
	[controller setDelegate:self];
	if([stype isEqualToString:@"PostCode"]){
		
		NSInteger postcode = [textField.text intValue];
		[controller searchForRepresentativesWithPostcode:postcode date:nil party:nil search:nil];
		
	} else if([stype isEqualToString:@"Date"]){
		NSString *dateStr = [textField text];
		[controller searchForRepresentativesWithPostcode:nil date:dateStr party:nil search:nil];
		searchTypeLabel.text = @"Search by Date";
	} else if([stype isEqualToString:@"Party"]){
		NSString *partyStr = [textField text];
		[controller searchForRepresentativesWithPostcode:nil date:nil party:partyStr search:nil];
		searchTypeLabel.text = @"Search by Party";
	} else if([stype isEqualToString:@"Name"]){
		NSString *nameStr = [textField text];
		[controller searchForRepresentativesWithPostcode:nil date:nil party:nil search:nameStr];
		searchTypeLabel.text = @"Search by Name";
	}
	NSLog(@"%@", results);
	NSLog(@"get results button pushed - %d", [results count]);
}

-(IBAction)popUpPicker:(id)sender
{
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	if (theTextField == textField) {
		[textField resignFirstResponder];
	}
	return YES;
}

#pragma mark -
#pragma mark OAServiceController Delegate Methods

- (void)serviceController:(id)controller foundRepresentatives:(NSMutableArray *)representatives {
	
	results = [NSMutableArray new];
	reps = [NSMutableArray new];
	if(representatives == NULL){
		
	} else {
		for (RepObject *representative in representatives) {
			NSLog(@"%@, representative for %@", representative.fullName, representative.constituency);
			NSString *res = [NSString stringWithFormat:@"%@ - %@", representative.fullName, representative.constituency];
			NSLog(@"String - %@",res);
			[results addObject:res];
		}
		NSLog(@"Results Count - %d", [results count]);
		reps = representatives;
		[reps retain];
		[results retain];
		[[self resultTable] reloadData];
	}
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return [results count];
	return [results count];
	NSLog(@"Result count - %d", [results count]);
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    cell.text = [results objectAtIndex:indexPath.row]; 
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = [results objectAtIndex:indexPath.row];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
	
    return labelSize.height + 20;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	RepObject *repp = (RepObject *)[reps objectAtIndex:indexPath.row];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	RepView *rview = [[RepView alloc] initWithNibName:nil bundle:nil];
	rview.rep = repp;
	NSString *party = repp.partyName;
	NSLog(@"Reps count check - %d", [reps count]);
	NSLog(@"Party name - %@", party);
	NSLog(@"Full Name - %@", repp.fullName);
	NSLog(@"Index - %d", indexPath.row);
	[self presentModalViewController:rview animated:YES];
}

-(IBAction)selectSearchType:(id)sender{
	[textField resignFirstResponder];
	[searchTypePicker setHidden:NO];
	NSLog(@"Change State Button is pressed");
}

// statePicker setup functions
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
	return [stypes count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	return [stypes objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
	NSLog(@"Selected Color: %@. Index of selected color: %i", [stypes objectAtIndex:row], row);
	
	stype = [stypes objectAtIndex:row];
	if([stype isEqualToString:@"PostCode"]){
		searchTypeLabel.text = @"Search by Post Code";
	} else if([stype isEqualToString:@"Date"]){
		searchTypeLabel.text = @"Search by Date";
	} else if([stype isEqualToString:@"Party"]){
		searchTypeLabel.text = @"Search by Party";
	} else if([stype isEqualToString:@"Name"]){
		searchTypeLabel.text = @"Search by Name";
	}
	
	//[searchTypePicker setHidden:YES];
}

- (void)dealloc {
    [super dealloc];
}


@end
