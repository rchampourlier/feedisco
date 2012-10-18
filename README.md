# Feedisco

### Summary

Feedisco is a small and lightweight library focused on RSS/Atom feed discovery. It is intended to do little, but to do it well!

### Use case(s)

* I want to **find the URLs of a RSS/Atom feeds for my users' blogs**
* I want to **check that an user-supplied URL is truly a RSS/Atom feed URL**
* I want to let my user **choose from a list of discovered RSS/Atom feeds** when he entered his website URL
* Probably more...

### The methods

```
Feedisco.find(url)
Feedisco.feed?(url)
```

### How to start

**Install it with Rubygems**

```
$ gem install feedisco
$ irb

irb(main):001:0> require 'rubygems'
=> true
irb(main):001:0> require 'feedisco'
=> true
```

**...or clone it from GitHub**

```
$ git clone https://github.com/rchampourlier/feedisco
$ cd feedisco
$ bundle install
$ bundle exec script/console
```

_**Nota Bene:**_

* _`script/console` is a small script available in the repo that loads an IRB/Pry console with Feedisco preloaded, so it's ready to use! (feel like `rails console`)_

### Examples

```
irb(main):001:0> Feedisco.find('rchampourlier.com')
=> ["http://feeds.rchampourlier.com/rchampourlier"]

irb(main):002:0> Feedisco.find('google.com')
=> []

irb(main):003:0> Feedisco.feed?('google.com')
=> false

irb(main):007:0> Feedisco.feed?('feeds.rchampourlier.com/rchampourlier')
=> true

irb(main):010:0> puts Feedisco.find('http://edition.cnn.com/services/rss/')
http://rss.cnn.com/rss/edition.rss
http://rss.cnn.com/rss/edition_asia.rss
http://rss.cnn.com/rss/edition_europe.rss
http://rss.cnn.com/rss/edition_us.rss
http://rss.cnn.com/rss/edition_world.rss
http://rss.cnn.com/rss/edition_africa.rss
http://rss.cnn.com/rss/edition_americas.rss
[and a lot more...]
```

### Installation

Add this to your Gemfile (the gem is not published to Rubygems until it is good enough, so tell me when you think it should!):

```
gem 'feedisco', :git => 'https://github.com/rchampourlier/feedisco', :ref => 'master'
```

Or just clone it and do whatever you want:

```
$ git clone http://github.com/rchampourlier/feedisco
```


### Why should you use it?

* Well, because you need to discover feeds URL from a given URL, and nothing more!
* Because you wan't it to be simple, with clean-code you can correct, complete, update, test, if you need it.
* Because you just need to add a line to your Gemfile to use it.
* Because it should still follow modern feed filename conventions (like those ones used by WordPress blogs, or Blogger, etc) - that's the part taken from [Feedbag](https://github.com/damog/feedbag)!

### Why did I build it?

* Because I wanted a **simple and lightweight** library to discover RSS/Atom feeds.
* Because [Feedbag](https://github.com/damog/feedbag) was using Hpricot, and I was more Nokogiri.
* Because I wanted something with a little more tests than Feedbag.

### Bugs, issues, contributions

You can use the [GitHub repo](https://github.com/rchampourlier/feedisco) for all this, so don't hesitate!

Contribute by forking, tweaking, and sending pull requests, but please add the appropriate tests!

### History

#### `0.1.3`

* Corrected bug causing some links to appear several times in the result.

#### `0.1.2`

* Supports `StringIO` as a return from the open-uri `open` method (which is returned instead of a `Tempfile` when the content is smaller than a given size - 10KB).

#### `0.1.1`

* Completed `Rakefile`
* Changed a method from private to public, specs are green again

#### `0.1.0`

* Initial release

### Author

[Romain Champourlier](http://softr.li)

### Copyright

This is free software. See [LICENSE](http://github.com/rchampourlier/feedisco/master/LICENSE) for more information.

### Thanks

[David Moreno](http://damog.net/) for [Feedbag](https://github.com/damog/feedbag) which I used before writing Feedisco. Plus Feedisco is more than inspired from Feedbag, even if I almost rewrote everything to make (to my sense) more Ruby-way, readable, and in particular more tested.