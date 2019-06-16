
~lista = ["alejandro", "diego", "aaron", "eduardo", "rossana", "milo", "nefi", "ivan", "emilio", "marianne"];

~ensambles= ~lista.powerset;


~ensambles1= Pxrand(~ensambles,inf).asStream;

~lista.scramble[0..2];

~join = {|strArr| strArr.inject("", {|acc, str| if(acc == "", {acc}, {acc++","})+str})};



//compila para mandar un ensamble
~netAddr.sendMsg("/ensemble1", ~join.(~ensambles1.next).postln);
~netAddr.sendMsg("/ensemble2", ~join.(~ensambles1.next).postln);
~netAddr.sendMsg("/ensemble3", ~join.(~ensambles1.next).postln);
~netAddr.sendMsg("/ensemble4", ~join.(~ensambles1.next).postln);
