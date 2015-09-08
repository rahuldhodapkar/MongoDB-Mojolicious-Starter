package StarterApp::Util::RouteWrapper;

use Moose;
use Moose::Util::TypeConstraints;
use namespace::autoclean;

has slug => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has method => (
    is       => 'ro',
    isa      => enum([qw(GET POST PUT DELETE)]),
    required => 1,
);

# uses the convention 'controller#method'
has action => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

# name to be displayed on a navbar
has short_name => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

# role for which this route is active
has role => (
    is       => 'ro',
    isa      => enum([qw(GUEST USER ADMIN)]),
);

# layout-defined menu director
has menu => (
    is       => 'ro',
    isa      => 'Str',
);

# route wrapper should be unique on (short_name, role)
sub unique_name {
    my ($self) = @_;

    return $self->slug . '_' . $self->role;
};

__PACKAGE__->meta->make_immutable;

1;
