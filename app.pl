#!/usr/bin/env perl
use Mojolicious::Lite;

get '/' => sub {
    my $self = shift;
    $self->stash(
        now => 'Hammer Time',
    );
    $self->render;
} => 'base';

app->start;
