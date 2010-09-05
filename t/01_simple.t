use strict;
use warnings;
use Test::More tests => 2;
use Plack::App::Xslate;
use Plack::Test;

test_psgi
  app    => Plack::App::Xslate->new( path => 't/tmpl', syntax => 'TTerse' ),
  client => sub {
    my $cb = shift;
    my $req =
      HTTP::Request->new( GET => 'http://localhost/index.tx?name=taro' );
    my $res = $cb->($req);
    is $res->code(), 200;
    is $res->content, "Hello, taro.\n";
  };

