open Options
open Format

type incr_kind = Matching | Omega | Fourier | Uf | Builtin | Ac

let steps = ref 0L
let mult_f = ref 0
let mult_m = ref 0
let mult_s = ref 0
let mult_uf = ref 0
let mult_b = ref 0
let mult_a = ref 0

let incr k =
  (match k with
  | Uf -> mult_uf := !mult_uf + 1;
    if !mult_uf = 500 then
      (steps := Int64.add 1L !steps;
       mult_uf := 0)
  | Matching -> mult_m := !mult_m + 1;
    if !mult_m = 100 then
      (steps := Int64.add 1L !steps;
       mult_m := 0)
  | Omega -> mult_s := !mult_s + 1;
    if !mult_s = 2 then
      (steps := Int64.add 1L !steps;
       mult_s := 0)
  | Ac -> mult_a := !mult_a + 1;
    if !mult_a = 1 then
      (steps := Int64.add 1L !steps;
       mult_a := 0)
  | Builtin -> mult_b := !mult_b + 1;
    if !mult_b = 5 then
      (steps := Int64.add 1L !steps;
       mult_b := 0)
  | Fourier -> mult_f := !mult_f + 1;
    if !mult_f = 40 then
      (steps := Int64.add 1L !steps;
       mult_f := 0));
  if steps_bound () <> -1
    && Int64.compare !steps (Int64.of_int (steps_bound ())) > 0 then
    begin
      printf "Steps limit reached: %Ld@." !steps;
      exit 1
    end

let start () =
steps := 0L;
mult_f := 0;
mult_m := 0;
mult_s := 0;
mult_uf := 0;
mult_b := 0;
mult_a := 0

let stop () = !steps
