# Extracurricular [![Build Status][travis-img]][travis] [![License][license-img]][license]

[travis-img]: https://travis-ci.org/elixirschool/extracurricular.svg?branch=master
[travis]: https://travis-ci.org/elixirschool/extracurricular
[license-img]: http://img.shields.io/badge/license-MIT-brightgreen.svg
[license]: http://opensource.org/licenses/MIT

Elixir School's Extracurricular is a website and twitter bot intended to increase visibility to open source opportunities within the community.

## Running the Project
Once you have cloned the repo and `cd`'d in, its quite simple to get started.
First, we get our dependencies and compile everything.

```bash
$ mix do deps.get, compile
```

Now, you will need to have Postgres running and have a user `postgres` with the password `postgres`, or fill out the proper credentials in `apps/web/config/dev.exs` and `apps/web/config/test.exs`.
Once you have gotten this proper, its time to create the database and run our migrations.

```bash
$ mix do ecto.create, ecto.migrate
```

Now we seed the database

```bash
$ mix run apps/data/priv/repo/seeds.exs
```

From here, we need to build all of our javascript pieces.
Ensure you have `brunch` installed, and then do this.

```bash
$ cd apps/web/assets
$ brunch build
$ cd ../../..
```

And with this we are ready to run the server

```bash
$ iex -S mix phx.server
```

Visit `localhost:4000` and you should see this:

![we're up and running!](http://i.imgur.com/pU6eoNU.png)

## Getting Involved

This is a project for the community, contributions are encouraged!

Feedback, feature requests, and fixes are welcomed.  Please make appropriate use of [Issues][issues] and [Pull Requests][pulls].  All code
should have accompanying tests.

[issues]: https://github.com/elixirschool/extracurricular/issues
[pulls]: https://github.com/elixirschool/extracurricular/pulls


## License

MIT license. Please see [LICENSE][license] for details.

[LICENSE]: https://github.com/elixirschool/extracurricular/blob/master/LICENSE
