### Example app implemented with rest api middlewares
### To run this app install some psgi server starman, twiggy etc.
### Run it with:
###    twiggy restapi.psgi
###
### And open localhost:5000 in browser

use strict;
use warnings;

use Plack::App::File;
use Plack::Builder;

# Set local lib
# Not needed if modules are installed from cpan
use lib qw(
	../Rest-HtmlVis/lib 
	../Plack-Middleware-RestAPI/lib 
	../Plack-Middleware-ParseContent/lib 
	../Plack-Middleware-FormatOutput/lib
);

# Use default resource handlers
use Api::Root;
use Api::Temp;
use Api::History;

# Main builder
builder {
	enable "SimpleLogger", level => 'debug';

	# Mount api resources
	mount '/api/v1' => builder {
		# Use default middlewares for Rest API
		# Set new visualisation for key events in returned perl structure
		enable "FormatOutput", htmlvis => {events=>'Rest::HtmlVis::Events'}; 
		enable "ParseContent";
		enable "RestAPI";

		# Main part to set resources
		mount "/" => sub { return "Api::Root" };
		mount "/temp" => sub { return "Api::Temp" };
		mount "/history" => sub { return "Api::History" };
	};
};

=head1 AUTHOR

Vaclav Dovrtel, C<< <vaclav.dovrtel at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to github repository.

=head1 REPOSITORY

L<https://github.com/vasekd/plack-rest-api-example>

=head1 LICENSE AND COPYRIGHT

Copyright 2015 Vaclav Dovrtel.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See L<http://dev.perl.org/licenses/> for more information.

=cut
