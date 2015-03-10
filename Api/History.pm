package Api::History;

use strict;
use warnings;

use POSIX qw( strftime );

### In real app this should be replaced with some type of database
my $FILEH = './hist.csv';

### Get request and return events as {date => value}
sub GET {
	my ($env, $data) = @_;

	my $events;

	# open file with history
	open FILEH, "<", $FILEH or die $!;
	while (my $row = <FILEH>) {
		chomp $row;
		my ($date, $value) = split(/,/,$row);
		$events->{$date} = $value;
	}
	close FILEH;

	return {
		events => $events,
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
	}
}

1;