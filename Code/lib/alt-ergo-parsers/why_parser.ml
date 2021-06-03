
module MenhirBasics = struct
  
  exception Error = Parsing.Parse_error
  
  type token = 
    | XOR
    | WITH
    | VOID
    | UNIT
    | TYPE
    | TRUE
    | TIMES
    | THEORY
    | THEN
    | STRING of (
# 42 "why_parser.mly"
       (string)
# 20 "why_parser.ml"
  )
    | SLASH
    | SHARP
    | RIGHTSQ
    | RIGHTPAR
    | RIGHTBR
    | RIGHTARROW
    | REWRITING
    | REAL
    | QUOTE
    | QM_ID of (
# 39 "why_parser.mly"
       (string)
# 34 "why_parser.ml"
  )
    | QM
    | PV
    | PROP
    | PRED
    | PLUS
    | PERCENT
    | OR
    | OF
    | NUM of (
# 41 "why_parser.mly"
       (Num.num)
# 47 "why_parser.ml"
  )
    | NOTEQ
    | NOT
    | MINUS
    | MATCH
    | MAPS_TO
    | LT
    | LRARROW
    | LOGIC
    | LET
    | LEFTSQ
    | LEFTPAR
    | LEFTBR
    | LEFTARROW
    | LE
    | INTEGER of (
# 40 "why_parser.mly"
       (string)
# 66 "why_parser.ml"
  )
    | INT
    | IN
    | IF
    | ID of (
# 38 "why_parser.mly"
       (string)
# 74 "why_parser.ml"
  )
    | HAT
    | GT
    | GOAL
    | GE
    | FUNC
    | FORALL
    | FALSE
    | EXTENDS
    | EXISTS
    | EQUAL
    | EOF
    | END
    | ELSE
    | DOT
    | DISTINCT
    | CUT
    | COMMA
    | COLON
    | CHECK
    | CASESPLIT
    | BOOL
    | BITV
    | BAR
    | AXIOM
    | AT
    | AND
    | AC
  
end

include MenhirBasics

let _eRR =
  MenhirBasics.Error

type _menhir_env = {
  _menhir_lexer: Lexing.lexbuf -> token;
  _menhir_lexbuf: Lexing.lexbuf;
  _menhir_token: token;
  mutable _menhir_error: bool
}

and _menhir_state = 
  | MenhirState348
  | MenhirState344
  | MenhirState342
  | MenhirState337
  | MenhirState335
  | MenhirState332
  | MenhirState331
  | MenhirState330
  | MenhirState327
  | MenhirState325
  | MenhirState323
  | MenhirState321
  | MenhirState320
  | MenhirState318
  | MenhirState314
  | MenhirState312
  | MenhirState310
  | MenhirState306
  | MenhirState304
  | MenhirState300
  | MenhirState299
  | MenhirState296
  | MenhirState294
  | MenhirState292
  | MenhirState290
  | MenhirState287
  | MenhirState285
  | MenhirState283
  | MenhirState279
  | MenhirState277
  | MenhirState271
  | MenhirState269
  | MenhirState265
  | MenhirState262
  | MenhirState258
  | MenhirState255
  | MenhirState253
  | MenhirState252
  | MenhirState249
  | MenhirState247
  | MenhirState238
  | MenhirState235
  | MenhirState233
  | MenhirState230
  | MenhirState228
  | MenhirState224
  | MenhirState221
  | MenhirState220
  | MenhirState210
  | MenhirState207
  | MenhirState204
  | MenhirState200
  | MenhirState197
  | MenhirState193
  | MenhirState188
  | MenhirState182
  | MenhirState181
  | MenhirState179
  | MenhirState176
  | MenhirState171
  | MenhirState168
  | MenhirState166
  | MenhirState164
  | MenhirState162
  | MenhirState160
  | MenhirState158
  | MenhirState156
  | MenhirState154
  | MenhirState152
  | MenhirState150
  | MenhirState148
  | MenhirState146
  | MenhirState144
  | MenhirState142
  | MenhirState140
  | MenhirState138
  | MenhirState133
  | MenhirState124
  | MenhirState122
  | MenhirState120
  | MenhirState118
  | MenhirState115
  | MenhirState113
  | MenhirState112
  | MenhirState111
  | MenhirState109
  | MenhirState108
  | MenhirState107
  | MenhirState106
  | MenhirState105
  | MenhirState104
  | MenhirState102
  | MenhirState101
  | MenhirState99
  | MenhirState96
  | MenhirState92
  | MenhirState91
  | MenhirState90
  | MenhirState86
  | MenhirState82
  | MenhirState81
  | MenhirState75
  | MenhirState73
  | MenhirState72
  | MenhirState71
  | MenhirState70
  | MenhirState68
  | MenhirState64
  | MenhirState62
  | MenhirState61
  | MenhirState59
  | MenhirState57
  | MenhirState53
  | MenhirState50
  | MenhirState47
  | MenhirState46
  | MenhirState44
  | MenhirState43
  | MenhirState42
  | MenhirState40
  | MenhirState38
  | MenhirState33
  | MenhirState32
  | MenhirState24
  | MenhirState21
  | MenhirState18
  | MenhirState14
  | MenhirState13
  | MenhirState11
  | MenhirState7
  | MenhirState5
  | MenhirState2
  | MenhirState1
  | MenhirState0

# 29 "why_parser.mly"
  
  [@@@ocaml.warning "-33"]
  open AltErgoLib
  open Options
  open Parsed_interface

# 261 "why_parser.ml"

let rec _menhir_goto_bound : _menhir_env -> 'ttv_tail -> _menhir_state -> (AltErgoLib.Parsed.lexpr) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState210 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COMMA ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ID _v ->
                _menhir_run218 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState220 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState220 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run214 _menhir_env (Obj.magic _menhir_stack) MenhirState220 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run213 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState220 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QM ->
                _menhir_run212 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState220 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QM_ID _v ->
                _menhir_run211 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState220 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState220)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState220 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTSQ ->
            _menhir_run209 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | RIGHTSQ ->
            _menhir_run208 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState221
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState221)
    | _ ->
        _menhir_fail ()

and _menhir_reduce32 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (AltErgoLib.Parsed.lexpr list) = 
# 439 "why_parser.mly"
    ( [] )
# 320 "why_parser.ml"
     in
    _menhir_goto_filters _menhir_env _menhir_stack _menhir_s _v

and _menhir_run109 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState109 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState109 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState109 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState109 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState109 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState109

and _menhir_goto_list1_trigger_sep_bar : _menhir_env -> 'ttv_tail -> _menhir_state -> ((AltErgoLib.Parsed.lexpr list * bool) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState200 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (trig : (AltErgoLib.Parsed.lexpr list * bool))), _, (trigs : ((AltErgoLib.Parsed.lexpr list * bool) list))) = _menhir_stack in
        let _2 = () in
        let _v : ((AltErgoLib.Parsed.lexpr list * bool) list) = 
# 447 "why_parser.mly"
                                                   ( trig :: trigs )
# 387 "why_parser.ml"
         in
        _menhir_goto_list1_trigger_sep_bar _menhir_env _menhir_stack _menhir_s _v
    | MenhirState105 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__3_ = _endpos in
            let ((_menhir_stack, _endpos__1_, _menhir_s, _startpos__1_), _, (trigs : ((AltErgoLib.Parsed.lexpr list * bool) list))) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : ((AltErgoLib.Parsed.lexpr list * bool) list) = 
# 434 "why_parser.mly"
                                                ( trigs )
# 407 "why_parser.ml"
             in
            _menhir_goto_triggers _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_run211 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 39 "why_parser.mly"
       (string)
# 422 "why_parser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos_id_ = _endpos in
    let (id : (
# 39 "why_parser.mly"
       (string)
# 431 "why_parser.ml"
    )) = _v in
    let _startpos_id_ = _startpos in
    let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_id_ in
    let _startpos = _startpos_id_ in
    
# 485 "why_parser.mly"
                     ( mk_var (_startpos, _endpos) id )
# 439 "why_parser.ml"
     in
    _menhir_goto_bound _menhir_env _menhir_stack _menhir_s _v

and _menhir_run212 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    
# 484 "why_parser.mly"
                     ( mk_var (_startpos, _endpos) "?" )
# 455 "why_parser.ml"
     in
    _menhir_goto_bound _menhir_env _menhir_stack _menhir_s _v

and _menhir_run213 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 41 "why_parser.mly"
       (Num.num)
# 462 "why_parser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos_i_ = _endpos in
    let (i : (
# 41 "why_parser.mly"
       (Num.num)
# 471 "why_parser.ml"
    )) = _v in
    let _startpos_i_ = _startpos in
    let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_i_ in
    let _startpos = _startpos_i_ in
    
# 488 "why_parser.mly"
                     ( mk_real_const (_startpos, _endpos) i )
# 479 "why_parser.ml"
     in
    _menhir_goto_bound _menhir_env _menhir_stack _menhir_s _v

and _menhir_run214 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | INTEGER _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_i_ = _endpos in
        let (i : (
# 40 "why_parser.mly"
       (string)
# 499 "why_parser.ml"
        )) = _v in
        let _startpos_i_ = _startpos in
        let (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
        let _1 = () in
        let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_i_ in
        let _startpos = _startpos__1_ in
        
# 489 "why_parser.mly"
                     ( mk_int_const (_startpos, _endpos) i )
# 509 "why_parser.ml"
         in
        _menhir_goto_bound _menhir_env _menhir_stack _menhir_s _v
    | NUM _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_i_ = _endpos in
        let (i : (
# 41 "why_parser.mly"
       (Num.num)
# 522 "why_parser.ml"
        )) = _v in
        let _startpos_i_ = _startpos in
        let (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
        let _1 = () in
        let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_i_ in
        let _startpos = _startpos__1_ in
        
# 490 "why_parser.mly"
                     ( mk_real_const (_startpos, _endpos) i )
# 532 "why_parser.ml"
         in
        _menhir_goto_bound _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run217 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 40 "why_parser.mly"
       (string)
# 545 "why_parser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos_i_ = _endpos in
    let (i : (
# 40 "why_parser.mly"
       (string)
# 554 "why_parser.ml"
    )) = _v in
    let _startpos_i_ = _startpos in
    let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_i_ in
    let _startpos = _startpos_i_ in
    
# 487 "why_parser.mly"
                     ( mk_int_const (_startpos, _endpos) i )
# 562 "why_parser.ml"
     in
    _menhir_goto_bound _menhir_env _menhir_stack _menhir_s _v

and _menhir_run218 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 38 "why_parser.mly"
       (string)
# 569 "why_parser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos_id_ = _endpos in
    let (id : (
# 38 "why_parser.mly"
       (string)
# 578 "why_parser.ml"
    )) = _v in
    let _startpos_id_ = _startpos in
    let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_id_ in
    let _startpos = _startpos_id_ in
    
# 486 "why_parser.mly"
                     ( mk_var (_startpos, _endpos) id )
# 586 "why_parser.ml"
     in
    _menhir_goto_bound _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_and_recursive_opt : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> ((AltErgoLib.Loc.t * string list * string *
   (string * (string * AltErgoLib.Parsed.ppure_type) list) list)
  list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    match _menhir_s with
    | MenhirState47 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_others_ = _endpos in
        let (others : ((AltErgoLib.Loc.t * string list * string *
   (string * (string * AltErgoLib.Parsed.ppure_type) list) list)
  list)) = _v in
        let ((((_menhir_stack, _menhir_s, _startpos__1_), _, (ty_vars : (string list))), _endpos_ty_, _, (ty : (string)), _startpos_ty_), _endpos_enum_, _, (enum : ((string * (string * AltErgoLib.Parsed.ppure_type) list) list))) = _menhir_stack in
        let _4 = () in
        let _1 = () in
        let _endpos = _endpos_others_ in
        let _v : ((AltErgoLib.Loc.t * string list * string *
   (string * (string * AltErgoLib.Parsed.ppure_type) list) list)
  list) = let _endpos = _endpos_others_ in
        let _startpos = _startpos__1_ in
        
# 233 "why_parser.mly"
    ( ((_startpos, _endpos), ty_vars, ty, enum) :: others)
# 613 "why_parser.ml"
         in
        _menhir_goto_and_recursive_opt _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState42 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_others_ = _endpos in
        let (others : ((AltErgoLib.Loc.t * string list * string *
   (string * (string * AltErgoLib.Parsed.ppure_type) list) list)
  list)) = _v in
        let ((((_menhir_stack, _menhir_s, _startpos__1_), _, (ty_vars : (string list))), _endpos_ty_, _, (ty : (string)), _startpos_ty_), _endpos_enum_, _, (enum : ((string * (string * AltErgoLib.Parsed.ppure_type) list) list))) = _menhir_stack in
        let _4 = () in
        let _1 = () in
        let _v : (AltErgoLib.Parsed.decl) = let _endpos = _endpos_others_ in
        let _startpos = _startpos__1_ in
        
# 109 "why_parser.mly"
    (
      match others with
        | [] ->
           mk_algebraic_type_decl (_startpos, _endpos) ty_vars ty enum
        | l ->
           let l = ((_startpos, _endpos), ty_vars, ty, enum) :: l in
           let l =
             List.map
               (fun (a, b, c, d) ->
                 match mk_algebraic_type_decl a b c d with
                 | Parsed.TypeDecl [e] -> e
                 | _ -> assert false
               ) l
           in
           mk_rec_type_decl l
    )
# 646 "why_parser.ml"
         in
        _menhir_goto_decl _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_triggers : _menhir_env -> 'ttv_tail -> _menhir_state -> ((AltErgoLib.Parsed.lexpr list * bool) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState107 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTBR ->
            _menhir_run109 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | DOT ->
            _menhir_reduce32 _menhir_env (Obj.magic _menhir_stack) MenhirState108
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState108)
    | MenhirState104 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTBR ->
            _menhir_run109 _menhir_env (Obj.magic _menhir_stack) MenhirState228 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | DOT ->
            _menhir_reduce32 _menhir_env (Obj.magic _menhir_stack) MenhirState228
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState228)
    | _ ->
        _menhir_fail ()

and _menhir_goto_list0_primitive_type_sep_comma : _menhir_env -> 'ttv_tail -> _menhir_state -> (AltErgoLib.Parsed.ppure_type list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | RIGHTARROW ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | BITV ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState318
        | BOOL ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState318
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState318 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INT ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState318
        | LEFTPAR ->
            _menhir_run24 _menhir_env (Obj.magic _menhir_stack) MenhirState318 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | PROP ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_s = MenhirState318 in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__3_ = _endpos in
            let (_menhir_stack, _menhir_s, (ty_list : (AltErgoLib.Parsed.ppure_type list))) = _menhir_stack in
            let _3 = () in
            let _2 = () in
            let _endpos = _endpos__3_ in
            let _v : (AltErgoLib.Parsed.plogic_type) = 
# 188 "why_parser.mly"
   ( mk_logic_type ty_list None )
# 721 "why_parser.ml"
             in
            _menhir_goto_logic_type _menhir_env _menhir_stack _endpos _menhir_s _v
        | QUOTE ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState318 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | REAL ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState318
        | UNIT ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState318
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState318)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_list1_lexpr_or_dom_sep_comma : _menhir_env -> 'ttv_tail -> _menhir_state -> (AltErgoLib.Parsed.lexpr list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState348 | MenhirState105 | MenhirState200 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (terms : (AltErgoLib.Parsed.lexpr list)) = _v in
        let _v : (AltErgoLib.Parsed.lexpr list * bool) = 
