# Extracurricular [![Build Status][travis-img]][travis] [![License][license-img]][license]

[travis-img]: https://travis-ci.org/elixirschool/extracurricular.svg?branch=master
[travis]: https://travis-ci.org/elixirschool/extracurricular
[license-img]: http://img.shields.io/badge/license-MIT-brightgreen.svg
[license]: http://opensource.org/licenses/MIT

Elixir School's Extracurricular is a website and twitter bot intended to increase the visibility of open source opportunities within the community.

## Running the Project

Once you have cloned the repo and `cd`'d in, its quite simple to get started.
First, we get our dependencies and compile everything:

```bash
$ mix do deps.get, compile
```

Next we need to setup our database.  Out-of-the-box Extracurricular uses Postgres with a user `postgres` and password `postgres`.
If you're using anything different you'll need to fill out the proper credentials in `apps/web/config/dev.exs` and `apps/web/config/test.exs`.

To setup the database, migrate it, and populate it with dummy data we can use our handy alias:

```bash
$ mix ecto.setup
```

Install node packages and build brunch assets:

```bash
$ cd apps/web/assets && npm install && node node node_modules/brunch/bin/brunch build && cd ../../../
```

And the fun part, running the server!  If you haven't done so already, this will compile your frontend dependencies:

```bash
$ iex -S mix phx.server
```

Visit [localhost:4000](localhost:4000) and you should see this a local instance of the application!

## Getting Involved

This is a project for the community, contributions are encouraged!

Feedback, feature requests, and fixes are welcomed.
Please make appropriate use of [Issues][issues] and [Pull Requests][pulls].
All code should have accompanying tests.

[issues]: https://github.com/elixirschool/extracurricular/issues
[pulls]: https://github.com/elixirschool/extracurricular/pulls

## License

MIT license.
Please see [LICENSE][license] for details.

[LICENSE]: https://github.com/elixirschool/extracurricular/blob/master/LICENSE
