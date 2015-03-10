package Api::Temp;

use strict;
use warnings;

### In real app this should be replaced with some type of database
my $FILEH = './hist.csv';
my $FILEA = './actual';

### Get request and return actual temperature
sub GET {
	my ($env) = @_;

	# Get actual temperature from file
	open FILEA, "<", $FILEA or die $!;
	my ($actual) = <FILEA>;
	chomp($actual) if $actual;
	close FILEA;

	return {
		actual => $actual,
		links => [
			{
				id => "root",
				name => "Root resource",
				href => "/api/v1"
			},
		]
	}
}

### Return form for gray pages
sub GET_FORM {
	my ($class, $params) = @_;
	{
		GET => undef,
		PUT => {
			default => $params->get('content')
		},
		POST => {
			default => "---\nvalue: number\ndate: ".time()
		}
	}
}

### Manage POST with struct {value=>number, date=>timestamp}
sub POST {
	my ($env, $data) = @_;

	# Save actual value
	open FILEH, ">", $FILEA or die $!;
	print FILEH $data->{value};
	close FILEH;

	# Add history
	open FILEA, ">>", $FILEH or die $!;
	print FILEA $data->{date}.','.$data->{value}."\n";
	close FILEA;

	return {
		actual => $data->{value},
		links => [
			{
				id => "root",
				name => "Root resource",
				href => "/api/v1"
			},
		]
	}
}

1;