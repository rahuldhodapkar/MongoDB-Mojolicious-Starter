package StarterApp::Route::GuestRoutes;

sub define_routes {
  @routes = ();
  push @routes, _define_core_routes();
  push @routes, _define_utility_routes();
  return @routes;
}

sub _define_core_routes {
    my @routes = ();
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
  return @routes;
}

sub _define_utility_routes {
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