# 451 "why_parser.mly"
   ( terms, true (* true <-> user-given trigger *) )
# 751 "why_parser.ml"
         in
        let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        (match _menhir_s with
        | MenhirState200 | MenhirState105 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BAR ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | CHECK ->
                    _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | CUT ->
                    _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | DISTINCT ->
                    _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | EXISTS ->
                    _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FALSE ->
                    _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FORALL ->
                    _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | ID _v ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | IF ->
                    _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | INTEGER _v ->
                    _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTBR ->
                    _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTPAR ->
                    _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTSQ ->
                    _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LET ->
                    _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | MATCH ->
                    _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | MINUS ->
                    _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | NOT ->
                    _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | NUM _v ->
                    _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | STRING _v ->
                    _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState200 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | TRUE ->
                    _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | VOID ->
                    _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState200 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState200)
            | RIGHTSQ ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, (trig : (AltErgoLib.Parsed.lexpr list * bool))) = _menhir_stack in
                let _v : ((AltErgoLib.Parsed.lexpr list * bool) list) = 
# 446 "why_parser.mly"
                 ( [trig] )
# 815 "why_parser.ml"
                 in
                _menhir_goto_list1_trigger_sep_bar _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | MenhirState348 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | EOF ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, (trigger : (AltErgoLib.Parsed.lexpr list * bool))) = _menhir_stack in
                let _2 = () in
                let _v : (
# 76 "why_parser.mly"
      (AltErgoLib.Parsed.lexpr list * bool)
# 837 "why_parser.ml"
                ) = 
# 91 "why_parser.mly"
                        ( trigger )
# 841 "why_parser.ml"
                 in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_1 : (
# 76 "why_parser.mly"
      (AltErgoLib.Parsed.lexpr list * bool)
# 848 "why_parser.ml"
                )) = _v in
                Obj.magic _1
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            _menhir_fail ())
    | MenhirState204 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (edl : (AltErgoLib.Parsed.lexpr list)) = _v in
        let (_menhir_stack, _menhir_s, (ed : (AltErgoLib.Parsed.lexpr))) = _menhir_stack in
        let _2 = () in
        let _v : (AltErgoLib.Parsed.lexpr list) = 
# 468 "why_parser.mly"
                                                             ( ed :: edl )
# 868 "why_parser.ml"
         in
        _menhir_goto_list1_lexpr_or_dom_sep_comma _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_sq : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (bool) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState207 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ID _v ->
            _menhir_run218 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState210 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INTEGER _v ->
            _menhir_run217 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState210 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | MINUS ->
            _menhir_run214 _menhir_env (Obj.magic _menhir_stack) MenhirState210 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NUM _v ->
            _menhir_run213 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState210 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | QM ->
            _menhir_run212 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState210 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | QM_ID _v ->
            _menhir_run211 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState210 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState210)
    | MenhirState221 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((((_menhir_stack, _endpos_e_, _menhir_s, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_), _endpos_lbr_, _, (lbr : (bool))), _, (lbnd : (AltErgoLib.Parsed.lexpr))), _, (rbnd : (AltErgoLib.Parsed.lexpr))), _endpos_rbr_, _, (rbr : (bool))) = _menhir_stack in
        let _5 = () in
        let _2 = () in
        let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_rbr_ in
        let _startpos = _startpos_e_ in
        
# 474 "why_parser.mly"
   ( mk_in_interval (_startpos, _endpos) e lbr lbnd rbnd rbr )
# 910 "why_parser.ml"
         in
        _menhir_goto_lexpr_or_dom _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_list0_lexpr_sep_comma : _menhir_env -> 'ttv_tail -> _menhir_state -> (AltErgoLib.Parsed.lexpr list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState133 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__4_ = _endpos in
            let (((_menhir_stack, _endpos_app_, _menhir_s, (app : (string)), _startpos_app_), _startpos__2_), _, (args : (AltErgoLib.Parsed.lexpr list))) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _startpos = _startpos_app_ in
            let _endpos = _endpos__4_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos__4_ in
            let _startpos = _startpos_app_ in
            
# 391 "why_parser.mly"
   ( mk_application (_startpos, _endpos) app args )
# 941 "why_parser.ml"
             in
            _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState193 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTBR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__5_ = _endpos in
            let (((_menhir_stack, _menhir_s, _startpos__1_), _endpos_filt_, _, (filt : (AltErgoLib.Parsed.lexpr)), _startpos_filt_), _, (filt_l : (AltErgoLib.Parsed.lexpr list))) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _v : (AltErgoLib.Parsed.lexpr list) = 
# 443 "why_parser.mly"
   ( filt :: filt_l )
# 968 "why_parser.ml"
             in
            _menhir_goto_filters _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_reduce7 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let (_, _endpos) = Obj.magic _menhir_stack in
    let _v : ((AltErgoLib.Loc.t * string list * string *
   (string * (string * AltErgoLib.Parsed.ppure_type) list) list)
  list) = 
# 230 "why_parser.mly"
    ( [] )
# 988 "why_parser.ml"
     in
    _menhir_goto_and_recursive_opt _menhir_env _menhir_stack _endpos _menhir_s _v

and _menhir_run43 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTPAR ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState43 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | QUOTE ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState43 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _ ->
        _menhir_reduce162 _menhir_env (Obj.magic _menhir_stack) MenhirState43
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState43

and _menhir_goto_list0_logic_binder_sep_comma : _menhir_env -> 'ttv_tail -> _menhir_state -> ((AltErgoLib.Loc.t * string * AltErgoLib.Parsed.ppure_type) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState294 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_stack = (_menhir_stack, _endpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | EQUAL ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | CHECK ->
                    _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | CUT ->
                    _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | DISTINCT ->
                    _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | EXISTS ->
                    _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FALSE ->
                    _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FORALL ->
                    _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | ID _v ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState304 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | IF ->
                    _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | INTEGER _v ->
                    _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState304 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTBR ->
                    _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTPAR ->
                    _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTSQ ->
                    _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LET ->
                    _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | MATCH ->
                    _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | MINUS ->
                    _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | NOT ->
                    _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | NUM _v ->
                    _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState304 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | STRING _v ->
                    _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState304 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | TRUE ->
                    _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | VOID ->
                    _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState304 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState304)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState327 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_stack = (_menhir_stack, _endpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | COLON ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | BITV ->
                    _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState330
                | BOOL ->
                    _menhir_run26 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState330
                | ID _v ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState330 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | INT ->
                    _menhir_run25 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState330
                | LEFTPAR ->
                    _menhir_run24 _menhir_env (Obj.magic _menhir_stack) MenhirState330 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | QUOTE ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState330 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | REAL ->
                    _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState330
                | UNIT ->
                    _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState330
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState330)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_reduce159 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : ((AltErgoLib.Parsed.lexpr list * bool) list) = 
# 433 "why_parser.mly"
                                        ( [] )
# 1143 "why_parser.ml"
     in
    _menhir_goto_triggers _menhir_env _menhir_stack _menhir_s _v

and _menhir_run105 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState105 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState105 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState105 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState105 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState105 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState105

and _menhir_goto_list1_primitive_type_sep_comma : _menhir_env -> 'ttv_tail -> _menhir_state -> (AltErgoLib.Parsed.ppure_type list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState33 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _endpos_ty_, _menhir_s, (ty : (AltErgoLib.Parsed.ppure_type))), _), _, (ty_l : (AltErgoLib.Parsed.ppure_type list))) = _menhir_stack in
        let _2 = () in
        let _v : (AltErgoLib.Parsed.ppure_type list) = 
# 200 "why_parser.mly"
                                                                  ( ty::ty_l )
# 1210 "why_parser.ml"
         in
        _menhir_goto_list1_primitive_type_sep_comma _menhir_env _menhir_stack _menhir_s _v
    | MenhirState24 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_stack = (_menhir_stack, _endpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState38 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState38)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState312 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, (ty_l : (AltErgoLib.Parsed.ppure_type list))) = _menhir_stack in
        let _v : (AltErgoLib.Parsed.ppure_type list) = 
# 204 "why_parser.mly"
                                        ( ty_l )
# 1244 "why_parser.ml"
         in
        _menhir_goto_list0_primitive_type_sep_comma _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_reduce76 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : ((AltErgoLib.Loc.t * string * AltErgoLib.Parsed.ppure_type) list) = 
# 207 "why_parser.mly"
                                           ( [] )
# 1255 "why_parser.ml"
     in
    _menhir_goto_list0_logic_binder_sep_comma _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_list1_named_ident_sep_comma : _menhir_env -> 'ttv_tail -> _menhir_state -> ((string * string) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState96 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (id : (string * string))), _, (l : ((string * string) list))) = _menhir_stack in
        let _2 = () in
        let _v : ((string * string) list) = 
# 540 "why_parser.mly"
                                                                ( id :: l )
# 1271 "why_parser.ml"
         in
        _menhir_goto_list1_named_ident_sep_comma _menhir_env _menhir_stack _menhir_s _v
    | MenhirState106 | MenhirState92 | MenhirState99 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BITV ->
                _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState101
            | BOOL ->
                _menhir_run26 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState101
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState101 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INT ->
                _menhir_run25 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState101
            | LEFTPAR ->
                _menhir_run24 _menhir_env (Obj.magic _menhir_stack) MenhirState101 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState101 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | REAL ->
                _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState101
            | UNIT ->
                _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState101
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState101)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState310 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BITV ->
                _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState312
            | BOOL ->
                _menhir_run26 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState312
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState312 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INT ->
                _menhir_run25 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState312
            | LEFTPAR ->
                _menhir_run24 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | PROP ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                let _menhir_s = MenhirState312 in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos__1_ = _endpos in
                let _1 = () in
                let _endpos = _endpos__1_ in
                let _v : (AltErgoLib.Parsed.plogic_type) = 
# 190 "why_parser.mly"
       ( mk_logic_type [] None )
# 1342 "why_parser.ml"
                 in
                _menhir_goto_logic_type _menhir_env _menhir_stack _endpos _menhir_s _v
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState312 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | REAL ->
                _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState312
            | UNIT ->
                _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState312
            | RIGHTARROW ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_s = MenhirState312 in
                let _v : (AltErgoLib.Parsed.ppure_type list) = 
# 203 "why_parser.mly"
                                        ( [] )
# 1357 "why_parser.ml"
                 in
                _menhir_goto_list0_primitive_type_sep_comma _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState312)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_list1_lexpr_sep_pv : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (AltErgoLib.Parsed.lexpr list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    match _menhir_s with
    | MenhirState287 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_body_ = _endpos in
        let (body : (AltErgoLib.Parsed.lexpr list)) = _v in
        let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos_name_, _, (name : (string)), _startpos_name_) = _menhir_stack in
        let _3 = () in
        let _1 = () in
        let _v : (AltErgoLib.Parsed.decl) = let _endpos = _endpos_body_ in
        let _startpos = _startpos__1_ in
        
# 148 "why_parser.mly"
   ( mk_rewriting (_startpos, _endpos) name body )
# 1389 "why_parser.ml"
         in
        _menhir_goto_decl _menhir_env _menhir_stack _menhir_s _v
    | MenhirState290 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos_e_l_ = _endpos in
        let (e_l : (AltErgoLib.Parsed.lexpr list)) = _v in
        let ((_menhir_stack, _endpos_e_, _menhir_s, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_), _endpos__2_) = _menhir_stack in
        let _2 = () in
        let _endpos = _endpos_e_l_ in
        let _v : (AltErgoLib.Parsed.lexpr list) = 
# 456 "why_parser.mly"
                                         ( e :: e_l )
# 1403 "why_parser.ml"
         in
        _menhir_goto_list1_lexpr_sep_pv _menhir_env _menhir_stack _endpos _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_theory_elt : _menhir_env -> 'ttv_tail -> _menhir_state -> (AltErgoLib.Parsed.decl) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | AXIOM ->
        _menhir_run277 _menhir_env (Obj.magic _menhir_stack) MenhirState283 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CASESPLIT ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState283 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | END ->
        _menhir_reduce155 _menhir_env (Obj.magic _menhir_stack) MenhirState283
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState283

and _menhir_goto_list1_match_cases : _menhir_env -> 'ttv_tail -> _menhir_state -> ((AltErgoLib.Parsed.pattern * AltErgoLib.Parsed.lexpr) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState269 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState269)
    | END ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos__5_ = _endpos in
        let (((_menhir_stack, _menhir_s, _startpos__1_), _endpos_e_, _, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_), _, (cases : ((AltErgoLib.Parsed.pattern * AltErgoLib.Parsed.lexpr) list))) = _menhir_stack in
        let _5 = () in
        let _3 = () in
        let _1 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__5_ in
        let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos__5_ in
        let _startpos = _startpos__1_ in
        
# 350 "why_parser.mly"
    ( mk_match (_startpos, _endpos) e (List.rev cases) )
# 1462 "why_parser.ml"
         in
        _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_let_binders : _menhir_env -> 'ttv_tail -> _menhir_state -> ((string * AltErgoLib.Parsed.lexpr) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState73 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState75 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState75 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState75 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState75 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState75 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState75)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState249 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _endpos_binder_, _menhir_s, (binder : (string)), _startpos_binder_), _endpos_e_, _, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_), _, (l : ((string * AltErgoLib.Parsed.lexpr) list))) = _menhir_stack in
        let _4 = () in
        let _2 = () in
        let _v : ((string * AltErgoLib.Parsed.lexpr) list) = 
# 367 "why_parser.mly"
                                                       ( (binder, e) :: l )
# 1545 "why_parser.ml"
         in
        _menhir_goto_let_binders _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_list1_label_expr_sep_PV : _menhir_env -> 'ttv_tail -> _menhir_state -> ((string * AltErgoLib.Parsed.lexpr) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState86 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTBR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__5_ = _endpos in
            let (((_menhir_stack, _menhir_s, _startpos__1_), _endpos_se_, _, (se : (AltErgoLib.Parsed.lexpr)), _startpos_se_), _, (labels : ((string * AltErgoLib.Parsed.lexpr) list))) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__5_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos__5_ in
            let _startpos = _startpos__1_ in
            
# 383 "why_parser.mly"
   ( mk_with_record (_startpos, _endpos) se labels )
# 1577 "why_parser.ml"
             in
            _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState238 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((((_menhir_stack, _endpos_id_, _menhir_s, (id : (string)), _startpos_id_), _endpos_e_, _, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_), _endpos__4_), _, (l : ((string * AltErgoLib.Parsed.lexpr) list))) = _menhir_stack in
        let _4 = () in
        let _2 = () in
        let _v : ((string * AltErgoLib.Parsed.lexpr) list) = 
# 511 "why_parser.mly"
   ( (id, e) :: l )
