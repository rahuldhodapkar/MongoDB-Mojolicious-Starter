package StarterApp::Controller::Index;
use Mojo::Base 'Mojolicious::Controller';
use StarterApp;

sub show_home {
  my $self = shift;
  print "getting here\n";
  my @menu_items = StarterApp::define_routes_for_role('GUEST');

  print "with menu items @menu_items \n";

  $self->render( 
      template      => 'index/index',
      layout        => 'guest_base',
      menu_items    => \@menu_items,
      current_page  => '',
  );
}

1;
