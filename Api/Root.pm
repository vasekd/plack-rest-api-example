package Api::Root;

use strict;
use warnings;

use parent qw(Plack::App::REST);

### Handle GET api request
sub GET {
	my ($self, $env) = @_;

	return {
		user => 'test',
		project => 'Demo',
		version => 'v1',
		links => [
			{
				rel => "temp",
				title => "Manage temperature",
				href => "/api/v1/temp"
			},
			{
				rel => "history",
				title => "Show temperature history",
				href => "/api/v1/history"
			},
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
	return {
		GET => undef
	}
}

1;