# 1595 "why_parser.ml"
         in
        _menhir_goto_list1_label_expr_sep_PV _menhir_env _menhir_stack _menhir_s _v
    | MenhirState82 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTBR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__3_ = _endpos in
            let ((_menhir_stack, _menhir_s, _startpos__1_), _, (labels : ((string * AltErgoLib.Parsed.lexpr) list))) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__3_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos__3_ in
            let _startpos = _startpos__1_ in
            
# 380 "why_parser.mly"
   ( mk_record (_startpos, _endpos) labels )
# 1619 "why_parser.ml"
             in
            _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_lexpr_or_dom : _menhir_env -> 'ttv_tail -> _menhir_state -> (AltErgoLib.Parsed.lexpr) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COMMA ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CHECK ->
            _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | CUT ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | DISTINCT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | EXISTS ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FALSE ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FORALL ->
            _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState204 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | IF ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INTEGER _v ->
            _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState204 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBR ->
            _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTPAR ->
            _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQ ->
            _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LET ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | MATCH ->
            _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | MINUS ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOT ->
            _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NUM _v ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState204 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STRING _v ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState204 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | TRUE ->
            _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | VOID ->
            _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState204 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState204)
    | BAR | EOF | RIGHTSQ ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, (ed : (AltErgoLib.Parsed.lexpr))) = _menhir_stack in
        let _v : (AltErgoLib.Parsed.lexpr list) = 
# 467 "why_parser.mly"
                                                ( [ed] )
# 1693 "why_parser.ml"
         in
        _menhir_goto_list1_lexpr_or_dom_sep_comma _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run208 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _1 = () in
    let _endpos = _endpos__1_ in
    let _v : (bool) = 
# 481 "why_parser.mly"
          (false)
# 1713 "why_parser.ml"
     in
    _menhir_goto_sq _menhir_env _menhir_stack _endpos _menhir_s _v

and _menhir_run209 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _endpos = _endpos__1_ in
    let _v : (bool) = 
# 480 "why_parser.mly"
         (true)
# 1728 "why_parser.ml"
     in
    _menhir_goto_sq _menhir_env _menhir_stack _endpos _menhir_s _v

and _menhir_goto_filters : _menhir_env -> 'ttv_tail -> _menhir_state -> (AltErgoLib.Parsed.lexpr list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState108 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState197 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState197 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState197 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState197 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState197 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState197)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState228 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState230 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState230 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState230 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState230 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState230 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState230)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_list2_lexpr_sep_comma : _menhir_env -> 'ttv_tail -> _menhir_state -> (AltErgoLib.Parsed.lexpr list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState111 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__4_ = _endpos in
            let (((_menhir_stack, _menhir_s, _startpos__1_), _startpos__2_), _, (dist_l : (AltErgoLib.Parsed.lexpr list))) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__4_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos__4_ in
            let _startpos = _startpos__1_ in
            
# 309 "why_parser.mly"
   ( mk_distinct (_startpos, _endpos) dist_l )
# 1885 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState188 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _endpos_e_, _menhir_s, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_), _, (el : (AltErgoLib.Parsed.lexpr list))) = _menhir_stack in
        let _2 = () in
        let _v : (AltErgoLib.Parsed.lexpr list) = 
# 494 "why_parser.mly"
                                              ( e :: el   )
# 1902 "why_parser.ml"
         in
        _menhir_goto_list2_lexpr_sep_comma _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_run188 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState188 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState188 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState188 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState188 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState188 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState188

and _menhir_goto_array_assignements : _menhir_env -> 'ttv_tail -> _menhir_state -> ((AltErgoLib.Parsed.lexpr * AltErgoLib.Parsed.lexpr) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState120 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__4_ = _endpos in
            let (((_menhir_stack, _endpos_se_, _menhir_s, (se : (AltErgoLib.Parsed.lexpr)), _startpos_se_), _endpos__2_, _startpos__2_), _, (assigns : ((AltErgoLib.Parsed.lexpr * AltErgoLib.Parsed.lexpr) list))) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _startpos = _startpos_se_ in
            let _endpos = _endpos__4_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos__4_ in
            let _startpos = _startpos_se_ in
            
# 399 "why_parser.mly"
    (
      let acc, l =
        match assigns with
	| [] -> assert false
	| (i, v)::l -> mk_array_set (_startpos, _endpos) se i v, l
      in
      List.fold_left (fun acc (i,v) ->
          mk_array_set (_startpos, _endpos) acc i v) acc l
    )
# 1991 "why_parser.ml"
             in
            _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState176 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (assign : (AltErgoLib.Parsed.lexpr * AltErgoLib.Parsed.lexpr))), _, (assign_l : ((AltErgoLib.Parsed.lexpr * AltErgoLib.Parsed.lexpr) list))) = _menhir_stack in
        let _2 = () in
        let _v : ((AltErgoLib.Parsed.lexpr * AltErgoLib.Parsed.lexpr) list) = 
# 427 "why_parser.mly"
   ( assign :: assign_l )
# 2008 "why_parser.ml"
         in
        _menhir_goto_array_assignements _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_list1_lexpr_sep_comma : _menhir_env -> 'ttv_tail -> _menhir_state -> (AltErgoLib.Parsed.lexpr list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState193 | MenhirState133 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (l : (AltErgoLib.Parsed.lexpr list)) = _v in
        let _v : (AltErgoLib.Parsed.lexpr list) = 
# 460 "why_parser.mly"
                            ( l )
# 2024 "why_parser.ml"
         in
        _menhir_goto_list0_lexpr_sep_comma _menhir_env _menhir_stack _menhir_s _v
    | MenhirState168 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (l : (AltErgoLib.Parsed.lexpr list)) = _v in
        let (_menhir_stack, _endpos_e_, _menhir_s, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
        let _2 = () in
        let _v : (AltErgoLib.Parsed.lexpr list) = 
# 464 "why_parser.mly"
                                            ( e :: l )
# 2036 "why_parser.ml"
         in
        _menhir_goto_list1_lexpr_sep_comma _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_run122 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState122 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState122 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState122 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState122 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState122 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState122

and _menhir_run124 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState124 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState124 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState124 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState124 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState124 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState124

and _menhir_run138 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState138 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState138 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState138 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState138 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState138

and _menhir_run140 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState140 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState140 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState140 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState140 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState140 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState140

and _menhir_run142 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState142 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState142 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState142 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState142 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState142 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState142

and _menhir_run144 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState144 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState144

and _menhir_run148 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState148 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState148 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState148 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState148 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState148 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState148

and _menhir_run150 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState150 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState150

and _menhir_run152 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _startpos ->
    let _menhir_stack = (_menhir_stack, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState152 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState152 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState152 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState152 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState152 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState152

and _menhir_run154 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState154 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState154 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState154

and _menhir_run166 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState166 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState166 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState166 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState166 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState166 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState166

and _menhir_run171 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState171 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState171

and _menhir_run156 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState156 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState156 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState156 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState156 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState156 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState156

and _menhir_run126 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTBR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | INTEGER _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _v, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | COMMA ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | INTEGER _v ->
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                    let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
                    let _menhir_stack = (_menhir_stack, _endpos, _v, _startpos) in
                    let _menhir_env = _menhir_discard _menhir_env in
                    let _tok = _menhir_env._menhir_token in
                    (match _tok with
                    | RIGHTBR ->
                        let _menhir_stack = Obj.magic _menhir_stack in
                        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                        let _menhir_env = _menhir_discard _menhir_env in
                        let _menhir_stack = Obj.magic _menhir_stack in
                        let _endpos__7_ = _endpos in
                        let ((((_menhir_stack, _endpos_e_, _menhir_s, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_), _startpos__3_), _endpos_i_, (i : (
# 40 "why_parser.mly"
       (string)
# 2735 "why_parser.ml"
                        )), _startpos_i_), _endpos_j_, (j : (
# 40 "why_parser.mly"
       (string)
# 2739 "why_parser.ml"
                        )), _startpos_j_) = _menhir_stack in
                        let _7 = () in
                        let _5 = () in
                        let _3 = () in
                        let _2 = () in
                        let _startpos = _startpos_e_ in
                        let _endpos = _endpos__7_ in
                        let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos__7_ in
                        let _startpos = _startpos_e_ in
                        
# 301 "why_parser.mly"
   ( mk_bitv_extract (_startpos, _endpos) e i j )
# 2752 "why_parser.ml"
                         in
                        _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
                    | _ ->
                        assert (not _menhir_env._menhir_error);
                        _menhir_env._menhir_error <- true;
                        let _menhir_stack = Obj.magic _menhir_stack in
                        let ((((_menhir_stack, _, _menhir_s, _, _), _), _, _, _), _, _, _) = _menhir_stack in
                        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let (((_menhir_stack, _, _menhir_s, _, _), _), _, _, _) = _menhir_stack in
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _, _menhir_s, _, _), _), _, _, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _, _menhir_s, _, _), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run158 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState158 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState158 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState158 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState158 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState158 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState158

and _menhir_run160 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState160 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState160 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState160 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState160 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState160 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState160

and _menhir_run162 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState162 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState162 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState162 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState162 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState162 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState162

and _menhir_run146 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState146 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState146 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState146 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState146 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState146 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState146

and _menhir_run164 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _startpos ->
    let _menhir_stack = (_menhir_stack, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState164 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState164 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState164 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState164 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState164

and _menhir_reduce74 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (AltErgoLib.Parsed.lexpr list) = 
# 459 "why_parser.mly"
                        ( [] )
# 3042 "why_parser.ml"
     in
    _menhir_goto_list0_lexpr_sep_comma _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_theory_elts : _menhir_env -> 'ttv_tail -> _menhir_state -> (AltErgoLib.Parsed.decl list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState61 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | END ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__7_ = _endpos in
            let ((((_menhir_stack, _menhir_s, _startpos__1_), _endpos_th_id_, _, (th_id : (string)), _startpos_th_id_), _endpos_th_ext_, _, (th_ext : (string)), _startpos_th_ext_), _, (th_body : (AltErgoLib.Parsed.decl list))) = _menhir_stack in
            let _7 = () in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _v : (AltErgoLib.Parsed.decl) = let _endpos = _endpos__7_ in
            let _startpos = _startpos__1_ in
            
# 102 "why_parser.mly"
   ( mk_theory (_startpos, _endpos) th_id th_ext th_body )
# 3071 "why_parser.ml"
             in
            _menhir_goto_decl _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState283 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (th_elt : (AltErgoLib.Parsed.decl))), _, (th_rest : (AltErgoLib.Parsed.decl list))) = _menhir_stack in
        let _v : (AltErgoLib.Parsed.decl list) = 
# 155 "why_parser.mly"
                                            ( th_elt :: th_rest )
# 3087 "why_parser.ml"
         in
        _menhir_goto_theory_elts _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_list1_constructors_sep_bar : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> ((string * (string * AltErgoLib.Parsed.ppure_type) list) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState13 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState42 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AXIOM | EOF | FUNC | GOAL | LOGIC | PRED | REWRITING | THEORY | TYPE ->
            _menhir_reduce7 _menhir_env (Obj.magic _menhir_stack) MenhirState42
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState42)
    | MenhirState46 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState47 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AXIOM | EOF | FUNC | GOAL | LOGIC | PRED | REWRITING | THEORY | TYPE ->
            _menhir_reduce7 _menhir_env (Obj.magic _menhir_stack) MenhirState47
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState47)
    | MenhirState53 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _endpos_cons_, _menhir_s, (cons : (string)), _startpos_cons_), _endpos__2_, (_2 : ((string * AltErgoLib.Parsed.ppure_type) list))), _endpos_cons_l_, _, (cons_l : ((string * (string * AltErgoLib.Parsed.ppure_type) list) list))) = _menhir_stack in
        let _3 = () in
        let _endpos = _endpos_cons_l_ in
        let _v : ((string * (string * AltErgoLib.Parsed.ppure_type) list) list) = 
# 223 "why_parser.mly"
                                             ( (cons, _2) :: cons_l )
# 3132 "why_parser.ml"
         in
        _menhir_goto_list1_constructors_sep_bar _menhir_env _menhir_stack _endpos _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_list1_decl : _menhir_env -> 'ttv_tail -> _menhir_state -> (AltErgoLib.Parsed.file) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EOF ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, (decls : (AltErgoLib.Parsed.file))) = _menhir_stack in
            let _2 = () in
            let _v : (
# 82 "why_parser.mly"
      (AltErgoLib.Parsed.file)
# 3155 "why_parser.ml"
            ) = 
# 87 "why_parser.mly"
                         ( decls )
# 3159 "why_parser.ml"
             in
            _menhir_goto_file_parser _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState342 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (decl : (AltErgoLib.Parsed.decl))), _, (decls : (AltErgoLib.Parsed.file))) = _menhir_stack in
        let _v : (AltErgoLib.Parsed.file) = 
# 98 "why_parser.mly"
                                 ( decl :: decls )
# 3175 "why_parser.ml"
         in
        _menhir_goto_list1_decl _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_logic_type : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (AltErgoLib.Parsed.plogic_type) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos_ty_ = _endpos in
    let (ty : (AltErgoLib.Parsed.plogic_type)) = _v in
    let (((_menhir_stack, _menhir_s, _startpos__1_), (is_ac : (AltErgoLib.Symbols.name_kind))), _, (ids : ((string * string) list))) = _menhir_stack in
    let _4 = () in
    let _1 = () in
    let _v : (AltErgoLib.Parsed.decl) = let _endpos = _endpos_ty_ in
    let _startpos = _startpos__1_ in
    
# 131 "why_parser.mly"
   ( mk_logic (_startpos, _endpos) is_ac ids ty )
# 3195 "why_parser.ml"
     in
    _menhir_goto_decl _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_list1_logic_binder_sep_comma : _menhir_env -> 'ttv_tail -> _menhir_state -> ((AltErgoLib.Loc.t * string * AltErgoLib.Parsed.ppure_type) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState296 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (binders_list : ((AltErgoLib.Loc.t * string * AltErgoLib.Parsed.ppure_type) list)) = _v in
        let (_menhir_stack, _menhir_s, (binder : (AltErgoLib.Loc.t * string * AltErgoLib.Parsed.ppure_type))) = _menhir_stack in
        let _2 = () in
        let _v : ((AltErgoLib.Loc.t * string * AltErgoLib.Parsed.ppure_type) list) = 
# 214 "why_parser.mly"
   ( binder :: binders_list )
# 3211 "why_parser.ml"
         in
        _menhir_goto_list1_logic_binder_sep_comma _menhir_env _menhir_stack _menhir_s _v
    | MenhirState327 | MenhirState294 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (binders_l : ((AltErgoLib.Loc.t * string * AltErgoLib.Parsed.ppure_type) list)) = _v in
        let _v : ((AltErgoLib.Loc.t * string * AltErgoLib.Parsed.ppure_type) list) = 
# 208 "why_parser.mly"
                                           ( binders_l )
