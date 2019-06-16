// Canon 1
(

Can.converge(\ontoClock,        /*Midiratio*/
	Can.melody((1!~dursCitas.sum),([0,1]!~lengthToPlay).flatten),
	(~lengthToPlay/2).round,
	Can.convoices([13, 14, 15, 16],[-12,-10,-8,-6]),
	[\clock],
	~lengthToPlay,//period
	{|id, canon, instruments, repeat = 1|
        var symbols = canon.collect({|voice| voice.durs[0]}).sort.reverse
        .inject(Dictionary.new, {|acc, d, i| acc.put(d.asSymbol, i.asSymbol)}).debug("durs");
		var pBindConvPlayer = {|ins, amp, bufnum, out=0, repeat=1|
			{|voice, index|
                var ratio = voice.durs[0];
                var durSymbol = symbols.at(ratio.asSymbol);
                var scheduleCitas = ~scheduleCitas.(index, durSymbol, ratio);
				var scheduleInstrucciones = ~scheduleInstr.(index, durSymbol, ratio);
                // canon.debug("vocie");
				Pbind(
					\instrument, ins,
					\dur, Pseq(([voice.onset] ++ voice.durs), repeat),
					\midinote, Pseq([\rest]++voice.notes ++ [\rest], inf),
					\out, out,
					\amp, amp,
					\bufnum, bufnum,
					\seconds, Pseq([0],1)++Pseries(~initialT,1,~lengthToPlay),
					\time, Pfunc({|event|  event[\seconds].asTimeString.wrapExtend(8).postln  }),
					\citas, Pfunc({|event|
                        switch(event[\seconds].asInteger, *scheduleCitas);
                        // "no te rompas, plis";
					}),
					\instrucciones, Pfunc({|event|
						switch(event[\seconds].asInteger, *scheduleCitas)
					}),
					\timerMsg,
					Pfunc({|event| ~netAddr.sendMsg("/timer"++index.asSymbol, event[\time])}),
					\MsgLinea1,
					Pfunc({|event| if( event[\citas] != "nel",
						{~netAddr.sendMsg("/voice"++index.asSymbol, event[\citas])},
						{"noMsg"}
					)
					})
				)
			}
		};


		var conv = canon
		.collect(
			pBindConvPlayer.(
				\clock,
				bufnum: Pseq(~manecillas[0..5], inf),
				amp: 1,
				out: 0,
				repeat: repeat
			)
		);


		Pdef(id ? UniqueID.next.asSymbol, Ppar(conv.postln), repeat);

	}
)
);

