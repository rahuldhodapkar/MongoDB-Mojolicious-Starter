package StarterApp::Controller::Auth;
use Mojo::Base 'Mojolicious::Controller';
use StarterApp;
use Crypt::SaltedHash;

sub login {
  my $self = shift;
  
  my %opts = ();
  if ($self->flash('failed')) {
    print "catching the failure\n";
    $opts{errormsg} = 'username/password incorrect';
  }

  my @jnk = keys %opts;

  print "@jnk\n";
  
  $self->render( 
    template      => 'auth/login',
    layout        => 'guest_base',
    menu_items    => [StarterApp::define_routes_for_role('GUEST')],
    current_page  => "Log In",
    %opts,
  );
}

sub signup {
  my $self = shift;

  my %opts = ();
  if ($self->session('failed')) {
    $opts{errormsg} => 'username already taken';
  }

  $self->render( 
    template      => 'auth/signup',
    layout        => 'guest_base',
    menu_items    => [StarterApp::define_routes_for_role('GUEST')],
    current_page  => "Sign Up",
    %opts,
  );
}

sub signout {
  my ($self) = @_;

  $self->session(expires => 1);

  $self->redirect_to('/');
}

sub create_user {
  my ($self) = @_;

  my $db = StarterApp::db_connection();
  my $users = $db->get_collection( 'users' );

  my $email = $self->req->param('email');
  my $password = $self->req->param('password');

  print "creating ($email, $password)\n";

  my $crypt = Crypt::SaltedHash->new( algorithm => 'SHA-512' );
  $crypt->add($password);

  my $hashed_pass = $crypt->generate();
  
  my $id = $users->insert({
    _id         => $email,
    role        => 'USER',
    hashed_pass => $hashed_pass,
  });
  
  print "entry created with _id: $id\n";

  $self->session(user => $email);
  $self->session(role => 'USER');

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
  if ( $crypt->validate($rec->{hashed_pass}, $password) ){
    print "user authenticated with _id: $email\n";
    $self->session(user => $email);
    $self->session(role => 'USER');

    $self->flash(failed => 0);
    $self->redirect_to('/');
  }
  else {
    print "authentication failed\n";
    $self->flash(failed => 1);
    $self->redirect_to('login'); 

  }

}

1;
