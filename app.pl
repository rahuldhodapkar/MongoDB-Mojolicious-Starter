#!/usr/bin/env perl
use Mojolicious::Lite;

get '/' => sub {
    my $self = shift;
    $self->stash(
        now => 'Hammer Time',
    );
    $self->render;
} => 'index';

get '/page1' => sub {
    my $self = shift;
    $self->stash(
        now => 'Hammer Time',
    );
    $self->render;
} => 'page1';

app->start;
