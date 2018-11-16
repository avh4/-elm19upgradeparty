## It's an Elm 0.19 upgrade party!

I'll be streaming on November 17th between 9am-noon PST / noon-3pm EST / 5pm-8pm GMT
upgrading some of my own packages, help out viewers with their upgrade questions,
and interviewing and pair programming with special guests!

We'll also have folks available on the [elm-lang slack](https://elmlang.herokuapp.com/) to
help with any problems you encounter while upgrading your own projects.

If you have your own projects to upgrade to Elm 0.19, want to help upgrade community packages,
want to help others out with upgrading, or just want to hang out,
tune in and join us!

# Support our charity of the week

If you'd like to support our chosen charity, you can donate to support [AnnieCannons],
an non-profit organization working to transform survivors of human trafficking into software professionals.  [Donate here!](https://www.anniecannons.com/donate)

# Livestream Schedule

We'll have the following events happening on Aaron's twitch stream <https://twitch.tv/avh4>:

- <b class="schedule"><time datetime="2018-11-17T17:00Z">5:00pm GMT</time></b> Welcome! and an overview of new features in Elm 0.19
- <b class="schedule"></b> upgrading [elm-program-test] and answering questions
- <b class="schedule"><time datetime="2018-11-17T17:30Z">5:30 pm GMT</time></b> (possible pair programming with surprise guest)

- <b class="schedule"><time datetime="2018-11-17T18:00Z">6:00 pm GMT</time></b> info about [AnnieCannons](https://www.anniecannons.com/) (with possible special guest)
<!-- w/ **[Ayşegül]** -->
- <b class="schedule"></b> upgrading [elm-dropbox] and answering questions
- <b class="schedule"><time datetime="2018-11-17T18:30Z">6:30 pm GMT</time></b> lessons from upgrading large codebases to Elm 0.19 w/ **Luke** and **[Martin]**
- <b class="schedule"></b> continuing to upgrade packages, pairing w/ **Luke**

- <b class="schedule"><time datetime="2018-11-17T19:15Z">7:15 pm GMT</time></b> demo of [elm-benchmark] w/ **[Brian]**
- <b class="schedule"></b> (possible pair programming w/ **[Brian]**)
- <b class="schedule"></b> upgrading packages and answering questions
- <b class="schedule"><time datetime="2018-11-17T19:45Z">7:45 pm GMT</time></b> (possible demo of [elm-readiness] with **Tomáš**)

[Ayşegül]: https://twitter.com/AysSomething
[Martin]: https://twitter.com/janiczek
[Brian]: https://twitter.com/brianhicks

[AnnieCannons]: https://www.anniecannons.com/

[elm-program-test]: https://github.com/avh4/elm-program-test
[elm-dropbox]: https://github.com/avh4/elm-dropbox
[elm-benchmark]: https://package.elm-lang.org/packages/BrianHicks/elm-benchmark/latest
[elm-readiness]: https://kraklin.github.io/elm-readiness/

## Live stream

<div id="twitch-embed"></div>

<script src="https://embed.twitch.tv/embed/v1.js"></script>
<script type="text/javascript">
  new Twitch.Embed("twitch-embed", {
    width: 854,
    height: 480,
    channel: "avh4"
  });
</script>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha256-3edrmyuQ0w65f8gfBsqowzjJe2iM6n0nKciPUp8y+7E=" crossorigin="anonymous"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-timezone/0.5.23/moment-timezone-with-data.min.js"></script>

<script type="text/javascript">

var zone_name =  moment.tz.guess();
var timezone = moment.tz(zone_name).zoneAbbr();

$('time').each(function() {
  var t = moment($(this).attr("datetime"));
  var localtime = t.format('LT ').toLowerCase() + timezone;
  $(this).text(localtime);
});
</script>

<style>
ul {
  padding-left: 10em;
}

li {
  position: relative;
}

b.schedule {
  display: inline-block;
  position: absolute;
  left: -8.5em;
}
</style>