# 3221 "why_parser.ml"
         in
        _menhir_goto_list0_logic_binder_sep_comma _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_list1_multi_logic_binder : _menhir_env -> 'ttv_tail -> _menhir_state -> (((string * string) list * AltErgoLib.Parsed.ppure_type) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState99 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (binders : ((string * string) list * AltErgoLib.Parsed.ppure_type))), _, (l : (((string * string) list * AltErgoLib.Parsed.ppure_type) list))) = _menhir_stack in
        let _2 = () in
        let _v : (((string * string) list * AltErgoLib.Parsed.ppure_type) list) = 
# 536 "why_parser.mly"
   ( binders :: l )
# 3239 "why_parser.ml"
         in
        _menhir_goto_list1_multi_logic_binder _menhir_env _menhir_stack _menhir_s _v
    | MenhirState92 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTSQ ->
            _menhir_run105 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState104 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | DOT | LEFTBR ->
            _menhir_reduce159 _menhir_env (Obj.magic _menhir_stack) MenhirState104
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState104)
    | MenhirState106 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTSQ ->
            _menhir_run105 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState107 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | DOT | LEFTBR ->
            _menhir_reduce159 _menhir_env (Obj.magic _menhir_stack) MenhirState107
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState107)
    | _ ->
        _menhir_fail ()

and _menhir_goto_list1_label_sep_PV : _menhir_env -> 'ttv_tail -> _menhir_state -> ((string * AltErgoLib.Parsed.ppure_type) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState14 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTBR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__3_ = _endpos in
            let ((_menhir_stack, _menhir_s, _startpos__1_), _, (labels : ((string * AltErgoLib.Parsed.ppure_type) list))) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _endpos = _endpos__3_ in
            let _v : ((string * AltErgoLib.Parsed.ppure_type) list) = 
# 497 "why_parser.mly"
                                             ( labels )
# 3293 "why_parser.ml"
             in
            (match _menhir_s with
            | MenhirState13 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos_record_ = _endpos in
                let (record : ((string * AltErgoLib.Parsed.ppure_type) list)) = _v in
                let (((_menhir_stack, _menhir_s, _startpos__1_), _, (ty_vars : (string list))), _endpos_ty_, _, (ty : (string)), _startpos_ty_) = _menhir_stack in
                let _4 = () in
                let _1 = () in
                let _v : (AltErgoLib.Parsed.decl) = let _endpos = _endpos_record_ in
                let _startpos = _startpos__1_ in
                
# 127 "why_parser.mly"
   ( mk_record_type_decl (_startpos, _endpos) ty_vars ty record )
# 3309 "why_parser.ml"
                 in
                _menhir_goto_decl _menhir_env _menhir_stack _menhir_s _v
            | MenhirState50 ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos__2_ = _endpos in
                let (_2 : ((string * AltErgoLib.Parsed.ppure_type) list)) = _v in
                let _1 = () in
                let _endpos = _endpos__2_ in
                let _v : ((string * AltErgoLib.Parsed.ppure_type) list) = 
# 227 "why_parser.mly"
                 ( _2 )
# 3322 "why_parser.ml"
                 in
                _menhir_goto_algebraic_args _menhir_env _menhir_stack _endpos _v
            | _ ->
                _menhir_fail ())
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState18 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _menhir_s, (lt : (string * AltErgoLib.Parsed.ppure_type))), _endpos__2_), _, (list_lt : ((string * AltErgoLib.Parsed.ppure_type) list))) = _menhir_stack in
        let _2 = () in
        let _v : ((string * AltErgoLib.Parsed.ppure_type) list) = 
# 501 "why_parser.mly"
                                                         ( lt :: list_lt )
# 3341 "why_parser.ml"
         in
        _menhir_goto_list1_label_sep_PV _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_reduce104 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.ppure_type) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _endpos_ty_, _menhir_s, (ty : (AltErgoLib.Parsed.ppure_type))) = _menhir_stack in
    let _v : (AltErgoLib.Parsed.ppure_type list) = 
# 199 "why_parser.mly"
                                                           ( [ty] )
# 3353 "why_parser.ml"
     in
    _menhir_goto_list1_primitive_type_sep_comma _menhir_env _menhir_stack _menhir_s _v

and _menhir_run33 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.ppure_type) -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BITV ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | BOOL ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState33
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState33 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INT ->
        _menhir_run25 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState33
    | LEFTPAR ->
        _menhir_run24 _menhir_env (Obj.magic _menhir_stack) MenhirState33 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | QUOTE ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState33 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | REAL ->
        _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState33
    | UNIT ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState33
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState33

and _menhir_run115 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState115 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState115

and _menhir_run117 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> Lexing.position -> (
# 39 "why_parser.mly"
       (string)
# 3399 "why_parser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos_id_ = _endpos in
    let (id : (
# 39 "why_parser.mly"
       (string)
# 3408 "why_parser.ml"
    )) = _v in
    let _startpos_id_ = _startpos in
    let (_menhir_stack, _endpos_se_, _menhir_s, (se : (AltErgoLib.Parsed.lexpr)), _startpos_se_) = _menhir_stack in
    let _startpos = _startpos_se_ in
    let _endpos = _endpos_id_ in
    let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_id_ in
    let _startpos = _startpos_se_ in
    
# 419 "why_parser.mly"
    ( mk_algebraic_test (_startpos, _endpos) se id )
# 3419 "why_parser.ml"
     in
    _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run118 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> Lexing.position -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState118 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState118

and _menhir_run120 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> Lexing.position -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState120 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState120 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState120 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState120 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState120

and _menhir_run179 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState179 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState179

and _menhir_run181 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (AltErgoLib.Parsed.lexpr) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BITV ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState181
    | BOOL ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INT ->
        _menhir_run25 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181
    | LEFTPAR ->
        _menhir_run24 _menhir_env (Obj.magic _menhir_stack) MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | QUOTE ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState181 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | REAL ->
        _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181
    | UNIT ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState181
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState181

and _menhir_goto_named_ident : _menhir_env -> 'ttv_tail -> _menhir_state -> (string * string) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState310 | MenhirState106 | MenhirState99 | MenhirState96 | MenhirState92 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COMMA ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ID _v ->
                _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState96 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState96)
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, (id : (string * string))) = _menhir_stack in
            let _v : ((string * string) list) = 
# 539 "why_parser.mly"
                                                     ( [id] )
# 3551 "why_parser.ml"
             in
            _menhir_goto_list1_named_ident_sep_comma _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState292 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EQUAL ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState306 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState306 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState306)
        | LEFTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState294 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | RIGHTPAR ->
                _menhir_reduce76 _menhir_env (Obj.magic _menhir_stack) MenhirState294
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState294)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState325 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState327 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | RIGHTPAR ->
                _menhir_reduce76 _menhir_env (Obj.magic _menhir_stack) MenhirState327
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState327)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_reduce162 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (string list) = 
# 517 "why_parser.mly"
            ( [] )
# 3669 "why_parser.ml"
     in
    _menhir_goto_type_vars _menhir_env _menhir_stack _menhir_s _v

and _menhir_run5 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | QUOTE ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState5 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState5

and _menhir_goto_ac_modifier : _menhir_env -> 'ttv_tail -> (AltErgoLib.Symbols.name_kind) -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_stack = (_menhir_stack, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState310 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState310

and _menhir_goto_lexpr : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (AltErgoLib.Parsed.lexpr) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState120 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LEFTARROW ->
            _menhir_run171 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__4_ = _endpos in
            let (((_menhir_stack, _endpos_se_, _menhir_s, (se : (AltErgoLib.Parsed.lexpr)), _startpos_se_), _endpos__2_, _startpos__2_), _endpos_e_, _, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _startpos = _startpos_se_ in
            let _endpos = _endpos__4_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos__4_ in
            let _startpos = _startpos_se_ in
            
# 396 "why_parser.mly"
   ( mk_array_get (_startpos, _endpos) se e )
# 3757 "why_parser.ml"
             in
            _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState122 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | FUNC | GOAL | IN | LEFTARROW | LOGIC | PRED | PV | REWRITING | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 263 "why_parser.mly"
   ( mk_xor (_startpos, _endpos) se1 se2 )
# 3824 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState124 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | AND | AT | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | EQUAL | FUNC | GE | GOAL | GT | IN | LE | LEFTARROW | LOGIC | LRARROW | LT | MINUS | NOTEQ | OR | PERCENT | PLUS | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | SLASH | THEN | THEORY | TIMES | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 248 "why_parser.mly"
   ( mk_mul (_startpos, _endpos) se1 se2 )
# 3851 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState193 | MenhirState168 | MenhirState133 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | COMMA ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState168 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState168 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState168 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState168 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState168)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTBR | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_e_, _menhir_s, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
            let _v : (AltErgoLib.Parsed.lexpr list) = 
# 463 "why_parser.mly"
                                            ( [e] )
# 3956 "why_parser.ml"
             in
            _menhir_goto_list1_lexpr_sep_comma _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState138 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | AND | AT | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | EQUAL | FUNC | GE | GOAL | GT | IN | LE | LEFTARROW | LOGIC | LRARROW | LT | MINUS | NOTEQ | OR | PERCENT | PLUS | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | SLASH | THEN | THEORY | TIMES | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 251 "why_parser.mly"
   ( mk_div (_startpos, _endpos) se1 se2 )
# 3983 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState140 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | FUNC | GOAL | IN | LEFTARROW | LOGIC | PRED | PV | REWRITING | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 269 "why_parser.mly"
   ( mk_implies (_startpos, _endpos) se1 se2 )
# 4044 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState142 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | AND | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | EQUAL | FUNC | GE | GOAL | GT | IN | LE | LEFTARROW | LOGIC | LRARROW | LT | MINUS | NOTEQ | OR | PLUS | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 242 "why_parser.mly"
   ( mk_add (_startpos, _endpos) se1 se2 )
# 4079 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState144 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | AND | AT | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | EQUAL | FUNC | GE | GOAL | GT | IN | LE | LEFTARROW | LOGIC | LRARROW | LT | MINUS | NOTEQ | OR | PERCENT | PLUS | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | SLASH | THEN | THEORY | TIMES | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 254 "why_parser.mly"
   ( mk_mod (_startpos, _endpos) se1 se2 )
# 4106 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState146 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | AND | AT | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | EQUAL | FUNC | GE | GOAL | GT | IN | LE | LEFTARROW | LOGIC | LRARROW | LT | MINUS | NOTEQ | OR | PERCENT | PLUS | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | SLASH | THEN | THEORY | TIMES | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_e1_, _menhir_s, (e1 : (AltErgoLib.Parsed.lexpr)), _startpos_e1_), _endpos_e2_, _, (e2 : (AltErgoLib.Parsed.lexpr)), _startpos_e2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_e1_ in
            let _endpos = _endpos_e2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_e2_ in
            let _startpos = _startpos_e1_ in
            
# 304 "why_parser.mly"
   ( mk_bitv_concat (_startpos, _endpos) e1 e2 )
# 4133 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState148 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | FUNC | GOAL | IN | LEFTARROW | LOGIC | LRARROW | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 260 "why_parser.mly"
   ( mk_or (_startpos, _endpos) se1 se2 )
# 4188 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState150 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | AND | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | EQUAL | FUNC | GE | GOAL | GT | IN | LE | LEFTARROW | LOGIC | LRARROW | LT | NOTEQ | OR | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 287 "why_parser.mly"
   ( mk_pred_not_eq (_startpos, _endpos) se1 se2 )
# 4227 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState152 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | AND | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | EQUAL | FUNC | GE | GOAL | GT | IN | LE | LEFTARROW | LOGIC | LRARROW | LT | MINUS | NOTEQ | OR | PLUS | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _startpos__2_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 245 "why_parser.mly"
   ( mk_sub (_startpos, _endpos) se1 se2 )
# 4262 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState154 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | AND | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | EQUAL | FUNC | GE | GOAL | GT | IN | LE | LEFTARROW | LOGIC | LRARROW | LT | NOTEQ | OR | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 272 "why_parser.mly"
   ( mk_pred_lt (_startpos, _endpos) se1 se2 )
# 4301 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState156 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | AND | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | EQUAL | FUNC | GE | GOAL | GT | IN | LE | LEFTARROW | LOGIC | LRARROW | LT | NOTEQ | OR | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 275 "why_parser.mly"
   ( mk_pred_le (_startpos, _endpos) se1 se2 )
# 4340 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState158 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | AND | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | EQUAL | FUNC | GE | GOAL | GT | IN | LE | LEFTARROW | LOGIC | LRARROW | LT | NOTEQ | OR | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 278 "why_parser.mly"
   ( mk_pred_gt (_startpos, _endpos) se1 se2 )
# 4379 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState160 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | AND | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | EQUAL | FUNC | GE | GOAL | GT | IN | LE | LEFTARROW | LOGIC | LRARROW | LT | NOTEQ | OR | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 281 "why_parser.mly"
   ( mk_pred_ge (_startpos, _endpos) se1 se2 )
# 4418 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState162 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | AND | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | EQUAL | FUNC | GE | GOAL | GT | IN | LE | LEFTARROW | LOGIC | LRARROW | LT | NOTEQ | OR | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 284 "why_parser.mly"
   ( mk_pred_eq (_startpos, _endpos) se1 se2 )
# 4457 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState164 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | FUNC | GOAL | IN | LEFTARROW | LOGIC | LRARROW | OR | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _startpos__2_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 257 "why_parser.mly"
   ( mk_and (_startpos, _endpos) se1 se2 )
# 4510 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState166 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | FUNC | GOAL | IN | LEFTARROW | LOGIC | PRED | PV | REWRITING | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_se1_, _menhir_s, (se1 : (AltErgoLib.Parsed.lexpr)), _startpos_se1_), _endpos_se2_, _, (se2 : (AltErgoLib.Parsed.lexpr)), _startpos_se2_) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se1_ in
            let _endpos = _endpos_se2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se2_ in
            let _startpos = _startpos_se1_ in
            
# 266 "why_parser.mly"
   ( mk_iff (_startpos, _endpos) se1 se2 )
# 4571 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState171 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | COMMA | RIGHTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_e1_, _menhir_s, (e1 : (AltErgoLib.Parsed.lexpr)), _startpos_e1_), _endpos_e2_, _, (e2 : (AltErgoLib.Parsed.lexpr)), _startpos_e2_) = _menhir_stack in
            let _2 = () in
            let _v : (AltErgoLib.Parsed.lexpr * AltErgoLib.Parsed.lexpr) = 
# 430 "why_parser.mly"
                                   ( e1, e2 )
# 4628 "why_parser.ml"
             in
            let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | COMMA ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | CHECK ->
                    _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | CUT ->
                    _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | DISTINCT ->
                    _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | EXISTS ->
                    _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FALSE ->
                    _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | FORALL ->
                    _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | ID _v ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | IF ->
                    _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | INTEGER _v ->
                    _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTBR ->
                    _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTPAR ->
                    _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LEFTSQ ->
                    _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | LET ->
                    _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | MATCH ->
                    _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | MINUS ->
                    _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | NOT ->
                    _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | NUM _v ->
                    _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | STRING _v ->
                    _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState176 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | TRUE ->
                    _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | VOID ->
                    _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState176 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState176)
            | RIGHTSQ ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, (assign : (AltErgoLib.Parsed.lexpr * AltErgoLib.Parsed.lexpr))) = _menhir_stack in
                let _v : ((AltErgoLib.Parsed.lexpr * AltErgoLib.Parsed.lexpr) list) = 
