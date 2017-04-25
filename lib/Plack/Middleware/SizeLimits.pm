package Plack::Middleware::SizeLimits;

use strict;
use warnings;
use Linux::Smaps;
use parent qw( Plack::Middleware );

# ABSTRACT: Terminate processes if they grow tow large (simplified)
# VERSION

=head1 SYNOPSIS

 use Plack::Builder;
 
 builder {
   enable SizeLimits => (
     max => 4096,
   );
   $app;
 };

=head1 DESCRIPTION

Like L<Plack::Middleware::SizeLimit> but with a simplified interface.

=cut

my $max_process_size = 4096; # 4MB

sub prepare_app
{
  my($self) = @_;
  $max_process_size = $self->{max} * 1024;
}

sub call
{
  my($self, $env) = @_;
  

  my $res = $self->app->($env);

  return $res unless $env->{'psgix.harakiri'};

  my $s = Linux::Smaps->new($$)->all;
  #warn "max  = $max_process_size";
  #warn "size = ", $s->size;
  if($s->size > $max_process_size)
  {
    $env->{'psgix.harakiri.commit'} = 1;
    warn "PID $$ exceeded max memory (size: @{[ $s->size ]})";
  }

  return $res;
}

1;
