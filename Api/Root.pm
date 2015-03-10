package Api::Root;

use strict;
use warnings;

### Handle GET api request
sub GET {
	my ($env) = @_;

	return {
		user => 'test',
		project => 'Demo',
		version => 'v1',
		links => [
			{
				id => "temp",
				name => "Manage temperature",
				href => "/api/v1/temp"
			},
			{
				id => "history",
				name => "Show temperature history",
				href => "/api/v1/history"
			},
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
	return {
		GET => undef
	}
}

1;