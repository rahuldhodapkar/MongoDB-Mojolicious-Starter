package StarterApp::Controller::User;
use Mojo::Base 'Mojolicious::Controller';
use namespace::autoclean;

=pod

Called to show user settings so that they can be edited/reviewed by the user. 
Subviews are handled by a switch in the URL (through the GET request).

=cut

sub show_user_settings {
  my ($self) = @_;

  $self->render(json => {ok => 1});
}

1;
