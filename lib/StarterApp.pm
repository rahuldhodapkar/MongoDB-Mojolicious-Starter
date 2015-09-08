package StarterApp;

use Mojo::Base 'Mojolicious';
use StarterApp::Util::RouteWrapper;
use MongoDB;

our $db;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes;

  $self->register_routes(define_routes_for_role('GUEST'));
  $self->register_routes(define_utility_routes());

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
    }
}

sub define_routes_for_role {
    my ($role) = @_;

    my @routes = ();

    # GUEST routes
    if ($role eq 'GUEST') {
        push @routes, StarterApp::Util::RouteWrapper->new(
                slug        => '/',
                method      => 'GET',
                action      => 'index#show_home',
                short_name  => 'Home',
                role        => 'GUEST',
                menu        => 'MAIN',
            );
        
        push @routes, StarterApp::Util::RouteWrapper->new(
                slug        => '/login',
                method      => 'GET',
                action      => 'auth#login',
                short_name  => 'Log In',
                role        => 'GUEST',
                menu        => 'SIGNUP',
            );

        push @routes, StarterApp::Util::RouteWrapper->new(
                slug        => '/signup',
                method      => 'GET',
                action      => 'auth#signup',
                short_name  => 'Sign Up',
                role        => 'GUEST',
                menu        => 'SIGNUP',
            );
    }
    else {
        die "invalid role $role not yet implemented\n";
    }

    return @routes;
}

sub define_utility_routes {
  my @routes = ();
    

  ## AUTHENTICATION routes
  push @routes, StarterApp::Util::RouteWrapper->new(
              slug        => '/authenticate_user',
              method      => 'POST',
              action      => 'auth#authenticate_user',
              short_name  => 'Authenticate',
              role        => 'GUEST',
              menu        => 'NONE',
          );

  push @routes, StarterApp::Util::RouteWrapper->new(
              slug        => '/create_user',
              method      => 'POST',
              action      => 'auth#create_user',
              short_name  => 'CreateUser',
              role        => 'GUEST',
              menu        => 'NONE',
          );

  return @routes;
}


1;
