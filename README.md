# Plack::Middleware::SizeLimits [![Build Status](https://secure.travis-ci.org/plicease/Plack-Middleware-SizeLimits.png)](http://travis-ci.org/plicease/Plack-Middleware-SizeLimits)

Terminate processes if they grow tow large (simplified)

# SYNOPSIS

    use Plack::Builder;
    
    builder {
      enable SizeLimits => (
        max => 4096,
      );
      $app;
    };

# DESCRIPTION

Like [Plack::Middleware::SizeLimit](https://metacpan.org/pod/Plack::Middleware::SizeLimit) but with a simplified interface.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
