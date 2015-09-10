package StarterApp::Route::UserRoutes;

sub define_routes {
  my @routes = ();
  push @routes, _define_core_routes();
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
            slug        => '/signout',
            method      => 'GET',
            action      => 'auth#signout',
            short_name  => 'Sign Out',
            role        => 'USER',
            menu        => 'SETTINGS',
        );
    return @routes;
}

1;
