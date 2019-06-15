(
//Server.local.options.device = "MOTU Audio ASIO";
s.options.numOutputBusChannels = 8;
s.options.numBuffers = 1024 * 16;
s.boot;
);

// osc info
~netAddr = NetAddr("127.0.0.1", 12000);

// estas variables de control son útiles:
~start = "00:00:00"; // punto de inicio

~playTime = "00:10:00"; // duración de secuencia



// este es el tiempo de la pieza (en teoría)
~initialT = 0;
// ~lengthToPlay = 5400; // dos horas de performance

///////////
Pdef(\ontoClock).play
///////////

(
// variables necesarias:
~initialT = (~start++":000").asSeconds;
~lengthToPlay = (~playTime++":000").asSeconds;
~netAddr.sendMsg("/voice1", ".");
~netAddr.sendMsg("/timer1", "TIME");


// Canon 1
(
Can.converge(\ontoClock,        /*Midiratio*/
	Can.melody((1!~durs.sum),([0,1]!~lengthToPlay).flatten),
	(~lengthToPlay/2).round,
	Can.convoices([3.5,6.0,8.5,11.0],[-12,-10,-8,-6]),
	[\clock],
	~lengthToPlay,//period
	{|id, canon, instruments, repeat = 1|

		var pBindConvPlayer = {|ins, amp, bufnum, out=0, repeat=1|
			{|voice, index|
				index.postln;
				Pbind(
					\instrument, ins,
					\dur, Pseq(([voice.onset] ++ voice.durs ++ [voice.remainder]), repeat),
					\midinote, Pseq([\rest]++voice.notes ++ [\rest], inf),
					\out, out,
					\amp, amp,
					\bufnum, bufnum,
					\seconds, Pseq([0],1)++Pseries(~initialT,1,~lengthToPlay)++Pseq([0],1),
					\time, Pfunc({|event|  event[\seconds].asTimeString.wrapExtend(8).postln  }),
					\cuts, Pfunc({|event|
                        // "algo".postln;
                        switch(event[\seconds].asInteger, *~realschedule);
                        "no te rompas";
                        // switch(event[\seconds].asInteger,
                        //     // aquí es donde componemos los cortes de cada voz;
                        //     ~cutTime[0], {~cuts[0].postln},
                        //     ~cutTime[1], {~cuts[1].postln;~playSections.("primerSeccion",[1,2,3],1,~string).play},
                        //     ~cutTime[2], {~cuts[2].postln},
                        // {"nel"})
					}),
					\timerMsg,
					Pfunc({|event|   ~netAddr.sendMsg("/timer"++index.asSymbol, event[\time])   }),
					\MsgLinea1,
					Pfunc({|event| if( event[\cuts] != "nel",
						{~netAddr.sendMsg("/voice"++index.asSymbol, event[\cuts])},
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

(
~cuts= [
	"",
	"secondCut",
	"time is a piece of ham that hangs from the ceiling XXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
];

~cutTime= [
	4,
	8,
	12
];
)
)










