# VOODOO LINE-NOISE
my($C,$M,$P,$N,$S);END{print"1..$C\n$M";print"\nfailed: $N\n"if$N}
sub ok{$C++; $M.= ($_[0]||!@_)?"ok $C\n":($N++,"not ok $C (".
((caller 1)[1]||(caller 0)[1]).":".((caller 1)[2]||(caller 0)[2]).")\n")}
sub try{$P=qr/^$_[0]$/}sub fail{ok($S=$_[0]!~$P)}sub pass{ok($S=$_[0]=~$P)}

# LOAD

use Regexp::Common;
ok;


try $RE{delimited}{q{-delim="}};

pass q{"a few words "};
pass q{"a few \"words\" "};
pass q{"a few 'words' "};
fail q{"a few "words" "};
fail q{'a few words '};
fail q{'a few \"words\" '};
fail q{'a few "words" '};
fail q{a "few" words "};


try $RE{delimited}{q{-delim="}}{q{-esc="}};

pass q{"a few words "};
fail q{"a few \"words\" "};
pass q{"a few ""words"" "};
pass q{"a few 'words' "};
fail q{"a few "words" "};
fail q{a "few" words "};


try $RE{delimited}{q{-delim='}};

fail q{"a few words "};
fail q{"a few \"words\" "};
fail q{"a few 'words' "};
fail q{"a few "words" "};
pass q{'a few words '};
pass q{'a few \"words\" '};
pass q{'a few "words" '};
fail q{a "few" words "};


try $RE{quoted};

pass q{"a few words "};
pass q{"a few \"words\" "};
pass q{"a few 'words' "};
fail q{"a few "words" "};
pass q{'a few words '};
pass q{'a few \"words\" '};
pass q{'a few "words" '};
fail q{a "few" words "};


try $RE{quoted}{q{-esc=_!}};

pass q{"a few words "};
fail q{"a few \"words\" "};
pass q{"a few _"words_" "};
pass q{"a few 'words' "};
fail q{"a few "words" "};
pass q{'a few words '};
fail q{'a few \'words\' '};
pass q{'a few !'words!' '};
pass q{'a few "words" '};
fail q{a "few" words "};

try $RE{quoted}{q{-esc=}};

pass q{"a few words "};
fail q{"a few \"words\" "};
fail q{"a few _"words_" "};
pass q{"a few 'words' "};
fail q{"a few "words" "};
pass q{'a few words '};
fail q{'a few \'words\' '};
fail q{'a few !'words!' '};
pass q{'a few "words" '};
fail q{a "few" words "};
