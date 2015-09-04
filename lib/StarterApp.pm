package StarterApp;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('index#show_home');

  $r->get('/post')->to('post#make_post');

  $r->get('/all_posts')->to('post#show_posts');

}

1;
