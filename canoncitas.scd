s.boot
(

var repeats = [7,4,3,6,2,1,5];
var citas = [1,2,3,4,5,6,7].collect({|c, i| c!(repeats[i])}).flatten;
var durs = citas.collect({|x, i| [1,2,3,2].wrapAt(i)});
~citas = FluentCan(\citas, durs: durs, notes: citas, transps: [_.rotate(0), _.rotate(-1), _.rotate(-2), _.rotate(-3)], tempos: [60, 60, 60, 60]*4, cp: 7+4+3);

//converts a list of durations into moments in time
~scheduledEventsFromDurs = {|durs|
    var result = durs.inject([0], {|acc, dur| acc ++ (acc.last + dur)});
    result[0..result.size -2]; // las event is the moment at which the sequence ends, so we remove it
};


~durs = (~citas.canon.canon.collect(_.durs)[0].normalizeSum*~lengthToPlay).collect(_.round);
~schedule = ~scheduledEventsFromDurs.(~durs).postln;
)
(
~realschedule = ~schedule.collect([_, {
    ~playSections.([1,2,3,5], 1, "instrucción").play
}]).flatten

)
// switch(*[1, 1, {"uno".postln}])

// switch(0, *~realschedule)