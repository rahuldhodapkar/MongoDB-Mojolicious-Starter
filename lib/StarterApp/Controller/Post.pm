package StarterApp::Controller::Post;
use Mojo::Base 'Mojolicious::Controller';

sub show_posts {
  my $self = shift;

  $self->render('post/readposts');
}

sub make_post {
  my $self = shift;

  $self->render('post/post');
}

1;
