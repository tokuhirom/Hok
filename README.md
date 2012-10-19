Hok
===

Yet another testing framework for Perl5, inpired from mocha.

Status of this module
---------------------

In a development.

Synopsis
--------

### TDD style

    use v5.16.0;
    use Hok::More;

    subtest 'hoge' => sub {
        ok 1;
    };

    ok 2;
    ok 0;

### BDD style

    use v5.16.0;
    use Hok::Spec;

    describe 'hoge' => sub {
        expect('hoge')->equal('hoge');
        expect('hige')->equal('hige');
    };
    expect('hige')->equal('hage');

Reporters
---------

### Dot style

![Dot](http://gyazo.64p.org/image/471552296a03d8cd433f67162bc7bb91.png)

### Spec style

![Spec](http://gyazo.64p.org/image/f505941db6888dbd16fbe0f1ddebbd42.png)

### TAP style

![TAP](http://gyazo.64p.org/image/d1ec8097257b9204b880c818cc708b9f.png)

Features
--------

 * Hok have a feature of Test::Name::FromLine
 * Pretty test result printing.

ref.

 * http://en.wikipedia.org/wiki/Hok_(village)
