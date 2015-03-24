Example app implemented with rest api middlewares.

To run this app install some psgi server starman, twiggy etc.
All three middlewares:
 * Plack-Middleware-ParseContent
 * Plack-App-REST
 * Plack-Middleware-FormatOutput

And html visualisator:
 * Rest::HtmlVis

Install:
---------------------

1. Install psgi server (starman, twiggy ...)

    cpanm twiggy

2. Install middlewares

	cpanm Plack-Middleware-ParseContent Plack-App-REST Plack-Middleware-FormatOutput

3. Install gray pages (html visualiser)

	cpanm Rest::HtmlVis

Run:
---------------------

    twiggy restapi.psgi

Open:
---------------------

    localhost:5000 in browser
