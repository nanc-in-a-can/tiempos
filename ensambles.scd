


// quienes tocan?



~lista = ["alejandro", "diego", "aaron", "eduardo", "rossana", "milo", "nefi", "ivan", "emilio", "marianne"];

~ensambles= ~lista.powerset;

// primer modalidad

~ensambles1= Pxrand(~ensambles,inf).asStream;
~ensambles2= Pxrand(~ensambles,inf).asStream;
~ensambles3= Pxrand(~ensambles,inf).asStream;
~ensambles4= Pxrand(~ensambles,inf).asStream;

// segunda modalidad

// revuelve los nombres y escoge un rango [0..2] escoge los primeros 3

~lista.scramble[0..2]





~msg= ~ensambles1.next

~netAddr.sendMsg("/ensemble4", ~msg.next.postln);

~netAddr.sendMsg("/ensemble1", "diego y eduardo".postln);