# 425 "why_parser.mly"
   ( [assign] )
# 4690 "why_parser.ml"
                 in
                _menhir_goto_array_assignements _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState176 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LEFTARROW ->
            _menhir_run171 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState113 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos_e_, _, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
        let _1 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_e_ in
        let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_e_ in
        let _startpos = _startpos__1_ in
        
# 343 "why_parser.mly"
   ( mk_check (_startpos, _endpos) e )
# 4766 "why_parser.ml"
         in
        _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState112 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos_e_, _, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
        let _1 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_e_ in
        let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_e_ in
        let _startpos = _startpos__1_ in
        
# 346 "why_parser.mly"
   ( mk_cut (_startpos, _endpos) e )
# 4781 "why_parser.ml"
         in
        _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState111 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | COMMA ->
            _menhir_run188 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState188 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | COMMA ->
            _menhir_run188 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_e1_, _menhir_s, (e1 : (AltErgoLib.Parsed.lexpr)), _startpos_e1_), _endpos_e2_, _, (e2 : (AltErgoLib.Parsed.lexpr)), _startpos_e2_) = _menhir_stack in
            let _2 = () in
            let _v : (AltErgoLib.Parsed.lexpr list) = 
# 493 "why_parser.mly"
                                              ( [e1; e2] )
# 4883 "why_parser.ml"
             in
            _menhir_goto_list2_lexpr_sep_comma _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState109 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | COMMA ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState193 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState193 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState193 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState193 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState193 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | RIGHTBR ->
                _menhir_reduce74 _menhir_env (Obj.magic _menhir_stack) MenhirState193
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState193)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTBR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__3_ = _endpos in
            let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos_filt_, _, (filt : (AltErgoLib.Parsed.lexpr)), _startpos_filt_) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : (AltErgoLib.Parsed.lexpr list) = 
# 441 "why_parser.mly"
   ( [filt] )
# 4990 "why_parser.ml"
             in
            _menhir_goto_filters _menhir_env _menhir_stack _menhir_s _v
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState197 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | FUNC | GOAL | IN | LEFTARROW | LOGIC | PRED | PV | REWRITING | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((((_menhir_stack, _menhir_s, _startpos__1_), _, (quant_vars : (((string * string) list * AltErgoLib.Parsed.ppure_type) list))), _, (triggers : ((AltErgoLib.Parsed.lexpr list * bool) list))), _, (filters : (AltErgoLib.Parsed.lexpr list))), _endpos_body_, _, (body : (AltErgoLib.Parsed.lexpr)), _startpos_body_) = _menhir_stack in
            let _5 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos_body_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_body_ in
            let _startpos = _startpos__1_ in
            
# 327 "why_parser.mly"
   (
     let vs_ty =
       List.map (fun (vs, ty) ->
         List.map (fun (v, name) -> v, name, ty) vs) quant_vars
     in
     let vs_ty = List.flatten vs_ty in
     mk_exists (_startpos, _endpos) vs_ty triggers filters body
   )
# 5065 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState348 | MenhirState105 | MenhirState200 | MenhirState204 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | IN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTSQ ->
                _menhir_run209 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState207 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | RIGHTSQ ->
                _menhir_run208 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState207
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState207)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | BAR | COMMA | EOF | RIGHTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_e_, _menhir_s, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
            let _v : (AltErgoLib.Parsed.lexpr) = 
# 472 "why_parser.mly"
   ( e )
# 5134 "why_parser.ml"
             in
            _menhir_goto_lexpr_or_dom _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState224 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | BAR | COMMA | EOF | RIGHTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_id_, _menhir_s, (id : (string)), _startpos_id_), _endpos_e_, _, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
            let _2 = () in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_e_ in
            let _startpos = _startpos_id_ in
            
# 476 "why_parser.mly"
   ( mk_maps_to (_startpos, _endpos) id e )
# 5193 "why_parser.ml"
             in
            _menhir_goto_lexpr_or_dom _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState230 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | FUNC | GOAL | IN | LEFTARROW | LOGIC | PRED | PV | REWRITING | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((((_menhir_stack, _menhir_s, _startpos__1_), _, (quant_vars : (((string * string) list * AltErgoLib.Parsed.ppure_type) list))), _, (triggers : ((AltErgoLib.Parsed.lexpr list * bool) list))), _, (filters : (AltErgoLib.Parsed.lexpr list))), _endpos_body_, _, (body : (AltErgoLib.Parsed.lexpr)), _startpos_body_) = _menhir_stack in
            let _5 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos_body_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_body_ in
            let _startpos = _startpos__1_ in
            
# 316 "why_parser.mly"
   (
     let vs_ty =
       List.map (fun (vs, ty) ->
         List.map (fun (v, name) -> v, name, ty) vs) quant_vars
     in
     let vs_ty = List.flatten vs_ty in
     mk_forall (_startpos, _endpos) vs_ty triggers filters body
   )
# 5262 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState91 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | THEN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState233 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState233 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState233)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState233 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | ELSE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState235 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState235 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState235)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState235 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | AND | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | FUNC | GOAL | IN | LEFTARROW | LOGIC | LRARROW | OR | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s, _startpos__1_), _endpos_cond_, _, (cond : (AltErgoLib.Parsed.lexpr)), _startpos_cond_), _endpos_br1_, _, (br1 : (AltErgoLib.Parsed.lexpr)), _startpos_br1_), _endpos_br2_, _, (br2 : (AltErgoLib.Parsed.lexpr)), _startpos_br2_) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos_br2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_br2_ in
            let _startpos = _startpos__1_ in
            
# 312 "why_parser.mly"
   ( mk_ite (_startpos, _endpos) cond br1 br2 )
# 5507 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState90 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | PV ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_stack = (_menhir_stack, _endpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState238 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState238)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTBR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_id_, _menhir_s, (id : (string)), _startpos_id_), _endpos_e_, _, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
            let _2 = () in
            let _v : ((string * AltErgoLib.Parsed.lexpr) list) = 
# 509 "why_parser.mly"
   ( [id, e] )
# 5577 "why_parser.ml"
             in
            _menhir_goto_list1_label_expr_sep_PV _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState81 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__3_ = _endpos in
            let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos_e_, _, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos__3_ in
            let _v : (AltErgoLib.Parsed.lexpr) = 
# 410 "why_parser.mly"
   ( e )
# 5635 "why_parser.ml"
             in
            _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState75 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | FUNC | GOAL | IN | LEFTARROW | LOGIC | PRED | PV | REWRITING | RIGHTBR | RIGHTPAR | RIGHTSQ | THEN | THEORY | TYPE | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s, _startpos__1_), _, (binders : ((string * AltErgoLib.Parsed.lexpr) list))), _endpos_e2_, _, (e2 : (AltErgoLib.Parsed.lexpr)), _startpos_e2_) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _startpos = _startpos__1_ in
            let _endpos = _endpos_e2_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_e2_ in
            let _startpos = _startpos__1_ in
            
# 340 "why_parser.mly"
   ( mk_let (_startpos, _endpos) binders e2 )
# 5703 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState247 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | COMMA ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState249 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState249)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | IN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_binder_, _menhir_s, (binder : (string)), _startpos_binder_), _endpos_e_, _, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
            let _2 = () in
            let _v : ((string * AltErgoLib.Parsed.lexpr) list) = 
# 366 "why_parser.mly"
                                 ( [binder, e] )
# 5771 "why_parser.ml"
             in
            _menhir_goto_let_binders _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState72 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BAR ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_s = MenhirState252 in
                let _menhir_stack = (_menhir_stack, _menhir_s) in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | ID _v ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState253 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState253)
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState252 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState252)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState255 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | BAR | END ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), _, (p : (AltErgoLib.Parsed.pattern))), _endpos_e_, _, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : ((AltErgoLib.Parsed.pattern * AltErgoLib.Parsed.lexpr) list) = 
# 355 "why_parser.mly"
                                              ( [p, e])
# 5900 "why_parser.ml"
             in
            _menhir_goto_list1_match_cases _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState265 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | BAR | END ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (p : (AltErgoLib.Parsed.pattern))), _endpos_e_, _, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
            let _2 = () in
            let _v : ((AltErgoLib.Parsed.pattern * AltErgoLib.Parsed.lexpr) list) = 
# 354 "why_parser.mly"
                                              ( [p, e])
# 5957 "why_parser.ml"
             in
            _menhir_goto_list1_match_cases _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState271 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | BAR | END ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s, (l : ((AltErgoLib.Parsed.pattern * AltErgoLib.Parsed.lexpr) list))), _, (p : (AltErgoLib.Parsed.pattern))), _endpos_e_, _, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _v : ((AltErgoLib.Parsed.pattern * AltErgoLib.Parsed.lexpr) list) = 
# 357 "why_parser.mly"
    ( (p,e) :: l )
# 6015 "why_parser.ml"
             in
            _menhir_goto_list1_match_cases _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState71 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos_se_, _, (se : (AltErgoLib.Parsed.lexpr)), _startpos_se_) = _menhir_stack in
        let _1 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_se_ in
        let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se_ in
        let _startpos = _startpos__1_ in
        
# 293 "why_parser.mly"
   ( mk_minus (_startpos, _endpos) se )
# 6036 "why_parser.ml"
         in
        _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState70 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos_se_, _, (se : (AltErgoLib.Parsed.lexpr)), _startpos_se_) = _menhir_stack in
        let _1 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_se_ in
        let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_se_ in
        let _startpos = _startpos__1_ in
        
# 290 "why_parser.mly"
   ( mk_not (_startpos, _endpos) se )
# 6051 "why_parser.ml"
         in
        _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState68 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (name : (
# 42 "why_parser.mly"
       (string)
# 6060 "why_parser.ml"
        )), _startpos_name_), _endpos_e_, _, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos_name_ in
        let _endpos = _endpos_e_ in
        let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_e_ in
        let _startpos = _startpos_name_ in
        
# 337 "why_parser.mly"
   ( mk_named (_startpos, _endpos) name e )
# 6070 "why_parser.ml"
         in
        _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState64 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | CASESPLIT | END ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s, _startpos__1_), _endpos_name_, _, (name : (string)), _startpos_name_), _endpos_body_, _, (body : (AltErgoLib.Parsed.lexpr)), _startpos_body_) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : (AltErgoLib.Parsed.decl) = let _endpos = _endpos_body_ in
            let _startpos = _startpos__1_ in
            
# 162 "why_parser.mly"
   ( mk_theory_case_split (_startpos, _endpos) name body )
# 6124 "why_parser.ml"
             in
            _menhir_goto_theory_elt _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState279 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | CASESPLIT | END ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s, _startpos__1_), _endpos_name_, _, (name : (string)), _startpos_name_), _endpos_body_, _, (body : (AltErgoLib.Parsed.lexpr)), _startpos_body_) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : (AltErgoLib.Parsed.decl) = let _endpos = _endpos_body_ in
            let _startpos = _startpos__1_ in
            
# 159 "why_parser.mly"
   ( mk_theory_axiom (_startpos, _endpos) name body )
# 6184 "why_parser.ml"
             in
            _menhir_goto_theory_elt _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState290 | MenhirState287 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | PV ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_stack = (_menhir_stack, _endpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState290 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState290 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState290 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState290 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState290 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | AXIOM | EOF | FUNC | GOAL | LOGIC | PRED | REWRITING | THEORY | TYPE ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let ((_menhir_stack, _endpos_e_, _menhir_s, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_), _endpos__2_) = _menhir_stack in
                let _2 = () in
                let _endpos = _endpos__2_ in
                let _v : (AltErgoLib.Parsed.lexpr list) = 
# 455 "why_parser.mly"
                                         ( [e] )
# 6281 "why_parser.ml"
                 in
                _menhir_goto_list1_lexpr_sep_pv _menhir_env _menhir_stack _endpos _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState290)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | EOF | FUNC | GOAL | LOGIC | PRED | REWRITING | THEORY | TYPE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_e_, _menhir_s, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
            let _endpos = _endpos_e_ in
            let _v : (AltErgoLib.Parsed.lexpr list) = 
# 454 "why_parser.mly"
                                         ( [e] )
# 6303 "why_parser.ml"
             in
            _menhir_goto_list1_lexpr_sep_pv _menhir_env _menhir_stack _endpos _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState304 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | EOF | FUNC | GOAL | LOGIC | PRED | REWRITING | THEORY | TYPE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((((_menhir_stack, _menhir_s, _startpos__1_), _, (app : (string * string))), _startpos__3_), _, (args : ((AltErgoLib.Loc.t * string * AltErgoLib.Parsed.ppure_type) list))), _endpos__5_), _endpos_body_, _, (body : (AltErgoLib.Parsed.lexpr)), _startpos_body_) = _menhir_stack in
            let _6 = () in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _v : (AltErgoLib.Parsed.decl) = let _endpos = _endpos_body_ in
            let _startpos = _startpos__1_ in
            
# 142 "why_parser.mly"
   ( mk_non_ground_predicate_def (_startpos, _endpos) app args body )
# 6365 "why_parser.ml"
             in
            _menhir_goto_decl _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState306 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | EOF | FUNC | GOAL | LOGIC | PRED | REWRITING | THEORY | TYPE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s, _startpos__1_), _, (app : (string * string))), _endpos_body_, _, (body : (AltErgoLib.Parsed.lexpr)), _startpos_body_) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : (AltErgoLib.Parsed.decl) = let _endpos = _endpos_body_ in
            let _startpos = _startpos__1_ in
            
# 138 "why_parser.mly"
   ( mk_ground_predicate_def (_startpos, _endpos) app body )
# 6425 "why_parser.ml"
             in
            _menhir_goto_decl _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState323 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | EOF | FUNC | GOAL | LOGIC | PRED | REWRITING | THEORY | TYPE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s, _startpos__1_), _endpos_name_, _, (name : (string)), _startpos_name_), _endpos_body_, _, (body : (AltErgoLib.Parsed.lexpr)), _startpos_body_) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : (AltErgoLib.Parsed.decl) = let _endpos = _endpos_body_ in
            let _startpos = _startpos__1_ in
            
# 151 "why_parser.mly"
   ( mk_goal (_startpos, _endpos) name body )
# 6485 "why_parser.ml"
             in
            _menhir_goto_decl _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState332 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | EOF | FUNC | GOAL | LOGIC | PRED | REWRITING | THEORY | TYPE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((((((_menhir_stack, _menhir_s, _startpos__1_), _, (app : (string * string))), _startpos__3_), _, (args : ((AltErgoLib.Loc.t * string * AltErgoLib.Parsed.ppure_type) list))), _endpos__5_), _endpos_ret_ty_, _, (ret_ty : (AltErgoLib.Parsed.ppure_type))), _), _endpos_body_, _, (body : (AltErgoLib.Parsed.lexpr)), _startpos_body_) = _menhir_stack in
            let _8 = () in
            let _6 = () in
            let _5 = () in
            let _3 = () in
            let _1 = () in
            let _v : (AltErgoLib.Parsed.decl) = let _endpos = _endpos_body_ in
            let _startpos = _startpos__1_ in
            
