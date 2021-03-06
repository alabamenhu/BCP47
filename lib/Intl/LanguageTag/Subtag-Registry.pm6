unit module Subtag-Registry;
# This could be single passed I'm sure, but its done at compile time
# so only slows things down on install / first use.

our %languages is export(:languages) = BEGIN {
  my %data = ();
  my @entries = %?RESOURCES<languages.data>.slurp.lines;
  for @entries -> $entry {
    $entry ~~ /
     (<[a..zA..Z0..9-]>+) ','   # language code
     (<[a..zA..Z0..9-]>*) ','   # supressed script
     (<[a..zA..Z0..9-]>*) ','   # macrolanguage
     (<[a..zA..Z0..9-]>*)       # preferred code
     (  '!'?  )                 # is deprecated
    /;

  %data{$0.Str} = ($1.Str,$2.Str,$3.Str) unless $4.Str eq '!'
  }
  %data;
}

our enum Foo is export(:languages) ( Bar => 2, Fooy => 3);

our %deprecated-languages is export(:languages) = BEGIN {
  my %data = ();
  my @entries = %?RESOURCES<languages.data>.slurp.lines;
  for @entries -> $entry {
    $entry ~~ /
     (<[a..zA..Z0..9-]>+) ','   # language code
     (<[a..zA..Z0..9-]>*) ','   # supressed script
     (<[a..zA..Z0..9-]>*) ','   # macrolanguage
     (<[a..zA..Z0..9-]>*)       # preferred code
     (  '!'?  )                 # is deprecated
    /;
    %data{$0.Str} = ($1.Str,$2.Str,$3.Str) if $4.Str eq '!'
  }
  %data;
}

our %grandfathered-languages is export(:old-languages) = BEGIN {
  my %data = ();
  my @entries = %?RESOURCES<languages.data>.slurp.lines;
  for @entries -> $entry {
    $entry ~~ /
     (<[a..zA..Z0..9-]>+) ','   # language tag
     (<[a..zA..Z0..9-]>*)       # preferred tag
     (  '!'?  )                 # is deprecated
    /;
    %data{$0.Str} = ($1.Str, $2.Str eq '!')
  }
  %data;
}

our %redundant-languages is export(:old-languages) = BEGIN {
  my %data = ();
  my @entries = %?RESOURCES<languages.data>.slurp.lines;
  for @entries -> $entry {
    $entry ~~ /
     (<[a..zA..Z0..9-]>+) ','   # language tag
     (<[a..zA..Z0..9-]>*)       # preferred tag
     (  '!'?  )                 # is deprecated
    /;
    %data{$0.Str} = ($1.Str, $2.Str eq '!')
  }
  %data;
}

our %regions is export(:regions) = BEGIN {
  my %data = ();
  my @entries = %?RESOURCES<regions.data>.slurp.lines;
  for @entries -> $entry {
    $entry ~~ /
     (<[a..zA..Z0..9-]>+) ','   # region code
     (<[a..zA..Z0..9-]>*)       # preferred
     (  '!'?  )                 # is deprecated
    /;
    %data{$0.Str} = $1.Str unless $2.Str eq '!'
  }
  %data;
}

our %deprecated-regions is export(:regions) = BEGIN {
  my %data = ();
  my @entries = %?RESOURCES<regions.data>.slurp.lines;
  for @entries -> $entry {
    $entry ~~ /
     (<[a..zA..Z0..9-]>+) ','   # region code
     (<[a..zA..Z0..9-]>*)       # preferred
     (  '!'?  )                 # is deprecated
    /;
    %data{$0.Str} = $1.Str if $2.Str eq '!'
  }
  %data;
}

our %scripts is export(:scripts) = BEGIN {
  my %data = ();
  my @entries = %?RESOURCES<scripts.data>.slurp.lines;
  for @entries -> $entry {
    $entry ~~ /
     (<[a..zA..Z0..9-]>*)       # code
    /;
    %data{$0.Str} = '';
  }
  %data;
}

our %variants is export(:variants) = BEGIN {
  my %data = ();
  my @entries = %?RESOURCES<variants.data>.slurp.lines;
  for @entries -> $entry {
    $entry ~~ /
    (<[a..zA..Z0..9-]>+) ','   # code
    (<[a..zA..Z0..9-]>*) ','   # prefix
    (<[a..zA..Z0..9-]>*)       # preferred
    (  '!'?  )                 # is deprecated
    /;
    %data{$0.Str} = ($1.Str,$2.Str) unless $3.Str eq '!';
  }
  %data;
}

our %deprecated-variants is export(:variants) = BEGIN {
  my %data = ();
  my @entries = %?RESOURCES<variants.data>.slurp.lines;
  for @entries -> $entry {
    $entry ~~ /
    (<[a..zA..Z0..9-]>+) ','   # code
    (<[a..zA..Z0..9-]>*) ','   # prefix
    (<[a..zA..Z0..9-]>*)       # preferred
    (  '!'?  )                 # is deprecated
    /;
    %data{$0.Str} = ($1.Str,$2.Str) if $3.Str eq '!';
  }
  %data;
}
