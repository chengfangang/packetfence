package captiveportal::Role::FieldValidation;

=head1 NAME

captiveportal::Role::FieldValidation

=head1 DESCRIPTION

Field Validation role

=cut

use Moose::Role;

=head2 around execute_child

This will validate the required fields when a POST is made on /signup

=cut

around 'execute_child' => sub {
    my $orig = shift;
    my $self = shift;

    if($self->app->request->method eq "POST" && $self->app->request->path eq "signup"){
        if($self->handle_posted_fields()){
            return $self->$orig(@_);  
        }
        else {
            return;
        }
    }
    $self->$orig(@_);
};

=head2 validate_required_fields

Check if there are missing fields in the request based on required_fields

=cut

sub validate_required_fields {
    my ($self) = @_;
    my @errors;
    foreach my $field (@{$self->required_fields}){
        unless(defined($self->request_fields->{$field}) && $self->request_fields->{$field}){
            push @errors, $self->app->i18n(["%s is required", $self->app->i18n($field)]);
        }
    }
    return \@errors;
}

=head2 validate_form

Validate that the form fields are valid and all the required fields are there

=cut

sub validate_form {
    my ($self) = @_;

    my $errors = $self->validate_required_fields();
    if(@$errors){
        $self->app->flash->{error} = [ "The following errors prevented the request to be fulfilled : %s", join(', ', @$errors) ];
        return 0;
    }
    my $form = $self->form($self->request_fields);
    if($form->has_errors){
        $self->app->flash->{error} = "An error occured while processing the request.";
        return 0;
    }
    return 1;
}

=head2 handle_posted_fields

Handle a POST of the fields

=cut

sub handle_posted_fields {
    my ($self) = @_;
    unless($self->validate_form()){
        $self->prompt_fields();
        return 0;
    }
    return 1;
}


=head1 AUTHOR

Inverse inc. <info@inverse.ca>

=head1 COPYRIGHT

Copyright (C) 2005-2016 Inverse inc.

=head1 LICENSE

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
USA.

=cut

1;


