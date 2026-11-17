on clock 3 divider I was using some specific condition I found that works, it ended up being p & ~negflop
here I implement the more standard+generalizable solution, have the negflop be the positive condition delayed by one cycle and output is p OR n
