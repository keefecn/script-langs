#!/usr/bin/perl

sub words($file) { slurp($file).lc.comb(/<alpha>+/) }
sub train(@words) {
  my %res;
  for @words -> $w { %res{$w}++ }
  %res
}

#my %NWORDS = train(words('/home/rff/Desktop/big.txt'));
my %NWORDS={'ciao'=>4,'c'=>3,'cibo'=>1,'ciaao'=>1,'ccc'=>1,'cia'=>1};

my @ALPHA = 'a'..'z';

# 'abc' -> 'ac'
sub deletion($word) {
  (^$word.chars).map: {substr(my $tmp = $word,$_,1)='';$tmp};
}

# 'abc' -> 'adc'
sub substitution($word) {
  gather {
    for (0..$word.chars-1) X @ALPHA {
      substr(my $tmp = $word,$_[0],1)=$_[1];
      take $tmp;
    }
  }
}

# 'abc' -> 'abbc'
sub insertion($word) {
  gather {
    for (0..$word.chars) X @ALPHA {
      substr(my $tmp = $word,$_[0],0)=$_[1];
      take $tmp;
     }
  } 
}

# 'abc' -> 'acb'
sub transposition($w) {
  gather for ^$w.chars {
    my $tmp=$w;
    my $removed =(substr($tmp,$_,1)='');
    substr($tmp,$_+1,0)=$removed;
    take $tmp;
  }
}

sub edits1($w) {
  # all these are different, no need to use a set
  transposition($w),insertion($w),substitution($w),deletion($w)
}

    
sub known_edits2($words) { 
  my @ary = gather {
    for edits1($words) -> $e1 {
      for edits1($e1) -> $e2 {
        take $e2 if %NWORDS{$e2} 
      }
    }
  }
  any(@ary).values
}

sub known(@words) { 
  gather for @words {take $_ if %NWORDS{$_}} ;
}

sub correct($w) {
  my @values = known([$w]) or known(edits1($w)) or known_edits2($w) or [$w];
  # single argument max() doesn't work yet
  say @values.perl;
  @values.max: {%NWORDS{$^a} <=> %NWORDS{$^b}}

}
