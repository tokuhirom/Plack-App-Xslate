package Plack::App::Xslate;
use strict;
use warnings;
use parent qw( Plack::Component );
use 5.00800;
our $VERSION = '0.01';

use Plack::Util::Accessor qw/xslate content_type/;

use Plack::Request;
use Text::Xslate;
use Encode;

sub new {
    my $class = shift;
    my %args = @_ == 1 ? %{$_[0]} : @_;
    my $content_type = $args{PAX_CONTENT_TYPE} || 'text/html; charset=utf-8';
    my $xslate = Text::Xslate->new(%args);
    bless {
        content_type => $content_type,
        xslate       => $xslate,
    }, $class;
}

sub call {
    my ($self, $env) = @_;
    my $req = Plack::Request->new($env);
    my $out = $self->xslate->render($env->{PATH_INFO}, {r => $req});
    $out = Encode::encode_utf8($out);

    return [
        200,
        [
            'Content-Type'   => $self->content_type,
            'Content-Length' => length($out)
        ],
        [$out]
    ];
}

1;
__END__

=encoding utf8

=head1 NAME

Plack::App::Xslate - Xslate for Plack

=head1 SYNOPSIS

    use Plack::App::Xslate;

    my $app = Plack::App::Xslate->new(
        path   => ['.'],
        cache  => 1,
        module => [qw/JSON/],
    );

=head1 DESCRIPTION

Plack::App::Xslate is Xslate for Plack.

All arguments for B<new> constructor is passed to Text::Xslate->new().

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF GMAIL COME<gt>

=head1 SEE ALSO

=head1 LICENSE

Copyright (C) Tokuhiro Matsuno

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
