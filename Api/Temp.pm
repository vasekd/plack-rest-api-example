package Api::Temp;

use strict;
use warnings;

use parent qw(Plack::App::REST);

### In real app this should be replaced with some type of database
my $FILEH = './hist.csv';
my $FILEA = './actual';

### Get request and return actual temperature
sub GET {
	my ($self, $env, $param, $body) = @_;

	# Get actual temperature from file
	open FILEA, "<", $FILEA or die $!;
	my ($actual) = <FILEA>;
	chomp($actual) if $actual;
	close FILEA;

	return {
		actual => $actual,
		links => [
			{
				rel => "root",
				title => "Root resource",
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
	my ($self, $env, $param, $data) = @_;

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
				rel => "root",
				title => "Root resource",
				href => "/api/v1"
			},
		]
	}
}

1;