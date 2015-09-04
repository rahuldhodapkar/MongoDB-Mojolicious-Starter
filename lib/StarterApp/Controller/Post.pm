package StarterApp::Controller::Post;
use Mojo::Base 'Mojolicious::Controller';
use MongoDB;
use MongoDB::OID;

my $client = MongoDB::MongoClient->new;
my $db = $client->get_database( 'starter_app' );
my $posts = $db->get_collection( 'posts' );

sub show_posts {
  my $self = shift;

  my $all_posts = $posts->find;

  $all_posts->sort({time => -1})->limit(10);

  my @posts = ();
  while (my $doc = $all_posts->next) {
    push @posts, $doc;
  }

  $self->render(
    template => 'post/see_posts',
    posts => \@posts,
  );
}

sub make_post {
  my $self = shift;

  $self->render('post/make_post');
}

sub save_post {
  
  my $self = shift;

  my $poster = $self->req->param('poster_name');
  my $post_body = $self->req->param('post_body');

  my $id = $posts->insert({ 
      user => $poster, 
      body => $post_body,
      time => localtime(),
  });

  #$self->flash(message => 'User created successfully!');
  $self->redirect_to('show_posts');
}

1;
