### Example app implemented with rest api app
### To run this app install some psgi server starman, twiggy etc.
### Run it with:
###    twiggy restapi.psgi
###
### And open localhost:5000 in browser

use strict;
use warnings;

use Plack::App::File;
use Plack::Builder;
use File::ShareDir;
use Try::Tiny;

# Set local lib
# Not needed if modules are installed from cpan
use lib qw(
	../Rest-HtmlVis/lib 
	../Plack-App-REST/lib 
	../Plack-Middleware-ParseContent/lib 
	../Plack-Middleware-FormatOutput/lib 
);

# Use default resource handlers
use Plack::App::REST;
use Api::Root;
use Api::Temp;
use Api::History;

my $share = try { File::ShareDir::dist_dir('Rest-HtmlVis') } || "../Rest-HtmlVis/share/";

# Main builder
builder {
	enable "SimpleLogger", level => 'debug';

	# Mount api resources
	mount '/api/v1' => builder {
		# Use default middlewares for Rest API
		# Set new visualisation for key events in returned perl structure
		enable "FormatOutput", htmlvis => {events=>'Rest::HtmlVis::Events'}; 
		enable "ParseContent";

		# Main part to set resources
		mount "/" => Api::Root->new();
		mount "/temp" => Api::Temp->new();
		mount "/history" => Api::History->new();
	};

	mount "/static" => Plack::App::File->new(root => $share);
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
