package StarterApp::Controller::Auth;
use Mojo::Base 'Mojolicious::Controller';
use StarterApp;
use Crypt::SaltedHash;

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

sub create_user {
  my ($self) = @_;

  my $db = StarterApp::db_connection();
  my $users = $db->get_collection( 'users' );

  my $email = $self->req->param('email');
  my $password = $self->req->param('password');

  my $crypt = Crypt::SaltedHash->new( algorithm => 'SHA-512' );
  $crypt->add($password);

  my $hashed_pass = $crypt->generate();
  
  my $id = $users->insert({
    _id => $email,
    hashed_pass => $hashed_pass,
  });
  
  $self->flash(message => 'User created successfully!');
  $self->redirect_to('/');
}

sub authenticate_user {
  my ($self) = @_;
  
  my $db = StarterApp::db_connection();
  my $users = $db->get_collection( 'users' );
 
  my $email = $self->req->param('email');
  my $password = $self->req->param('password');

  my $rec = $users->find_one({ '_id' => $email });

  my $crypt = Crypt::SaltedHash->new( algorithm => 'SHA-512' );
  if ( $crypt->validate($rec->hashed_pass, $password) ){
    print "authentication success!\n";
  }
  else {
    print "authentication failed\n";
  }
}

1;
