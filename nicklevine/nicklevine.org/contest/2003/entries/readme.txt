		ILC 2003 Programming Contest
		     Competition Entries
                   Nick Levine, 2003-10-21

The fifteen files / subdirectories in this directory have each been
named after the competitor who submitted them. I added RCS markers but
otherwise left them alone (I believe). You may or may not be able to
run them in any individual lisp.

The folder "timings/" contains (slightly) modified versions of the six
fastest entries. As stated in the judges' report:

    Because not all the entrants had found more than one solution, we
    levelled the playing field by running timings on code modified to
    halt after finding the first solution. However we also ran the
    fastest two entries over the complete solution space and this test
    served to confirm our earlier results.

    Additionally, in the name of fairness, we undid the manual
    precomputation in one entry. Finally, we placed the set of pieces
    in the same canonical order in all entries. This made several
    entries run slower (and one much slower); it also made one entry
    run much faster.

    ...

    We compiled, loaded and ran six shortlisted entries, 100 times
    each.

The harness to conduct the timing trials is in
"timings/timings.lisp". It would need minor modification to run in
another lisp (change the call to mark-and-sweep to the appropriate GC
invocation for your implementation).

The code used to generate the "realtime race" between the two fastest
entries, as shown at ILC 2003, is in "timings/race.lisp". This is
a set of quick'n'dirty LispWorks CAPI hacks. It won't run on any other
lisp.



-------------

Each puzzle entry is the intellectual property of the person who
submitted it.

The "Last Piece Puzzle" is copyright (c) Blue Opal Australia Pty
Ltd. None of the puzzle designs included in this website may be
reproduced, by any means whatsoever, other than for purposes directly
related to this contest.

This document is copyright (c) Nick Levine 2003. All rights
reserved. It is provided "as is", without any express or implied
warranty. In no event will the author be held liable for any damages
arising from the use of this document. You may make and use verbatim
copies of this document for purposes directly related to this
contest. You may not mirror this document on another website. You may
not charge anyone for the use of this document.

"Windows" is a registered trademark of Microsoft Corporation. Other
brand or product names are the registered trademarks or trademarks of
their respective holders.

$Id: //info.ravenbrook.com/user/ndl/lisp/contest/2003/entries/readme.txt#1 $
