#!/usr/bin/env perl
use Mojolicious::Lite;

get '/' => sub {
    my $self = shift;
    $self->stash(
        now => 'Hammer Time',
    );
    $self->render;
} => 'index';

get '/post' => sub {
    my $self = shift;
    $self->stash(
        now => 'Hammer Time',
    );
    $self->render;
} => 'post';

app->start;
