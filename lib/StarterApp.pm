package StarterApp;

use Mojo::Base 'Mojolicious';
use StarterApp::Util::RouteWrapper;
use MongoDB;

# get routes files
use StarterApp::Route::GuestRoutes;
use StarterApp::Route::UserRoutes;

our $db;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes;

  $self->register_routes(define_routes_for_role('GUEST'));
  $self->register_routes(define_routes_for_role('USER'));

  # Database Connection
  my $client = MongoDB::MongoClient->new;
  $db = $client->get_database( 'starter_app' );
}

sub db_connection {
  return $db if defined $db;
  print "\$db not defined : trying to reconnect\n";

  my $client = MongoDB::MongoClient->new;
  $db = $client->get_database( 'starter_app' );

  return $db if defined $db;
  print "failed to reconnect on localhost:27017, database may be down?";
}

sub register_routes {
    my ($self, @routes) = @_;
    my $r = $self->routes;

    my %method_map = (
        'GET'    => sub { $r->get($_[0])->to($_[1]); },
        'POST'   => sub { $r->post($_[0])->to($_[1]); },
        'PUT'    => sub { $r->put($_[0])->to($_[1]); },
        'DELETE' => sub { $r->delete($_[0])->to($_[1]); },
    );

    for my $route (@routes) {
        $method_map{$route->method}->($route->slug, $route->action);
        #TODO: add role-based authentication to all routes here.
    }
}

sub define_routes_for_role {
    my ($role) = @_;

    my %route_map = (
      'GUEST' => sub { return StarterApp::Route::GuestRoutes::define_routes(); },
      'USER'  => sub { return StarterApp::Route::UserRoutes::define_routes(); },
    );

    return $route_map{$role}->();
}

1;
