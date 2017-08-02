package Log::ger::Output::FileWriteRotate;

# DATE
# VERSION

use strict;
use warnings;

sub get_hooks {
    my %conf = @_;

    require File::Write::Rotate;
    my $fwr = File::Write::Rotate->new(%conf);

    return {
        create_log_routine => [
            __PACKAGE__, 50,
            sub {
                my %args = @_;

                my $logger = sub {
                    my ($ctx, $msg) = @_;
                    $fwr->write($msg, $msg =~ /\R\z/ ? "" : "\n");
                };
                [$logger];
            }],
    };
}

1;
# ABSTRACT: Log to File::Write::Rotate

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

 use Log::ger::Output FileWriteRotate => (
     dir          => '/var/log',    # required
     prefix       => 'myapp',       # required
     #suffix      => '.log',        # default is ''
     size         => 25*1024*1024,  # default is 10MB, unless period is set
     histories    => 12,            # default is 10
     #buffer_size => 100,           # default is none
 );


=head1 DESCRIPTION

This output sends logs to File::Write::Rotate object.


=head1 CONFIGURATION

These configuration parameters are File::Write::Rotate's.

=head2 dir

=head2 prefix

=head2 suffix

=head2 size

=head2 histories

=head2 buffer_size


=head1 SEE ALSO

L<Log::ger>

L<File::Write::Rotate>

L<Log::ger::Output::SimpleFile>

L<Log::ger::Output::File>

L<Log::ger::Output::DirWriteRotate>

=cut
