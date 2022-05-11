(* 
  On my tested machines the following slows down as we choose
  a larger number of domains used, even with no allocation done
  nor using more domains than there are cores.
 *)
let () =
  let core_count = try int_of_string @@ Sys.argv.(1) with _ -> 0 in
  let arr = Array.make 1000_000 0.0 in
  let pool = Domainslib.Task.setup_pool ~num_additional_domains:core_count () in
  Domainslib.Task.run pool (fun () -> 
    let t = Mtime_clock.elapsed_ns () in
    for i=0 to Array.length arr - 1 do
      arr.(i) <- arr.(i)
    done;
    Printf.printf "Execution time: %fs\n" @@ Float.div (Int64.to_float @@ Int64.sub (Mtime_clock.elapsed_ns ()) t) 1000000000.;
  );
