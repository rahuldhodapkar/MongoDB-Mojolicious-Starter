package StarterApp;

use Mojo::Base 'Mojolicious';
use StarterApp::Util::RouteWrapper;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes;

  $self->register_routes(define_routes_for_role('GUEST'));

  #   # Normal route to controller
  #   $r->get('/')->to('index#show_home');

  #   $r->get('/make_post')->to('post#make_post');

  #   $r->get('/show_posts')->to('post#show_posts');

  #   $r->post('/add_post_to_database')->to('post#save_post');

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

1;
