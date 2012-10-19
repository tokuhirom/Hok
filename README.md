Hok
===

Yet another testing framework for Perl5, inpired from mocha.

![screen shot](http://gyazo.64p.org/image/2996f36aba176ad2d0d9c6734eb45476.png)

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

Features
--------

 * Hok have a feature of Test::Name::FromLine
 * Pretty test result printing.

ref.

 * http://en.wikipedia.org/wiki/Hok_(village)
