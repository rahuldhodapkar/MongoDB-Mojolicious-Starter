package StarterApp::Controller::Index;
use Mojo::Base 'Mojolicious::Controller';

sub show_home {
  my $self = shift;
  print "getting here\n";

  $self->render(template => 'index/index');
}

1;
