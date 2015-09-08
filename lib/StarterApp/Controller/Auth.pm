package StarterApp::Controller::Auth;
use Mojo::Base 'Mojolicious::Controller';
use StarterApp;


sub login {
  my $self = shift;
  
  $self->render( 
    template      => 'auth/login',
    layout        => 'guest_base',
    menu_items    => [StarterApp::define_routes_for_role('GUEST')],
    current_page  => "Log In"
  );
}

sub signup {
  my $self = shift;
  
  $self->render( 
    template      => 'auth/signup',
    layout        => 'guest_base',
    menu_items    => [StarterApp::define_routes_for_role('GUEST')],
    current_page  => "Sign Up"
  );
}

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
