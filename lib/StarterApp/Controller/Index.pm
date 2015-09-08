package StarterApp::Controller::Index;
use Mojo::Base 'Mojolicious::Controller';
use StarterApp;

sub show_home {
  my $self = shift;

  $self->render( 
      template      => 'index/index',
      layout        => 'guest_base',
      menu_items    => [StarterApp::define_routes_for_role('GUEST')],
      current_page  => "Home"
  );
}

1;
