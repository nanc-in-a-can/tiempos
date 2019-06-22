
~lista = [\alejandro, \diego, \aaron, \eduardo, \rossana, \milo, \nefi, \ivan, \emilio, \marianne];

~ensambles= ~lista.powerset;

~ensambles1= Pxrand(~ensambles,inf).asStream;

~lista.scramble[0..2];

~join = {|strArr| strArr.inject("", {|acc, str| if(acc == "", {acc}, {acc++","})+str})};


(
~cuatroEnsambles = {|lista|
    var lista_ = lista.scramble;
    var ens = (0..(1..6).choose)
    .inject([1,1,1,1], {|acc, nel|
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
);


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
);





