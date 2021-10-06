(lambda map [exe items]
  (let [out {}]
    (each [idx val (ipairs items)]
      (tset out idx (exe val)))
    out))


{:buttons (fn [...]
           `(gears.table.join
                ,(map (fn
                       [bind]
                       (if (= 2 (length bind)) 
                           `(awful.button {}          ,(. bind 1) ,(. bind 2)) 
                           `(awful.button ,(. bind 1) ,(. bind 2) ,(. bind 3))))
                      [...])))}
            
