
~lista = [\alejandro, \diego, \aaron, \eduardo, \rossana, \milo, \nefi, \ivan, \emilio, \marianne];

~ensambles= ~lista.powerset;


~ensambles1= Pxrand(~ensambles,inf).asStream;

~lista.scramble[0..2];

~join = {|strArr| strArr.inject("", {|acc, str| if(acc == "", {acc}, {acc++","})+str})};



//compila para mandar un ensamble
~netAddr.sendMsg("/ensamble0", ~join.(~ensambles1.next).postln);
~netAddr.sendMsg("/ensamble1", ~join.(~ensambles1.next).postln);
~netAddr.sendMsg("/ensamble2", ~join.(~ensambles1.next).postln);
~netAddr.sendMsg("/ensamble3", ~join.(~ensambles1.next).postln);

(
~cuatroEnsambles = {|lista|
    var lista_ = lista.scramble;
    var ens = (0..(1..6).choose)
    .inject([1,1,1,1], {|acc, nel|
        nel.postln;
        if(acc.sum == (lista.size -1),
            {acc},
            {
                var index = (0..3).choose;
                acc[index] = acc[index] + 1;
            }
        )
    }).collect(1!_);
    lista_.reshapeLike(ens)
};
~cuatroEnsambles.(~lista);
)


(
~instrucciones = [
    "Stacatto",
    "Pedal",
    "Pedal irregular",
    "Sonido que nace, crece, (se reproduce) y muere",
    "Adornar el pulso",
    "Cada vez más breve",
    "Cada vez más largo",
    "Sólido",
    "Líquido",
    "Gaseoso",
    "Elástico",
    "Cada vez más largo",
    "Accelerando",
    "Rallentando",
    "Libre"
].collect({|i, index| index});
)







(
var ens = ~cuatroEnsambles.(~lista);
var inst = ~instrucciones.choose;
~netAddr.sendMsg("/ensamble0", ~join.(ens[0]).postln);
~netAddr.sendMsg("/ensamble1", ~join.(ens[1]).postln);
~netAddr.sendMsg("/ensamble2", ~join.(ens[2]).postln);
~netAddr.sendMsg("/ensamble3", ~join.(ens[3]).postln);
~netAddr.sendMsg("/instruccion0", inst);
~netAddr.sendMsg("/instruccion1", inst);
~netAddr.sendMsg("/instruccion2", inst);
~netAddr.sendMsg("/instruccion3", inst);
)
