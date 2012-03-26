# elisp hash library

* this is lisp hash library
* it's esay to used hash

## list-to-hash

    (setq arg
    '(
     list-test		'("a"  "foo"
        		   "b"	"bar"
        		   "c"	"baz")
     
     list-test2		 '("a"	"foo"
        		   "b"	"bar"
        		   "list"  '( "a"  "list-test2 a"
        			      "b"  "list-test2 b"
        			     ))
     
     ruby-mode		"ruby"
     lisp-interaction-mode	"bash"
     perl-mode		"perl"
     a		       '("b"	   '("c"  '("d"	 "eeee" )
        			     )
        		)
     "a"            "hoge"
     
    ))

    
    ;make hash
    (setq hash (list-to-hash arg))
    

## get-hash

    (get-hash hash 'ruby-mode)
    ;=> "ruby"
     
    (get-hash hash 'list-test "a")
    ;=> "foo"
     
    (get-hash hash 'a "b" "c" "d")
    ;=> "eeee"
    
    (get-hash hash "a" )
    ;=> "hoge"
    

    (get-hash hash 'hoge )
    ;=> nil
    
    (get-hash hash 'b "c" "d" "e")
    ;=> nil

## dump-hash


     (dump-hash hash)
    
    ;result
    "list-test => 
            a => foo ,
            b => bar ,
            c => baz  
    list-test2 => 
            a => foo ,
            b => bar ,
            list => 
                    a => list-test2 a ,
                    b => list-test2 b  
    ruby-mode => ruby ,
    lisp-interaction-mode => bash ,
    perl-mode => perl ,
    a => 
            b => 
                    c => 
                            d => eeee
    a => hoge "

## append-hash

    ;make-hash-table
    (setq a_hash #s(hash-table test equal data( "a" "hoge"	 "b" "fuga" "c" "ccc")))
    (setq b_hash #s(hash-table test equal data( "a" "test"	 "d" "ddd" "e" "eeee")))
    (setq c_hash #s(hash-table test equal data( "f" "fffff"	 "g" "ggg" )))
     
    ;append hash
    (setq ap_hash (append-hash a_hash b_hash c_hash))
     
     
    ;check
    (dump-hash ap_hash)
    ;=> "a => test ,
    ;=> b => fuga ,
    ;=> c => ccc ,
    ;=> d => ddd ,
    ;=> e => eeee ,
    ;=> f => fffff ,
    ;=> g => ggg "