# 135 "why_parser.mly"
   ( mk_function_def (_startpos, _endpos) app args ret_ty body )
# 6548 "why_parser.ml"
             in
            _menhir_goto_decl _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState337 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | AXIOM | EOF | FUNC | GOAL | LOGIC | PRED | REWRITING | THEORY | TYPE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s, _startpos__1_), _endpos_name_, _, (name : (string)), _startpos_name_), _endpos_body_, _, (body : (AltErgoLib.Parsed.lexpr)), _startpos_body_) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : (AltErgoLib.Parsed.decl) = let _endpos = _endpos_body_ in
            let _startpos = _startpos__1_ in
            
# 145 "why_parser.mly"
   ( mk_generic_axiom (_startpos, _endpos) name body )
# 6608 "why_parser.ml"
             in
            _menhir_goto_decl _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState344 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run164 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AT ->
            _menhir_run146 _menhir_env (Obj.magic _menhir_stack)
        | EOF ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_e_, _menhir_s, (e : (AltErgoLib.Parsed.lexpr)), _startpos_e_) = _menhir_stack in
            let _2 = () in
            let _v : (
# 79 "why_parser.mly"
      (AltErgoLib.Parsed.lexpr)
# 6634 "why_parser.ml"
            ) = 
# 94 "why_parser.mly"
                ( e )
# 6638 "why_parser.ml"
             in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_1 : (
# 79 "why_parser.mly"
      (AltErgoLib.Parsed.lexpr)
# 6645 "why_parser.ml"
            )) = _v in
            Obj.magic _1
        | EQUAL ->
            _menhir_run162 _menhir_env (Obj.magic _menhir_stack)
        | GE ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack)
        | HAT ->
            _menhir_run126 _menhir_env (Obj.magic _menhir_stack)
        | LE ->
            _menhir_run156 _menhir_env (Obj.magic _menhir_stack)
        | LRARROW ->
            _menhir_run166 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run152 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOTEQ ->
            _menhir_run150 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack)
        | PERCENT ->
            _menhir_run144 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run142 _menhir_env (Obj.magic _menhir_stack)
        | RIGHTARROW ->
            _menhir_run140 _menhir_env (Obj.magic _menhir_stack)
        | SLASH ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack)
        | TIMES ->
            _menhir_run124 _menhir_env (Obj.magic _menhir_stack)
        | XOR ->
            _menhir_run122 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_list1_string_sep_comma : _menhir_env -> 'ttv_tail -> _menhir_state -> (string list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState258 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__4_ = _endpos in
            let (((_menhir_stack, _endpos_app_, _menhir_s, (app : (string)), _startpos_app_), _startpos__2_), _, (args : (string list))) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _v : (AltErgoLib.Parsed.pattern) = let _endpos = _endpos__4_ in
            let _startpos = _startpos_app_ in
            
# 362 "why_parser.mly"
   ( mk_pattern (_startpos, _endpos) app args )
# 6712 "why_parser.ml"
             in
            _menhir_goto_simple_pattern _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState262 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _endpos_id_, _menhir_s, (id : (string)), _startpos_id_), _, (l : (string list))) = _menhir_stack in
        let _2 = () in
        let _v : (string list) = 
# 545 "why_parser.mly"
                                              ( id :: l  )
# 6729 "why_parser.ml"
         in
        _menhir_goto_list1_string_sep_comma _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_simple_pattern : _menhir_env -> 'ttv_tail -> _menhir_state -> (AltErgoLib.Parsed.pattern) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState253 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTARROW ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState255 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState255 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState255 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState255 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState255 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState255)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState252 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTARROW ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState265 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState265 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState265)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState269 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTARROW ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState271 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState271 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState271)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_reduce137 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (string) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _endpos_var_, _menhir_s, (var : (string)), _startpos_var_) = _menhir_stack in
    let _startpos = _startpos_var_ in
    let _endpos = _endpos_var_ in
    let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_var_ in
    let _startpos = _startpos_var_ in
    
# 375 "why_parser.mly"
              ( mk_var (_startpos, _endpos) var )
# 6932 "why_parser.ml"
     in
    _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run133 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (string) * Lexing.position -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _startpos ->
    let _menhir_stack = (_menhir_stack, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState133 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState133 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState133 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState133 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState133 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | RIGHTPAR ->
        _menhir_reduce74 _menhir_env (Obj.magic _menhir_stack) MenhirState133
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState133

and _menhir_run90 : _menhir_env -> 'ttv_tail * Lexing.position * _menhir_state * (string) * Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState90 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState90 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState90 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState90 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState90 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState90

and _menhir_reduce155 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (AltErgoLib.Parsed.decl list) = 
# 154 "why_parser.mly"
         ( [] )
# 7044 "why_parser.ml"
     in
    _menhir_goto_theory_elts _menhir_env _menhir_stack _menhir_s _v

and _menhir_run62 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState62 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState62

and _menhir_run277 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState277 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState277

and _menhir_goto_algebraic_args : _menhir_env -> 'ttv_tail -> Lexing.position -> ((string * AltErgoLib.Parsed.ppure_type) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _v ->
    let _menhir_stack = (_menhir_stack, _endpos, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState53 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState53)
    | AND | AXIOM | EOF | FUNC | GOAL | LOGIC | PRED | REWRITING | THEORY | TYPE ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _endpos_cons_, _menhir_s, (cons : (string)), _startpos_cons_), _endpos__2_, (_2 : ((string * AltErgoLib.Parsed.ppure_type) list))) = _menhir_stack in
        let _endpos = _endpos__2_ in
        let _v : ((string * (string * AltErgoLib.Parsed.ppure_type) list) list) = 
# 221 "why_parser.mly"
                              ( [cons, _2] )
# 7099 "why_parser.ml"
         in
        _menhir_goto_list1_constructors_sep_bar _menhir_env _menhir_stack _endpos _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run22 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _1 = () in
    let _endpos = _endpos__1_ in
    let _v : (AltErgoLib.Parsed.ppure_type) = 
# 173 "why_parser.mly"
       ( unit_type )
# 7119 "why_parser.ml"
     in
    _menhir_goto_primitive_type _menhir_env _menhir_stack _endpos _menhir_s _v

and _menhir_run23 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _1 = () in
    let _endpos = _endpos__1_ in
    let _v : (AltErgoLib.Parsed.ppure_type) = 
# 172 "why_parser.mly"
       ( real_type )
# 7133 "why_parser.ml"
     in
    _menhir_goto_primitive_type _menhir_env _menhir_stack _endpos _menhir_s _v

and _menhir_run24 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BITV ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState24
    | BOOL ->
        _menhir_run26 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INT ->
        _menhir_run25 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24
    | LEFTPAR ->
        _menhir_run24 _menhir_env (Obj.magic _menhir_stack) MenhirState24 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | QUOTE ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState24 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | REAL ->
        _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24
    | UNIT ->
        _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState24
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState24

and _menhir_run25 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _1 = () in
    let _endpos = _endpos__1_ in
    let _v : (AltErgoLib.Parsed.ppure_type) = 
# 170 "why_parser.mly"
       ( int_type )
# 7174 "why_parser.ml"
     in
    _menhir_goto_primitive_type _menhir_env _menhir_stack _endpos _menhir_s _v

and _menhir_run26 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _1 = () in
    let _endpos = _endpos__1_ in
    let _v : (AltErgoLib.Parsed.ppure_type) = 
# 171 "why_parser.mly"
       ( bool_type )
# 7188 "why_parser.ml"
     in
    _menhir_goto_primitive_type _menhir_env _menhir_stack _endpos _menhir_s _v

and _menhir_run27 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTSQ ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _endpos, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | INTEGER _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _v, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | RIGHTSQ ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos__4_ = _endpos in
                let (((_menhir_stack, _menhir_s), _endpos__2_, _startpos__2_), _endpos_sz_, (sz : (
# 40 "why_parser.mly"
       (string)
# 7223 "why_parser.ml"
                )), _startpos_sz_) = _menhir_stack in
                let _4 = () in
                let _2 = () in
                let _1 = () in
                let _endpos = _endpos__4_ in
                let _v : (AltErgoLib.Parsed.ppure_type) = 
# 174 "why_parser.mly"
                                   ( mk_bitv_type sz )
# 7232 "why_parser.ml"
                 in
                _menhir_goto_primitive_type _menhir_env _menhir_stack _endpos _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (((_menhir_stack, _menhir_s), _, _), _, _, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_decl : _menhir_env -> 'ttv_tail -> _menhir_state -> (AltErgoLib.Parsed.decl) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | AXIOM ->
        _menhir_run335 _menhir_env (Obj.magic _menhir_stack) MenhirState342 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FUNC ->
        _menhir_run325 _menhir_env (Obj.magic _menhir_stack) MenhirState342 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | GOAL ->
        _menhir_run321 _menhir_env (Obj.magic _menhir_stack) MenhirState342 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LOGIC ->
        _menhir_run308 _menhir_env (Obj.magic _menhir_stack) MenhirState342 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | PRED ->
        _menhir_run292 _menhir_env (Obj.magic _menhir_stack) MenhirState342 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | REWRITING ->
        _menhir_run285 _menhir_env (Obj.magic _menhir_stack) MenhirState342 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | THEORY ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState342 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TYPE ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState342 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EOF ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, (decl : (AltErgoLib.Parsed.decl))) = _menhir_stack in
        let _v : (AltErgoLib.Parsed.file) = 
# 97 "why_parser.mly"
              ( [decl] )
# 7283 "why_parser.ml"
         in
        _menhir_goto_list1_decl _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState342

and _menhir_run14 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState14 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState14

and _menhir_fail : unit -> 'a =
  fun () ->
    Printf.fprintf stderr "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

and _menhir_goto_type_vars : _menhir_env -> 'ttv_tail -> _menhir_state -> (string list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState1 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState11 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState11)
    | MenhirState43 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState44 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState44)
    | _ ->
        _menhir_fail ()

and _menhir_goto_primitive_type : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (AltErgoLib.Parsed.ppure_type) -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState33 | MenhirState24 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COMMA ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState32
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState32 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | RIGHTARROW | RIGHTPAR ->
            _menhir_reduce104 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState32)
    | MenhirState21 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState40 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | PV | RIGHTBR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_id_, _menhir_s, (id : (string)), _startpos_id_), _endpos_ty_, _, (ty : (AltErgoLib.Parsed.ppure_type))) = _menhir_stack in
            let _2 = () in
            let _v : (string * AltErgoLib.Parsed.ppure_type) = 
# 504 "why_parser.mly"
                                       ( id, ty )
# 7371 "why_parser.ml"
             in
            let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | PV ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                let _menhir_stack = (_menhir_stack, _endpos) in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | ID _v ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState18 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState18)
            | RIGHTBR ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, (label_typed : (string * AltErgoLib.Parsed.ppure_type))) = _menhir_stack in
                let _v : ((string * AltErgoLib.Parsed.ppure_type) list) = 
# 500 "why_parser.mly"
                                                        ( [label_typed] )
# 7397 "why_parser.ml"
                 in
                _menhir_goto_list1_label_sep_PV _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState40)
    | MenhirState101 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState102 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | COMMA | DOT | LEFTBR | LEFTSQ ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (binders : ((string * string) list))), _endpos_ty_, _, (ty : (AltErgoLib.Parsed.ppure_type))) = _menhir_stack in
            let _2 = () in
            let _v : ((string * string) list * AltErgoLib.Parsed.ppure_type) = 
# 530 "why_parser.mly"
    ( binders, ty )
# 7424 "why_parser.ml"
             in
            let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | COMMA ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | ID _v ->
                    _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState99 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState99)
            | DOT | LEFTBR | LEFTSQ ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, (binders : ((string * string) list * AltErgoLib.Parsed.ppure_type))) = _menhir_stack in
                let _v : (((string * string) list * AltErgoLib.Parsed.ppure_type) list) = 
# 534 "why_parser.mly"
   ( [binders] )
# 7448 "why_parser.ml"
                 in
                _menhir_goto_list1_multi_logic_binder _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState102)
    | MenhirState181 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState182 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AND | AT | AXIOM | BAR | CASESPLIT | COLON | COMMA | DOT | ELSE | END | EOF | EQUAL | FUNC | GE | GOAL | GT | HAT | IN | LE | LEFTARROW | LEFTSQ | LOGIC | LRARROW | LT | MINUS | NOTEQ | OR | PERCENT | PLUS | PRED | PV | QM | QM_ID _ | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | SHARP | SLASH | THEN | THEORY | TIMES | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_se_, _menhir_s, (se : (AltErgoLib.Parsed.lexpr)), _startpos_se_), _endpos_ty_, _, (ty : (AltErgoLib.Parsed.ppure_type))) = _menhir_stack in
            let _2 = () in
            let _startpos = _startpos_se_ in
            let _endpos = _endpos_ty_ in
            let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_ty_ in
            let _startpos = _startpos_se_ in
            
# 413 "why_parser.mly"
    (  mk_type_cast (_startpos, _endpos) se ty )
# 7479 "why_parser.ml"
             in
            _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState182)
    | MenhirState299 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState300 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | COMMA | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _endpos_id_, _menhir_s, (id : (string)), _startpos_id_), _endpos_ty_, _, (ty : (AltErgoLib.Parsed.ppure_type))) = _menhir_stack in
            let _2 = () in
            let _v : (AltErgoLib.Loc.t * string * AltErgoLib.Parsed.ppure_type) = 
# 218 "why_parser.mly"
    ( ((_startpos_id_, _endpos_id_), id, ty) )
# 7500 "why_parser.ml"
             in
            let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | COMMA ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | ID _v ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState296 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState296)
            | RIGHTPAR ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, (binder : (AltErgoLib.Loc.t * string * AltErgoLib.Parsed.ppure_type))) = _menhir_stack in
                let _v : ((AltErgoLib.Loc.t * string * AltErgoLib.Parsed.ppure_type) list) = 
# 212 "why_parser.mly"
   ( [binder] )
# 7524 "why_parser.ml"
                 in
                _menhir_goto_list1_logic_binder_sep_comma _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState300)
    | MenhirState312 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COMMA ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState314
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState314 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AXIOM | EOF | FUNC | GOAL | LOGIC | PRED | REWRITING | THEORY | TYPE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_ret_ty_, _menhir_s, (ret_ty : (AltErgoLib.Parsed.ppure_type))) = _menhir_stack in
            let _endpos = _endpos_ret_ty_ in
            let _v : (AltErgoLib.Parsed.plogic_type) = 
# 196 "why_parser.mly"
   ( mk_logic_type [] (Some ret_ty) )
# 7553 "why_parser.ml"
             in
            _menhir_goto_logic_type _menhir_env _menhir_stack _endpos _menhir_s _v
        | RIGHTARROW ->
            _menhir_reduce104 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState314)
    | MenhirState318 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState320 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AXIOM | EOF | FUNC | GOAL | LOGIC | PRED | REWRITING | THEORY | TYPE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (ty_list : (AltErgoLib.Parsed.ppure_type list))), _endpos_ret_ty_, _, (ret_ty : (AltErgoLib.Parsed.ppure_type))) = _menhir_stack in
            let _2 = () in
            let _endpos = _endpos_ret_ty_ in
            let _v : (AltErgoLib.Parsed.plogic_type) = 
