LISTSERVICE
==========

*Catalogue, forum, & API for emails from [The Listserve](http://thelistserve.com)*

Resources
---------

* Posts


Data
----

* Listens for POST from webhook on a subscribed email address that automatically creates new post
* Has capability to piggyback on [the-listserve-archive](https://github.com/simon-weber/the-listserve-archive) through `rake api:load`

API
----

* `http://thelistserves.com/api/posts`
* `http://thelistserves.com/api/posts/<id>`