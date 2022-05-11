(*
  On my tested machines the following slows down significantly (2 orders of magnitude)
  as we increase the array size from 256 to 257.
*)
let () =
  let array_size = try int_of_string @@ Sys.argv.(1) with _ -> 257 in
  let t = Mtime_clock.elapsed_ns () in
  let pool = Domainslib.Task.setup_pool ~num_additional_domains:7 () in
  Domainslib.Task.run pool (fun () -> 
    Domainslib.Task.parallel_for 
    pool
    ~start:0
    ~finish:(500_000)
    ~body:(fun _ ->
      let _ret_array = Stdlib.Array.create_float array_size in
      ())
  );
  Printf.printf "Execution time: %fs\n" @@ Float.div (Int64.to_float @@ Int64.sub (Mtime_clock.elapsed_ns ()) t) 1000000000.;
