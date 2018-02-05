# purcel

## What is purcel?

An experimental package manager for [PureScript][].

The name is "parcel" but with a "u" instead of an "a", because P**u**reScript

## Why another package manager?

Currently [PureScript][] has two major package managers: [bower][] and [psc-package][].

### Bower

[Bower][] is great at what it does.
It can manage just about any kind of file on the internet whether these files are registered with [bower][] or not.
It can also manage entire git repositories as dependencies.
For registered packages, it even can manage transitive dependencies, updates, and version bounds.
It's language agnostic and light weight.
If the packages you want to manage match the semantics of bower, it's a great package manager.

However, managing transitive dependencies is kind of a pain.
There are plenty of blog posts that explain some of the problems with bower better than we could do here.

### psc-package

[psc-package][] is also great at what it does.
It was built specifically for [PureScript][] and so makes some good choices based on that.
It solves the problem of transitive dependencies that bower has and using a premade package set is a breeze.

If [bower][] was great for bootstrapping [PureScript][],
then [psc-package][] has the potential to take [PureScript][] to the next level.

However, it still needs some work to get there.
The biggest pain point at the moment is adding a package outside of a set.

### Purcel

Purcel doesn't attempt to solve the same problems as these two package managers.

Some things we want to do are:

* Provide a small kernel for [PureScript][] package management
* Make package management decentralized
* Explore different ideas about package management

## How does purcel work?

Currently, purcel relies heavily on [Dhall][].
The configuration format is written in [Dhall][].
The fetching of files uses [Dhall][]s import mechanism.
The binary is little more than a wrapper that just pipes text to a file.
Since [Dhall][] is a full fledged programming language (with restrictions),
we rely on it to provide extensibility and experimentation.

We start by defining a kernel for what we consider a "package."
We refer to our idea of a package as a purcel.

A purcel has a name, a list of modules it provides and a list of dependencies:

```Dhall
{ package : Text
, modules : List Module
, dependencies : List Module
}
```

A `Module` is just a hierarchical name and the contents of the module:

```Dhall
{ name : Text
, contents : Text
}
```

From that, we can build new ideas of purcels that we might find interesting.

### Applications

The standard purcel is very much in line with what a library might look like.
But, what if we're building an application?
If nobody is going to consume our purcel, we don't need to put any `modules` together at all.
We could make a new idea of a purcel that just left that `modules` field off:

```Dhall
{ package : Text
, dependencies : List Module
}
```

But, we could still reuse all of the machinery of purcel, by interpreting our idea of an application into a regular purcel:

```Dhall
\(app : { package : Text, dependencies : List Module }) ->
    { package = app.package
    , modules = [] : List Module
    , dependencies = app.dependencies
    }
```

### Snapshots

What about this idea of a snapshot of modules that are known to compile together?
We can do that as well.

If someone puts together a snapshot of packages as a purcel:

```Dhall
{ package = "20180204173248"
, modules =
  [ { name = "Data/Eq.purs"
    , contents = ...
    }
  , { name = "Data/Ord.purs"
    , contents = ...
    }
  ...
  ]
, dependencies = [] : List Module
}
```

We can depend on that snapshot in our own purcel:

```Dhall
{ package = "business-app"
, modules = [] : List Module
, dependencies = (https://example.com/snapshots/20180204173248.dhall).modules
}
```

If we find that the snapshot left out a package we need (or multiple packages),
extending it is trivial:

```Dhall
{ package = "business-app"
, modules = [] : List Module
, dependencies = (https://example.com/snapshots/20180204173248.dhall).modules
  # [ { name = "Data/Semigroup/Validation.purs"
      , contents = ...
      }
    ]
  # (https://example.com/server-pack.dhall).modules
}
```

There are plenty of other ideas about how we can build upon this kernel we call a purcel.

## What is on the roadmap?

1. First and foremost, this was hacked together in about a day.
    There's no guarantee that it even works properly.
    We should push hard on it to find out where it breaks.
1. It feels like it's going to be pretty slow to use [Dhall][]s import mechanism.
    We can be more mindful about caching.
1. [Dhall][] provides [integrity checking][].
    That should probably be part of the kernel.
    You don't want your dependencies to change out from under you.
    If we move away from [Dhall][]s import mechanism,
    we can probably also provide integrity checking in the wrapper.
1. For this idea to be useful, someone is going to have to do a good deal of leg work.
    These packages aren't going to purcel themselves!

[bower]: https://bower.io/
[Dhall]: https://github.com/dhall-lang/dhall-lang
[integrity checking]: https://www.stackage.org/haddock/nightly-2018-01-29/dhall-1.9.0/Dhall-Tutorial.html#g:16
[psc-package]: https://github.com/purescript/psc-package
[PureScript]: http://purescript.org/
