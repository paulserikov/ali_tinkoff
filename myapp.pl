#!/usr/bin/env perl
use Mojolicious::Lite;

get '/' => sub {
  my $c = shift;
  $c->render(template => 'index');
};


get '/t' => sub {
  my $self = shift;
  my $o = $self->ua->get('https://www.tinkoff.ru/api/v1/currency_rates/')->res->json->{payload}->{rates};
  my @a = grep { $_->{fromCurrency}->{name} eq "USD" && $_->{toCurrency}->{name} eq "RUB" && $_->{category} eq "DebitCardsTransfers" } @$o;
  my $j = $a[0];
  $self->render(json => $j);
};

app->start;
__DATA__