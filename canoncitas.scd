(
 var citas = [
    "Contrary to common belief, perhaps time does not keep everything from happening all at once, but is the nucleus that holds all the mixed realities together",

    "[l]abour, thus measured by time, does not seem, indeed, to be the labour of different persons, but on the contrary the different working individuals seem to be the mere organs of this labour",

    "Sleep poses the idea of a human need and interval of time that cannot be colonized and harnessed to a massive engine of profitability, and thus remains an incongruous anomaly and site of crisis in the global present.",

    "Just as sonic complementarity, but in another way, algorithmic complementarity is a typical dilemma in the rethinking of time: unable to resolve the contradiction, it gives rise to numerous partial solutions, each of which provide a medium of time, and inform their own theory of time.",

    "Los conceptos siempre nos darán perspectivas sobre el tiempo [...] pero jamás nos darán el tiempo mismo. El tiempo no se puede confinar dentro de una o varias representaciones conceptuales. ¿Qué pasará si tomamos la duración en su forma verdadera, interior, como la sucesión de nuestros estados de conciencia? Porque la duración es eso: es lo que encontramos en el fondo de nosotros mismos, cuando nos miramos, cuando nos permitimos vivir la vida de la conciencia, la vida interior.",

    "Just as a piece of music compresses time [...], so the possibility becomes concrete that things could also be different than they are",

    "Time can only appear at the intersection of various times."
];
var repeats = [7,4,3,6,2,1,5];
var citasNotes = (1..citas.size).collect({|c, i| c!(repeats[i])}).flatten.postln;
var durs = citasNotes.collect({|x, i| [1,2,3,2].wrapAt(i)});
var citasCan = FluentCan(\citas,
    durs: durs,
    notes: citasNotes,
    transps: 0!4,
   // transps: [_.rotate(0), _.rotate(-1), _.rotate(-2), _.rotate(-3)],
    tempos: [60, 60, 60, 60]*4,
    cp: 7+4+3
);

//converts a list of durations into moments in time
var scheduledEventsFromDurs = {|durs|
    var result = durs.inject([1], {|acc, dur| acc ++ (acc.last + dur)});
    result[0..result.size -2]; // las event is the moment at which the sequence ends, so we remove it
};


var durs_ = (citasCan.canon.canon.collect(_.durs)[0].normalizeSum*~lengthToPlay).collect(_.round);
var schedule_ = scheduledEventsFromDurs.(durs_);

~schedule = {|voiceIndex, symbol, ratio|
    var citasNotes = citasCan.canon.canon.collect(_.notes)[voiceIndex] - 1;
    [0, {""}]++schedule_.collect({|event, i|
        var cita = citas[citasNotes[i]];
        [event, {cita}]
}).flatten++[{"nel"}]
};

~schedule2 = {|voiceIndex, symbol, ratio|
    var citasNotes = citasCan.canon.canon.collect(_.notes)[voiceIndex] - 1;
    [0, {""}]++schedule_.collect({|event, i|
        var cita = citas[citasNotes[i]];
        [event, {cita}]
}).flatten++[{"nel"}]
};
~durs = durs_;
// ~schedule.(0)
)




