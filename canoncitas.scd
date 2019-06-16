(
 var citas = [
    "Contrary to common belief, perhaps time does not keep everything from happening all at once, but is the nucleus that holds all the mixed realities together",

    "[l]abour, thus measured by time, does not seem, indeed, to be the labour of different persons, but on the contrary the different working individuals seem to be the mere organs of this labour",

    "Sleep poses the idea of a human need and interval of time that cannot be colonized and harnessed to a massive engine of profitability, and thus remains an incongruous anomaly and site of crisis in the global present",

    "Just as sonic complementarity, but in another way, algorithmic complementarity is a typical dilemma in the rethinking of time: unable to resolve the contradiction, it gives rise to numerous partial solutions, each of which provide a medium of time, and inform their own theory of time",

    "Los conceptos siempre nos dan perspectivas sobre el tiempo [...] pero jamas nos dan el tiempo mismo.Porque la duracion es eso: es lo que encontramos en el fondo de nosotros mismos, cuando nos miramos, cuando nos permitimos vivir la vida de la conciencia, la vida interior",

    "Just as a piece of music compresses time [...], so the possibility becomes concrete that things could also be different than they are",

    "Time can only appear at the intersection of various times"
];
var instrucciones = [
	"toca como si el fin de la historia fuera real",
	"reproduce el sonido de una burbuja temporal explotando",
	"te subes a un taxi y le dices a un conductor: maneje a donde vamos, le doy las direcciones cuando lleguemos",
	"tan lento como sea posible",
	"la flecha del tiempo se rompe",
	"instrucciones6",
	"instrucciones7"
];
var repeatsCitas = [7,4,3,6,2,1,5];
var repeatsInstr = repeatsCitas.scramble;
var citasNotes = (1..citas.size).collect({|c, i| c!(repeatsCitas[i])}).flatten.postln;
var instrNotes = (1..instrucciones.size).collect({|c, i| c!(repeatsInstr[i])}).flatten.postln;
var dursCit = citasNotes.collect({|x, i| [1,2,3,2].wrapAt(i)});
var dursInstr = instrNotes.collect({|x, i| [1,2,3,2].wrapAt(i)});
var citasCan = FluentCan(\citas,
    durs: dursCit,
    notes: citasNotes,
    transps: 0!4,
   // transps: [_.rotate(0), _.rotate(-1), _.rotate(-2), _.rotate(-3)],
    tempos: [60, 60, 60, 60]*4,
    cp: 7+4+3
);
var instrCan = FluentCan(\instrucciones,
    durs: dursInstr,
    notes: instrNotes,
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


var dursCits_ = (citasCan.canon.canon.collect(_.durs)[0].normalizeSum*~lengthToPlay).collect(_.round);
var dursInstr_ = (instrCan.canon.canon.collect(_.durs)
[0].normalizeSum*~lengthToPlay).collect(_.round);
var scheduleCits_ = scheduledEventsFromDurs.(dursCits_);
var scheduleInstr_ = scheduledEventsFromDurs.(dursInstr_);

~scheduleCitas = {|voiceIndex, symbol, ratio|
    var citasNotes = citasCan.canon.canon.collect(_.notes)[voiceIndex] - 1;
    [0, {""}]++scheduleCits_.collect({|event, i|
        var cita = citas[citasNotes[i]];
        [event, {cita}]
}).flatten++[{"nel"}]
};

~scheduleInstr = {|voiceIndex, symbol, ratio|
    [0, {""}]++scheduleInstr_.collect({|event, i|
        [event, {instrucciones.choose}]
}).flatten++[{"nel"}]
};
~dursCitas = dursCits_;
~dursInstrucciones = dursInstr_;

//~dursCitas.sum == ~dursInstrucciones.sum
// ~schedule.(0)
)