# 193 "why_parser.mly"
   ( mk_logic_type ty_list (Some ret_ty) )
# 7577 "why_parser.ml"
             in
            _menhir_goto_logic_type _menhir_env _menhir_stack _endpos _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState320)
    | MenhirState330 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EQUAL ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_s = MenhirState331 in
            let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState332 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState332 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState332 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState332 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState332 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState332)
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState331 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState331)
    | _ ->
        _menhir_fail ()

and _menhir_goto_list1_type_var_sep_comma : _menhir_env -> 'ttv_tail -> _menhir_state -> (string list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState7 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _endpos_alpha_, _menhir_s, (alpha : (string)), _startpos_alpha_), _, (l : (string list))) = _menhir_stack in
        let _2 = () in
        let _v : (string list) = 
# 523 "why_parser.mly"
                                                                ( alpha :: l )
# 7661 "why_parser.ml"
         in
        _menhir_goto_list1_type_var_sep_comma _menhir_env _menhir_stack _menhir_s _v
    | MenhirState5 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos__3_ = _endpos in
            let ((_menhir_stack, _menhir_s, _startpos__1_), _, (l : (string list))) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : (string list) = 
# 519 "why_parser.mly"
                                                ( l )
# 7681 "why_parser.ml"
             in
            _menhir_goto_type_vars _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_run2 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState2 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState2

and _menhir_goto_simple_expr : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (AltErgoLib.Parsed.lexpr) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState82 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack)
        | DOT ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack)
        | LEFTSQ ->
            _menhir_run120 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | QM ->
            _menhir_run118 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | QM_ID _v ->
            _menhir_run117 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | SHARP ->
            _menhir_run115 _menhir_env (Obj.magic _menhir_stack)
        | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState86 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState86)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState348 | MenhirState344 | MenhirState337 | MenhirState332 | MenhirState323 | MenhirState306 | MenhirState304 | MenhirState290 | MenhirState287 | MenhirState279 | MenhirState64 | MenhirState68 | MenhirState70 | MenhirState71 | MenhirState271 | MenhirState265 | MenhirState255 | MenhirState72 | MenhirState247 | MenhirState75 | MenhirState81 | MenhirState90 | MenhirState235 | MenhirState233 | MenhirState91 | MenhirState230 | MenhirState105 | MenhirState224 | MenhirState204 | MenhirState200 | MenhirState197 | MenhirState193 | MenhirState109 | MenhirState188 | MenhirState111 | MenhirState112 | MenhirState176 | MenhirState171 | MenhirState168 | MenhirState166 | MenhirState164 | MenhirState162 | MenhirState160 | MenhirState158 | MenhirState156 | MenhirState154 | MenhirState152 | MenhirState150 | MenhirState148 | MenhirState146 | MenhirState144 | MenhirState142 | MenhirState140 | MenhirState138 | MenhirState133 | MenhirState124 | MenhirState122 | MenhirState120 | MenhirState113 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            _menhir_run181 _menhir_env (Obj.magic _menhir_stack)
        | DOT ->
            _menhir_run179 _menhir_env (Obj.magic _menhir_stack)
        | LEFTSQ ->
            _menhir_run120 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | QM ->
            _menhir_run118 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | QM_ID _v ->
            _menhir_run117 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | SHARP ->
            _menhir_run115 _menhir_env (Obj.magic _menhir_stack)
        | AND | AT | AXIOM | BAR | CASESPLIT | COMMA | ELSE | END | EOF | EQUAL | FUNC | GE | GOAL | GT | HAT | IN | LE | LEFTARROW | LOGIC | LRARROW | LT | MINUS | NOTEQ | OR | PERCENT | PLUS | PRED | PV | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | SLASH | THEN | THEORY | TIMES | TYPE | WITH | XOR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_se_, _menhir_s, (se : (AltErgoLib.Parsed.lexpr)), _startpos_se_) = _menhir_stack in
            let _startpos = _startpos_se_ in
            let _endpos = _endpos_se_ in
            let _v : (AltErgoLib.Parsed.lexpr) = 
# 237 "why_parser.mly"
                   ( se )
# 7769 "why_parser.ml"
             in
            _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_run93 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 38 "why_parser.mly"
       (string)
# 7784 "why_parser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | STRING _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (str : (
# 42 "why_parser.mly"
       (string)
# 7799 "why_parser.ml"
        )) = _v in
        let _startpos_str_ = _startpos in
        let (_menhir_stack, _endpos_id_, _menhir_s, (id : (
# 38 "why_parser.mly"
       (string)
# 7805 "why_parser.ml"
        )), _startpos_id_) = _menhir_stack in
        let _v : (string * string) = 
# 549 "why_parser.mly"
                       ( id, str )
# 7810 "why_parser.ml"
         in
        _menhir_goto_named_ident _menhir_env _menhir_stack _menhir_s _v
    | COLON | COMMA | EQUAL | LEFTPAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos_id_, _menhir_s, (id : (
# 38 "why_parser.mly"
       (string)
# 7818 "why_parser.ml"
        )), _startpos_id_) = _menhir_stack in
        let _v : (string * string) = 
# 548 "why_parser.mly"
          ( id, "" )
# 7823 "why_parser.ml"
         in
        _menhir_goto_named_ident _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run1 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTPAR ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | QUOTE ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _ ->
        _menhir_reduce162 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState1

and _menhir_run57 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState57 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState57

and _menhir_run285 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState285 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState285

and _menhir_run292 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState292 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState292

and _menhir_run308 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | AC ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _1 = () in
        let _v : (AltErgoLib.Symbols.name_kind) = 
# 167 "why_parser.mly"
        ( Symbols.Ac )
# 7903 "why_parser.ml"
         in
        _menhir_goto_ac_modifier _menhir_env _menhir_stack _v
    | ID _ ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _v : (AltErgoLib.Symbols.name_kind) = 
# 166 "why_parser.mly"
        ( Symbols.Other )
# 7911 "why_parser.ml"
         in
        _menhir_goto_ac_modifier _menhir_env _menhir_stack _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run321 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState321 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState321

and _menhir_run325 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState325 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState325

and _menhir_goto_file_parser : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 82 "why_parser.mly"
      (AltErgoLib.Parsed.file)
# 7950 "why_parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_1 : (
# 82 "why_parser.mly"
      (AltErgoLib.Parsed.file)
# 7958 "why_parser.ml"
    )) = _v in
    Obj.magic _1

and _menhir_run335 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState335 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState335

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState348 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR
    | MenhirState344 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR
    | MenhirState342 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState337 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState335 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState332 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState331 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState330 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState327 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState325 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState323 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState321 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState320 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState318 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState314 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState312 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState310 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState306 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState304 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState300 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState299 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState296 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState294 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState292 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState290 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState287 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState285 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState283 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState279 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState277 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState271 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState269 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState265 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState262 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState258 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState255 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState253 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState252 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState249 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState247 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState238 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState235 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState233 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState230 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState228 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState224 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState221 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState220 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState210 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState207 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState204 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState200 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState197 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState193 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState188 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState182 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState181 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState179 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState176 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState171 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState168 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState166 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState164 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState162 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState160 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState158 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState156 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState154 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState152 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState150 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState148 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState146 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState144 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState142 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState140 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState138 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState133 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState124 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState122 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState120 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState118 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState115 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState113 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState112 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState111 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState109 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState108 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState107 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState106 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState105 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState104 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState102 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState101 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState99 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState96 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState92 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState91 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState90 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState86 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState82 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState81 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState75 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState73 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState72 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState71 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState70 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState68 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState64 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState62 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState61 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState59 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState57 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState53 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _, _menhir_s, _, _), _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState50 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR
    | MenhirState47 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState46 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState44 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState43 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState42 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState40 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState38 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState33 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState32 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState24 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState21 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState18 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState14 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState13 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState11 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState7 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState5 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState2 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState1 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR

and _menhir_run65 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    
# 374 "why_parser.mly"
              ( mk_void (_startpos, _endpos) )
# 8525 "why_parser.ml"
     in
    _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run66 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    
# 372 "why_parser.mly"
              ( mk_true_const (_startpos, _endpos) )
# 8543 "why_parser.ml"
     in
    _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run67 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 42 "why_parser.mly"
       (string)
# 8550 "why_parser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COLON ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CHECK ->
            _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | CUT ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | DISTINCT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | EXISTS ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FALSE ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FORALL ->
            _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState68 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | IF ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INTEGER _v ->
            _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState68 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBR ->
            _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTPAR ->
            _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQ ->
            _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LET ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | MATCH ->
            _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | MINUS ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOT ->
            _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NUM _v ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState68 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STRING _v ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState68 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | TRUE ->
            _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | VOID ->
            _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState68 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState68)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run69 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 41 "why_parser.mly"
       (Num.num)
# 8616 "why_parser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos_i_ = _endpos in
    let (i : (
# 41 "why_parser.mly"
       (Num.num)
# 8625 "why_parser.ml"
    )) = _v in
    let _startpos_i_ = _startpos in
    let _startpos = _startpos_i_ in
    let _endpos = _endpos_i_ in
    let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_i_ in
    let _startpos = _startpos_i_ in
    
# 371 "why_parser.mly"
              ( mk_real_const (_startpos, _endpos) i )
# 8635 "why_parser.ml"
     in
    _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run70 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState70 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState70 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState70 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState70 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState70

and _menhir_run71 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState71 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState71 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState71 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState71 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState71

and _menhir_run72 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState72 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState72 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState72 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState72 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState72 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState72

and _menhir_run73 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState73 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState73

and _menhir_run76 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | INTEGER _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _endpos, _v, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BAR ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | RIGHTSQ ->
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _endpos = _menhir_env._menhir_lexbuf.Lexing.lex_curr_p in
                    let _menhir_env = _menhir_discard _menhir_env in
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _endpos__5_ = _endpos in
                    let ((_menhir_stack, _endpos__1_, _menhir_s, _startpos__1_), _endpos_bv_cst_, (bv_cst : (
# 40 "why_parser.mly"
       (string)
# 8838 "why_parser.ml"
                    )), _startpos_bv_cst_) = _menhir_stack in
                    let _5 = () in
                    let _4 = () in
                    let _2 = () in
                    let _1 = () in
                    let _startpos = _startpos__1_ in
                    let _endpos = _endpos__5_ in
                    let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos__5_ in
                    let _startpos = _startpos__1_ in
                    
# 298 "why_parser.mly"
    ( mk_bitv_const (_startpos, _endpos) bv_cst )
# 8851 "why_parser.ml"
                     in
                    _menhir_goto_lexpr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let ((_menhir_stack, _, _menhir_s, _), _, _, _) = _menhir_stack in
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let ((_menhir_stack, _, _menhir_s, _), _, _, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run81 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState81 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState81 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState81 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState81 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState81

and _menhir_run82 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState82 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState82 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState82 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState82 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState82 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState82 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState82 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState82 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState82

and _menhir_run83 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 40 "why_parser.mly"
       (string)
# 8960 "why_parser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos_i_ = _endpos in
    let (i : (
# 40 "why_parser.mly"
       (string)
# 8969 "why_parser.ml"
    )) = _v in
    let _startpos_i_ = _startpos in
    let _startpos = _startpos_i_ in
    let _endpos = _endpos_i_ in
    let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_i_ in
    let _startpos = _startpos_i_ in
    
# 370 "why_parser.mly"
              ( mk_int_const (_startpos, _endpos) i )
# 8979 "why_parser.ml"
     in
    _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run91 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState91 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState91 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState91 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState91 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState91

and _menhir_run3 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> (
# 38 "why_parser.mly"
       (string)
# 9037 "why_parser.ml"
) -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _v _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos_id_ = _endpos in
    let (id : (
# 38 "why_parser.mly"
       (string)
# 9046 "why_parser.ml"
    )) = _v in
    let _startpos_id_ = _startpos in
    let _startpos = _startpos_id_ in
    let _endpos = _endpos_id_ in
    let _v : (string) = 
# 526 "why_parser.mly"
          ( id )
# 9054 "why_parser.ml"
     in
    let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
    match _menhir_s with
    | MenhirState2 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _startpos__1_), _endpos_alpha_, _, (alpha : (string)), _startpos_alpha_) = _menhir_stack in
        let _1 = () in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_alpha_ in
        let _v : (string) = 
# 514 "why_parser.mly"
                      ( alpha )
# 9068 "why_parser.ml"
         in
        let _menhir_stack = (_menhir_stack, _endpos, _menhir_s, _v, _startpos) in
        (match _menhir_s with
        | MenhirState7 | MenhirState5 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            assert (not _menhir_env._menhir_error);
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | COMMA ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | QUOTE ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState7 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState7)
            | RIGHTPAR ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _endpos_alpha_, _menhir_s, (alpha : (string)), _startpos_alpha_) = _menhir_stack in
                let _v : (string list) = 
# 522 "why_parser.mly"
                                                  ( [alpha] )
# 9094 "why_parser.ml"
                 in
                _menhir_goto_list1_type_var_sep_comma _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | MenhirState330 | MenhirState318 | MenhirState312 | MenhirState299 | MenhirState181 | MenhirState101 | MenhirState21 | MenhirState33 | MenhirState24 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_alpha_, _menhir_s, (alpha : (string)), _startpos_alpha_) = _menhir_stack in
            let _endpos = _endpos_alpha_ in
            let _v : (AltErgoLib.Parsed.ppure_type) = let _endpos = _endpos_alpha_ in
            let _startpos = _startpos_alpha_ in
            
# 178 "why_parser.mly"
                   ( mk_var_type (_startpos, _endpos) alpha )
# 9113 "why_parser.ml"
             in
            _menhir_goto_primitive_type _menhir_env _menhir_stack _endpos _menhir_s _v
        | MenhirState1 | MenhirState43 ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_alpha_, _menhir_s, (alpha : (string)), _startpos_alpha_) = _menhir_stack in
            let _v : (string list) = 
# 518 "why_parser.mly"
                    ( [alpha] )
# 9123 "why_parser.ml"
             in
            _menhir_goto_type_vars _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            _menhir_fail ())
    | MenhirState11 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EQUAL ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState13 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState13)
        | AXIOM | EOF | FUNC | GOAL | LOGIC | PRED | REWRITING | THEORY | TYPE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s, _startpos__1_), _, (ty_vars : (string list))), _endpos_ty_, _, (ty : (string)), _startpos_ty_) = _menhir_stack in
            let _1 = () in
            let _v : (AltErgoLib.Parsed.decl) = let _endpos = _endpos_ty_ in
            let _startpos = _startpos__1_ in
            
# 105 "why_parser.mly"
    ( mk_abstract_type_decl (_startpos, _endpos) ty_vars ty )
