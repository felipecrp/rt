# BEGIN LICENSE BLOCK
# 
# Copyright (c) 1996-2002 Jesse Vincent <jesse@bestpractical.com>
# 
# (Except where explictly superceded by other copyright notices)
# 
# This work is made available to you under the terms of Version 2 of
# the GNU General Public License. A copy of that license should have
# been provided with this software, but in any event can be snarfed
# from www.gnu.org
# 
# This work is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# 
# Unless otherwise specified, all modifications, corrections or
# extensions to this work which alter its source code become the
# property of Best Practical Solutions, LLC when submitted for
# inclusion in the work.
# 
# 
# END LICENSE BLOCK

# Released under the terms of the GNU Public License


=head1 NAME

  RT::CustomFields - a collection of RT CustomField objects

=head1 SYNOPSIS

  use RT::CustomFields;

=head1 DESCRIPTION

=head1 METHODS


=begin testing

ok (require RT::CustomFields);

=end testing

=cut

no warnings qw(redefine);


# {{{ sub _Init
sub _Init { 
  my $self = shift;
  $self->{'table'} = "CustomFields";
  $self->{'primary_key'} = "id";
  return ( $self->SUPER::_Init(@_));
}
# }}}

# {{{ sub LimitToGlobalOrQueue 

=item LimitToGlobalOrQueue QUEUEID

Limits the set of custom fields found to global custom fields or those tied to the queue with ID QUEUEID 

=cut

sub LimitToGlobalOrQueue {
    my $self = shift;
    my $queue = shift;
    $self->LimitToQueue($queue);
    $self->LimitToGlobal();
}

# }}}

# {{{ sub LimitToQueue 

=head2 LimitToQueue QUEUEID

Takes a queue id (numerical) as its only argument. Makes sure that 
Scopes it pulls out apply to this queue (or another that you've selected with
another call to this method

=cut

sub LimitToQueue  {
   my $self = shift;
  my $queue = shift;
 
  $self->Limit (ENTRYAGGREGATOR => 'OR',
		FIELD => 'Queue',
		VALUE => "$queue")
      if defined $queue;
  
}
# }}}

# {{{ sub LimitToGlobal

=head2 LimitToGlobal

Makes sure that 
Scopes it pulls out apply to all queues (or another that you've selected with
another call to this method or LimitToQueue

=cut


sub LimitToGlobal  {
   my $self = shift;
 
  $self->Limit (ENTRYAGGREGATOR => 'OR',
		FIELD => 'Queue',
		VALUE => 0);
  
}
# }}}

1;