# 9155 "why_parser.ml"
             in
            _menhir_goto_decl _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState14 | MenhirState18 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BITV ->
                _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState21
            | BOOL ->
                _menhir_run26 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState21
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState21 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INT ->
                _menhir_run25 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState21
            | LEFTPAR ->
                _menhir_run24 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | REAL ->
                _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState21
            | UNIT ->
                _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState21
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState21)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState330 | MenhirState312 | MenhirState318 | MenhirState299 | MenhirState181 | MenhirState101 | MenhirState21 | MenhirState24 | MenhirState33 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _endpos_ext_ty_, _menhir_s, (ext_ty : (string)), _startpos_ext_ty_) = _menhir_stack in
        let _endpos = _endpos_ext_ty_ in
        let _v : (AltErgoLib.Parsed.ppure_type) = let _endpos = _endpos_ext_ty_ in
        let _startpos = _startpos_ext_ty_ in
        
# 176 "why_parser.mly"
                 ( mk_external_type (_startpos, _endpos) [] ext_ty )
# 9210 "why_parser.ml"
         in
        _menhir_goto_primitive_type _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState331 | MenhirState320 | MenhirState314 | MenhirState300 | MenhirState182 | MenhirState102 | MenhirState40 | MenhirState32 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _endpos_par_, _menhir_s, (par : (AltErgoLib.Parsed.ppure_type))), _endpos_ext_ty_, _, (ext_ty : (string)), _startpos_ext_ty_) = _menhir_stack in
        let _endpos = _endpos_ext_ty_ in
        let _v : (AltErgoLib.Parsed.ppure_type) = 
# 181 "why_parser.mly"
   ( mk_external_type (_startpos_ext_ty_, _endpos_ext_ty_) [par] ext_ty )
# 9221 "why_parser.ml"
         in
        _menhir_goto_primitive_type _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState38 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((((_menhir_stack, _menhir_s, _startpos__1_), _, (pars : (AltErgoLib.Parsed.ppure_type list))), _endpos__3_), _endpos_ext_ty_, _, (ext_ty : (string)), _startpos_ext_ty_) = _menhir_stack in
        let _3 = () in
        let _1 = () in
        let _endpos = _endpos_ext_ty_ in
        let _v : (AltErgoLib.Parsed.ppure_type) = 
# 184 "why_parser.mly"
   ( mk_external_type (_startpos_ext_ty_, _endpos_ext_ty_) pars ext_ty )
# 9234 "why_parser.ml"
         in
        _menhir_goto_primitive_type _menhir_env _menhir_stack _endpos _menhir_s _v
    | MenhirState44 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EQUAL ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState46 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState46)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState13 | MenhirState53 | MenhirState46 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | OF ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LEFTBR ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState50 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState50)
        | AND | AXIOM | BAR | EOF | FUNC | GOAL | LOGIC | PRED | REWRITING | THEORY | TYPE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_, _endpos) = Obj.magic _menhir_stack in
            let _v : ((string * AltErgoLib.Parsed.ppure_type) list) = 
# 226 "why_parser.mly"
  ( [] )
# 9281 "why_parser.ml"
             in
            _menhir_goto_algebraic_args _menhir_env _menhir_stack _endpos _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState57 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EXTENDS ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState59 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState59)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState59 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EQUAL ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | AXIOM ->
                _menhir_run277 _menhir_env (Obj.magic _menhir_stack) MenhirState61 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CASESPLIT ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState61 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | END ->
                _menhir_reduce155 _menhir_env (Obj.magic _menhir_stack) MenhirState61
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState61)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState62 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState64 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState64 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState64 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState64 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState64 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState64)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState238 | MenhirState86 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EQUAL ->
            _menhir_run90 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState115 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _endpos_se_, _menhir_s, (se : (AltErgoLib.Parsed.lexpr)), _startpos_se_), _endpos_label_, _, (label : (string)), _startpos_label_) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos_se_ in
        let _endpos = _endpos_label_ in
        let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_label_ in
        let _startpos = _startpos_se_ in
        
# 422 "why_parser.mly"
   ( mk_algebraic_project (_startpos, _endpos) ~guarded:true se label )
# 9423 "why_parser.ml"
         in
        _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState118 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _endpos_se_, _menhir_s, (se : (AltErgoLib.Parsed.lexpr)), _startpos_se_), _endpos__2_, _startpos__2_), _endpos_id_, _, (id : (string)), _startpos_id_) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos_se_ in
        let _endpos = _endpos_id_ in
        let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_id_ in
        let _startpos = _startpos_se_ in
        
# 416 "why_parser.mly"
    ( mk_algebraic_test (_startpos, _endpos) se id )
# 9438 "why_parser.ml"
         in
        _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState344 | MenhirState337 | MenhirState332 | MenhirState323 | MenhirState306 | MenhirState304 | MenhirState287 | MenhirState290 | MenhirState279 | MenhirState64 | MenhirState68 | MenhirState70 | MenhirState71 | MenhirState72 | MenhirState271 | MenhirState265 | MenhirState255 | MenhirState247 | MenhirState75 | MenhirState81 | MenhirState90 | MenhirState91 | MenhirState233 | MenhirState235 | MenhirState230 | MenhirState224 | MenhirState197 | MenhirState109 | MenhirState193 | MenhirState111 | MenhirState188 | MenhirState112 | MenhirState113 | MenhirState176 | MenhirState120 | MenhirState171 | MenhirState122 | MenhirState133 | MenhirState168 | MenhirState140 | MenhirState166 | MenhirState148 | MenhirState164 | MenhirState162 | MenhirState160 | MenhirState158 | MenhirState156 | MenhirState154 | MenhirState150 | MenhirState152 | MenhirState142 | MenhirState146 | MenhirState144 | MenhirState138 | MenhirState124 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTPAR ->
            _menhir_run133 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | AND | AT | AXIOM | BAR | CASESPLIT | COLON | COMMA | DOT | ELSE | END | EOF | EQUAL | FUNC | GE | GOAL | GT | HAT | IN | LE | LEFTARROW | LEFTSQ | LOGIC | LRARROW | LT | MINUS | NOTEQ | OR | PERCENT | PLUS | PRED | PV | QM | QM_ID _ | REWRITING | RIGHTARROW | RIGHTBR | RIGHTPAR | RIGHTSQ | SHARP | SLASH | THEN | THEORY | TIMES | TYPE | WITH | XOR ->
            _menhir_reduce137 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState179 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _endpos_se_, _menhir_s, (se : (AltErgoLib.Parsed.lexpr)), _startpos_se_), _endpos_label_, _, (label : (string)), _startpos_label_) = _menhir_stack in
        let _2 = () in
        let _startpos = _startpos_se_ in
        let _endpos = _endpos_label_ in
        let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos_label_ in
        let _startpos = _startpos_se_ in
        
# 386 "why_parser.mly"
   ( mk_dot_record (_startpos, _endpos) se label )
# 9468 "why_parser.ml"
         in
        _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos
    | MenhirState348 | MenhirState105 | MenhirState200 | MenhirState204 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTPAR ->
            _menhir_run133 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | MAPS_TO ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState224 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState224 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState224 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState224 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState224 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState224)
        | AND | AT | BAR | COLON | COMMA | DOT | EOF | EQUAL | GE | GT | HAT | IN | LE | LEFTSQ | LRARROW | LT | MINUS | NOTEQ | OR | PERCENT | PLUS | QM | QM_ID _ | RIGHTARROW | RIGHTSQ | SHARP | SLASH | TIMES | XOR ->
            _menhir_reduce137 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState82 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EQUAL ->
            _menhir_run90 _menhir_env (Obj.magic _menhir_stack)
        | LEFTPAR ->
            _menhir_run133 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | COLON | DOT | LEFTSQ | QM | QM_ID _ | SHARP | WITH ->
            _menhir_reduce137 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState249 | MenhirState73 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EQUAL ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState247 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState247 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState247 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState247 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState247 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState247)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState252 | MenhirState269 | MenhirState253 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LEFTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
            let _menhir_stack = (_menhir_stack, _startpos) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState258 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState258)
        | RIGHTARROW ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_id_, _menhir_s, (id : (string)), _startpos_id_) = _menhir_stack in
            let _v : (AltErgoLib.Parsed.pattern) = let _endpos = _endpos_id_ in
            let _startpos = _startpos_id_ in
            
# 360 "why_parser.mly"
             ( mk_pattern (_startpos, _endpos) id [] )
# 9638 "why_parser.ml"
             in
            _menhir_goto_simple_pattern _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState262 | MenhirState258 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COMMA ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState262 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState262)
        | RIGHTPAR ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _endpos_id_, _menhir_s, (id : (string)), _startpos_id_) = _menhir_stack in
            let _v : (string list) = 
# 544 "why_parser.mly"
    ( [ id ] )
# 9669 "why_parser.ml"
             in
            _menhir_goto_list1_string_sep_comma _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState277 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState279 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState279 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState279 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState279 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState279 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState279)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState285 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState287 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState287 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState287 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState287 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState287 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState287)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState327 | MenhirState294 | MenhirState296 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BITV ->
                _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState299
            | BOOL ->
                _menhir_run26 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState299
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState299 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INT ->
                _menhir_run25 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState299
            | LEFTPAR ->
                _menhir_run24 _menhir_env (Obj.magic _menhir_stack) MenhirState299 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | QUOTE ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState299 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | REAL ->
                _menhir_run23 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState299
            | UNIT ->
                _menhir_run22 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState299
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState299)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState321 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState323 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState323 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState323 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState323 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState323 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState323)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState335 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | CHECK ->
                _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | CUT ->
                _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | DISTINCT ->
                _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | EXISTS ->
                _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FALSE ->
                _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | FORALL ->
                _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | ID _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | IF ->
                _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | INTEGER _v ->
                _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTBR ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTPAR ->
                _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LEFTSQ ->
                _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | LET ->
                _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MATCH ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | MINUS ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | NUM _v ->
                _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | STRING _v ->
                _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState337 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | TRUE ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | VOID ->
                _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState337 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState337)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _, _menhir_s, _, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_run92 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState92 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState92

and _menhir_run84 : _menhir_env -> 'ttv_tail -> Lexing.position -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _endpos _menhir_s _startpos ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _endpos__1_ = _endpos in
    let _startpos__1_ = _startpos in
    let _1 = () in
    let _startpos = _startpos__1_ in
    let _endpos = _endpos__1_ in
    let _v : (AltErgoLib.Parsed.lexpr) = let _endpos = _endpos__1_ in
    let _startpos = _startpos__1_ in
    
# 373 "why_parser.mly"
              ( mk_false_const (_startpos, _endpos) )
# 9984 "why_parser.ml"
     in
    _menhir_goto_simple_expr _menhir_env _menhir_stack _endpos _menhir_s _v _startpos

and _menhir_run106 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ID _v ->
        _menhir_run93 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState106 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState106

and _menhir_run110 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LEFTPAR ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _startpos = _menhir_env._menhir_lexbuf.Lexing.lex_start_p in
        let _menhir_stack = (_menhir_stack, _startpos) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | CHECK ->
            _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | CUT ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | DISTINCT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | EXISTS ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FALSE ->
            _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | FORALL ->
            _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | ID _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState111 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | IF ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | INTEGER _v ->
            _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState111 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTBR ->
            _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTPAR ->
            _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LEFTSQ ->
            _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | LET ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | MATCH ->
            _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | MINUS ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NOT ->
            _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | NUM _v ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState111 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | STRING _v ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState111 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | TRUE ->
            _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | VOID ->
            _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState111 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState111)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run112 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState112 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState112 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState112 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState112 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState112

and _menhir_run113 : _menhir_env -> 'ttv_tail -> _menhir_state -> Lexing.position -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _startpos ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _startpos) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState113 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState113 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState113 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState113 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState113 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState113

and _menhir_discard : _menhir_env -> _menhir_env =
  fun _menhir_env ->
    let lexer = _menhir_env._menhir_lexer in
    let lexbuf = _menhir_env._menhir_lexbuf in
    let _tok = lexer lexbuf in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    }

and _menhir_init : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> _menhir_env =
  fun lexer lexbuf ->
    let _tok = Obj.magic () in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    }

and file_parser : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
# 82 "why_parser.mly"
      (AltErgoLib.Parsed.file)
# 10192 "why_parser.ml"
) =
  fun lexer lexbuf ->
    let _menhir_env = _menhir_init lexer lexbuf in
    Obj.magic (let _menhir_stack = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | AXIOM ->
        _menhir_run335 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EOF ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState0 in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _1 = () in
        let _v : (
# 82 "why_parser.mly"
      (AltErgoLib.Parsed.file)
# 10210 "why_parser.ml"
        ) = 
# 88 "why_parser.mly"
      ( [] )
# 10214 "why_parser.ml"
         in
        _menhir_goto_file_parser _menhir_env _menhir_stack _menhir_s _v
    | FUNC ->
        _menhir_run325 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | GOAL ->
        _menhir_run321 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LOGIC ->
        _menhir_run308 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | PRED ->
        _menhir_run292 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | REWRITING ->
        _menhir_run285 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | THEORY ->
        _menhir_run57 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TYPE ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0)

and lexpr_parser : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
# 79 "why_parser.mly"
      (AltErgoLib.Parsed.lexpr)
# 10239 "why_parser.ml"
) =
  fun lexer lexbuf ->
    let _menhir_env = _menhir_init lexer lexbuf in
    Obj.magic (let _menhir_stack = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState344 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState344 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState344 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState344 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState344 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState344)

and trigger_parser : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
# 76 "why_parser.mly"
      (AltErgoLib.Parsed.lexpr list * bool)
# 10295 "why_parser.ml"
) =
  fun lexer lexbuf ->
    let _menhir_env = _menhir_init lexer lexbuf in
    Obj.magic (let _menhir_stack = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CHECK ->
        _menhir_run113 _menhir_env (Obj.magic _menhir_stack) MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | CUT ->
        _menhir_run112 _menhir_env (Obj.magic _menhir_stack) MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | DISTINCT ->
        _menhir_run110 _menhir_env (Obj.magic _menhir_stack) MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | EXISTS ->
        _menhir_run106 _menhir_env (Obj.magic _menhir_stack) MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FALSE ->
        _menhir_run84 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | FORALL ->
        _menhir_run92 _menhir_env (Obj.magic _menhir_stack) MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | ID _v ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState348 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | IF ->
        _menhir_run91 _menhir_env (Obj.magic _menhir_stack) MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | INTEGER _v ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState348 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTBR ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTPAR ->
        _menhir_run81 _menhir_env (Obj.magic _menhir_stack) MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LEFTSQ ->
        _menhir_run76 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | LET ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack) MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MATCH ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | MINUS ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | NUM _v ->
        _menhir_run69 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState348 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | STRING _v ->
        _menhir_run67 _menhir_env (Obj.magic _menhir_stack) MenhirState348 _v _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | TRUE ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | VOID ->
        _menhir_run65 _menhir_env (Obj.magic _menhir_stack) _menhir_env._menhir_lexbuf.Lexing.lex_curr_p MenhirState348 _menhir_env._menhir_lexbuf.Lexing.lex_start_p
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState348)

# 269 "/gnatmail/sandbox/a2c2/x86_64-darwin/menhir/pkg/share/menhir/standard.mly"
  

# 10351 "why_parser.ml"
